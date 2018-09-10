---
layout: post
section-type: post
title: deephypebot&#58; an overview
category: DL
tags: [ 'openai' ]
---

## Motivation

[@deephypebot](https://twitter.com/deephypebot) is a music commentary generator. It is essentially a _language model_, trained on past human music writing from the web and conditioned on attributes of the referenced music. There is an additional training step that attempts to encourage a certain type of descriptive, almost flowery writing commonly found in this genre.

Our goal is to teach this language model to generate consistently good and entertaining new writing about songs.

## Project Achievements

- Model inference through pre-trained LC-GAN + CVAE deep learning architecture (details below)
- Functional, documented pipeline code ([GitHub repo](https://github.com/iconix/deephypebot))
- A technical white paper (_coming soon_)

## Architecture

![Software architecture](/img/posts/deephypebot-software.svg)

### Training data

My training data consists of ~20,000 blog posts with writing about individual songs. The count started at about 80K post links from 5 years of popular songs on the music blog aggregator [Hype Machine](https://hypem.com/) - then I filtered for English, non-aggregated (i.e., excluding "round up"-style posts about multiple songs) posts about songs that can be found on Spotify. There was some additional attrition due to many post links no longer existing. I did some additional manual cleanup of symbols, markdown, and writing that I deemed _non_-commentary.

From there, I split the commentary into ~104,500 sentences, which are a good length for a _variational autoencoder_ (VAE) model to encode.

### Neural network

A _language model_ (LM) is an approach to generating text by estimating the probability distribution over sequences of linguistic units (characters, words, sentences). This project centers around a _sequence-to-sequence conditional variational autoencoder_ ([seq2seq CVAE](/dl/2018/06/29/energy-and-vae#seq2seq-vae-for-text-generation)) model that generates text conditioned on a thought vector `z` + attributes of the referenced music `a` (simply concatenated together as `<z,a>`). The conditioned embedding fed into the CVAE is provided by an additional _latent constraints generative adversarial network_ ([LC-GAN](/dl/2018/07/28/lcgan)) model that helps control aspects of the generated text.

The CVAE consists of an LSTM-based encoder and decoder, and once trained, the decoder can be used independently as a language model conditioned on latent space `<z,a>` (more on seq2seq VAEs [here](/dl/2018/06/29/energy-and-vae#seq2seq-vae-for-text-generation)). The musical attributes info conditions only the VAE decoder.

![seq2seq text VAE architecture](/img/posts/seq2seq_vae_text.png)
<small>An *un*conditioned seq2seq text VAE. Replace `z` with `<z,a>` for a CVAE. Figure taken from Bowman et al., 2016. [_Generating Sentences from a Continuous Space_](https://arxiv.org/abs/1511.06349).</small>

The LC-GAN is used to determine which conditioned embeddings `<z,a>` fed into the decoder of this LM tend to generate samples with particular attributes (more on the LC-GAN [here](/dl/2018/07/28/lcgan)). This project uses LDA topic modeling as an automatic reward function that works with the LC-GAN to encourage samples of a descriptive, almost flowery style (more on LDA topic modeling [here](/dl/2018/08/24/project-notes-2)). The LDA topic distribution for the sentence associated with the `<z,a>` input provides the label `v`. The generator is trained to generate a `z` such that, when combined with `a`, `<z,a>` gives the ideal topic distribution `v`, as measured by the discriminator. Once trained, the generator can be used independently to provide these conditioned embeddings to the CVAE for inference.

![LC-GAN architecture](/img/posts/LC-GAN-conditioned.svg)
<small>LC-GAN architecture.</small>

The CVAE code used for this project is available here: **<https://github.com/iconix/pytorch-text-vae>**.

The LC-GAN code used for this project is available here: **<https://github.com/iconix/openai/blob/master/nbs/lcgan.ipynb>**.

### Making inference requests to the network

Now that the neural network is accounted for, let's discuss the engineering pipeline required to support inference live on Twitter.

While the model was developed in Python ([PyTorch](https://pytorch.org/), [conda](https://conda.io/docs/) environment manager), the pipeline is written using [Node.js](https://nodejs.org/en/) in order to run server-side JavaScript. This is due to how many convenient libraries already exist on [npm](https://www.npmjs.com/) for communicating with external services. The pipeline has two main components: a worker process and a multi-endpoint [Express.js](https://expressjs.com/) web service.

The web service essentially wraps existing APIs for Google Sheets, Spotify, and Twitter, providing a more convenient set of APIs to the worker.  The worker process monitors Twitter at an interval (currently every 60s) for new tweets to appear on [@deephypebot](http://twitter.com/deephypebot)'s home timeline. New tweets are defined as any tweets that have occurred since the last tweet processed by this workflow (max as enforced by the Twitter API: 200 tweets). New tweets are parsed for song and artist information, and if this is found, the information is passed on to Spotify. If Spotify accepts and responds with [genre](https://developer.spotify.com/documentation/web-api/reference/artists/get-artist/) information, this is then passed to the neural network (which is deployed behind a [Flask](http://flask.pocoo.org/) endpoint) for conditioned language modeling.

### From samples to tweets

Once multiple samples of commentary for a new proposed tweet are generated, they are added to a spreadsheet where the human curator (me) can select which samples are released to [@deephypebot](http://twitter.com/deephypebot) for tweeting.

Text generation is [a notoriously messy affair](/dl/2018/06/20/arxiv-song-titles#text-generation-is-a-messy-affair) where "you will not get quality generated text 100% of the time, even with a heavily-trained neural network." While much effort will be put into having as automated and clean a pipeline as possible, some human supervision is prudent.

Check out [@deephypebot](http://twitter.com/deephypebot)'s live timeline below for a "best of" collection of automatically generated music commentary!

<a class="twitter-timeline" data-tweet-limit="4" href="https://twitter.com/deephypebot?ref_src=twsrc%5Etfw">Tweets by deephypebot</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<small>_Note_: these retweets are best viewed on Twitter, where you can see the original tweets being replied to!</small>

## What I've Learned This Summer

I have a friend currently in a bioscience PhD program who likened my summer to a [lab rotation](https://en.wikipedia.org/wiki/Laboratory_rotation) (or two) during the first year of a PhD program. I essentially got a 13-week test run of what it might look like to join a great AI lab.

This summer has been an intense foray into the independence and self-determination required for graduate studies, and I couldn't have done it without a solid support system! My biggest thanks goes to my program mentor, [**Natasha Jaques**](https://twitter.com/natashajaques), who never failed to balance her own intensive research this summer with helping me out by proofreading my blog posts, explaining concepts on the whiteboard, providing me with access to other top experts in the field, brainstorming and debugging, and just generally encouraging and cheering me on. Thanks to program director **Larissa Schiavo** for keeping us together as a cohort and on track throughout the summer, always ready to unblock or assist us as needed. Thanks to my fellow Scholars for being truly brilliant and good-natured folks: **[Christine](http://christinemcleavey.com/), [Dolapo](https://codedolapo.wordpress.com/), [Hannah](http://www.hannahishere.com/), [Holly](https://hollygrimm.com/), [Ifu](https://www.lifeasalgorithm.com/), [Munashe](http://everyd-ai.com/), and [Sophia](https://medium.com/@sophiaarakelyan)**. Last but not least, thanks to the **family, friends, and coworkers both at Microsoft OneNote and the OpenAI offices** for supporting me with places to work and stay across the country, as well as with room to grow on this summer "sabbatical."

I am grateful for the time and space that this program provided me with to self-study at the intersection of deep learning and NLP. I learned about and experimented with [n-gram language models](/dl/2018/06/08/scholar-week1#part-ii-generating-terrible-music-reviews-with-n-grams), [recurrent neural networks](/dl/2018/06/15/scholar-week2), [conditioned LSTMs](/dl/2018/06/22/scholar-week3), [seq2seq VAEs](/dl/2018/06/29/energy-and-vae), the [attention mechanism](/dl/2018/07/06/not-enough-attention#understanding-attention), various methods of [interpreting model predictions](/dl/2018/07/13/interpret-attn), [VAE latent space and selection bias](/dl/2018/07/21/bias-and-space), [GANs](/dl/2018/07/28/lcgan), and [LDA topic modeling](/dl/2018/08/24/project-notes-2). I dug deep into [a single data set](/dl/2018/08/14/project-notes-1) that I collected and gradually cleaned all summer, a particularly valuable exercise for me.

I found and refined my blogging voice, including more visual storytelling than ever before. I am much more comfortable working with deep learning frameworks, especially PyTorch and Keras. And I now have experience building an end-to-end, deep learning product in [@deephypebot](https://github.com/iconix/deephypebot/). Kudos all around!

## Future Plans

- Moving back east!
- Going broader on/experimenting more with creative applications in ML - both new and existing.
- Even more explorations with NLP and language.

Thanks to everyone who has followed my journey as an OpenAI Scholar! You can find me [**on Twitter**](https://twitter.com/ohnadj).

### _Follow my progress this summer with this blog's [#openai](/tags/openai) tag, or on [GitHub](https://github.com/iconix/openai)._
