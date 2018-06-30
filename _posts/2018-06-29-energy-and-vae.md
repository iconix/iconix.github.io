---
layout: post
section-type: post
title: Energy and VAE
category: DL
tags: []
---

Welcome to week 4! The end of this week marks the halfway point of my [syllabus](https://github.com/iconix/openai/blob/master/syllabus.md) for the Scholars program (wow). Four more weeks until my final project begins!

I split my attention between learning about _sequence-to-sequence_ (seq2seq) models and _variational autoencoders_ (VAE), while also tinkering with my LSTM-based language model from weeks 2-3.

_To skip to ahead to seq2seq VAEs for text generation, [click here](/dl/2018/06/29/energy-and-vae#seq2seq-vae-for-text-generation)._

## 'Energy'-conditioned language model

[Last week](/dl/2018/06/22/scholar-week3#part-ii-how-fastai-handles-languagemodel-data), I discussed the speed bumps I hit while trying to get the `fastai` library to support an additional contextual `Field` in my language model data. By Tuesday, I had a `ContextLanguageModelLoader` working, based on local modifications to `fastai.nlp.LanguageModelLoader`[^context-lml]. I can now pass extra context for my language model to condition on!

This week, I conditioned each _word_ fed into my LSTM-based language model on [Spotify's definition of energy](https://developer.spotify.com/documentation/web-api/reference/tracks/get-audio-features/):

> _**Energy is** a measure from 0.0 to 1.0 and represents a perceptual measure of **intensity** and **activity**. Typically, **energetic tracks feel fast, loud, and noisy**. For example, death metal has high energy, while a Bach prelude scores low on the scale. Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy._

Energy seemed like a great piece of context to include: I figured the perceived energy of a song would translate fairly distinctly to any writing about the song![^genre]

To do this practically, in my model's `forward` pass, I concatenated _each_ word embedding with Spotify's floating point `energy` value for whatever song the word helped describe. So if the word embedding size was 300, after the concat, it became 301. Then I trained on 15K reviews for 50 epochs (perplexity=130, aka not great[^ppl]).

My preliminary results are pretty interesting! The generated text itself is still as garbled and hard to read as last week's... _but_ things get more interesting if we take a look at **what words generated most frequently** at the highest energy (`1.0`) vs. the lowest energy (`0.0`).

I sampled 10K words from each energy context; filtered out the [NLTK English stopwords](https://www.nltk.org/book/ch02.html#wordlist-corpora), punctuation, and numbers; then finally counted word frequencies.

<table style='border: none'>
    <tr>
        <th>Frequent words sampled with <span style='color: #3BBB75'><strong>high energy</strong></span> conditioning</th>
        <th>Frequent words sampled with <span style='color: #471164'><strong>low energy</strong></span> conditioning</th>
    </tr>
    <tr>
        <td style='border: none'>
            <img src='/img/posts/full_energy_wc_wk4.png' alt='Word cloud of high-energy words'>
        </td>
        <td style='border: none'>
            <img src='/img/posts/no_energy_wc_wk4.png' alt='Word cloud of low-energy words'>
        </td>
    </tr>
</table>

I then immediately began speculating about what these word clouds[^wc] could represent! Here's a quick <span style='color: #3BBB75'><strong>high energy</strong></span> vs. <span style='color: #471164'><strong>low energy</strong></span> comparison:
- <span style='color: #3BBB75'><strong>California & Caribbean</strong></span> vs. <span style='color: #471164'><strong>Germany & Ireland</strong></span>
- <span style='color: #3BBB75'><strong>Pop & Thai funk</strong></span> vs. <span style='color: #471164'><strong>Rock & Rave music</strong></span>
- <span style='color: #3BBB75'><strong>Britney</strong></span> vs. <span style='color: #471164'><strong>Christopher</strong></span>
- <span style='color: #3BBB75'><strong>Fields</strong></span> vs. <span style='color: #471164'><strong>Rooms</strong></span>
- <span style='color: #3BBB75'><strong>Mates (friends, bonds)</strong></span> vs. <span style='color: #471164'><strong>Abandonment</strong></span>

Again, all pure speculation! There were also words like _cradling_ and _soul_ for "high energy" and _whole_ for "low energy" that I didn't quite associate. And there's clearly some interesting _biases_ going on here (e.g., location associations). But all in all, it does feel like the conditioned model learned a little extra something!

For a much more detailed analysis of the word clouds, check out the bottom of [my work notebook](http://nbviewer.jupyter.org/github/iconix/openai/blob/master/nbs/week3_reviews_by_songs.ipynb)! Can you spot any other associations?

## seq2seq vae for text generation

My goal for this section was to understand what the heck a "sequence-to-sequence (seq2seq)" "variational" "autoencoder" (VAE) is - three phrases I had only light exposure to beforehand - and why it might be better than my regular ol' language model. I also wanted to try my hand at training such a network.

I'll give a quick overview of what I learned this week and then point towards really excellent resources that explain these concepts much better than I can.

### Why?

What do I stand to gain from a seq2seq VAE, compared to the traditional LSTM language model (LSTM-LM)?

Recall that the LSTM-LM models a joint probability distribution over sequences - meaning, it models the next word in a sequence given the previous words:

$$p(x) = \prod_{i=1}^{n} p(x_i \mid x_1,...,x_i-1)$$

The _novelty_ of the network's generations comes from sampling over all next word probabilities from the LSTM-LM's output distribution.

However, nothing else about generating a sample produces random variability. The joint probability distribution equation above is entirely deterministic, as it is based on the sequences in the training data. It would be better for the goal of producing _novel generations_ if I could introduce more variability to the process.

I also have a goal of producing more _topical generations_ that capture meaning and style and other more abstract characteristics of writing. So it would be useful for the variability I introduce to still respect that the samples should have complex structure and strong dependencies.

### How?

The seq2seq VAE approach promises more _novel yet topical_ generated text. Let's break down each part of the name.

`seq2seq`: a type of network where both the input and output of the network are variable-length sequences. It consists of one RNN that _encodes_ the input sequence, then hands its encoding to another RNN which _decodes_ the encoding into a target sequence.
- The intermediate "encoding" is known as the `hidden code`, and it represents a compressed representation of what knowledge was needed for the `encoder-decoder` network to translate from input to target.

`autoencoder`: a technique that uses identical data as both the input and target data for the `encoder-decoder` network. The cool thing here is that the `hidden code` will be a _latent_ (hidden) representation of the singular data provided (rather than a latent representation of some translation).

`variational`: a modification to the `autoencoder` that allows the `hidden code` to represent an entire distribution (rather than a fixed vector). This is cool because whenever you need a vector to feed through the `decoder` network, you can simply sample one (usually called `z`) from the `hidden code` distribution (`encoder` not required for generation!).

Put this all together and you have a network that can first learn to represent your text in a compressed form, and then use that representation to generate new samples! This satisfies my _more novelty_ goal because I can randomly sample `z` from the latent space of the `hidden code`. This satisfies my _more topical_ goal because this `hidden code` must represent more global properties of the text, and so using it to generate text should incorporate more abstract knowledge than the LSTM-LM could when predicting word-by-word.

![seq2seq vae language model](/img/posts/seq2seq_vae_text.png)
_Image courtesy of Bowman, S. R., Vilnis, L., Vinyals, O., Dai, A.M., Jozefowicz, R., Bengio, S (2016). ["Generating Sentences from a Continuous Space"](https://arxiv.org/abs/1511.06349)._

I had several really excellent resources to guide my learning this week.

**seq2seq**:
1. Sutskever, I., Vinyals, O., and Le, Q. V. (2014). [_Sequence to sequence learning with neural networks_](https://arxiv.org/abs/1409.3215).
- Me from 4 weeks ago would have rolled my eyes and sighed at this suggestion - but I swear this paper is readable! All you need is a solid understanding of RNNs/LSTMs because they are the building blocks.
2. A Practical PyTorch tutorial: [Translation with a Sequence to Sequence Network and Attention](https://github.com/spro/practical-pytorch/blob/master/seq2seq-translation/seq2seq-translation-batched.ipynb)
- For if you reallyyy don't want to start with the paper (I do understand) :slightly_smiling_face: Even if you don't care to implement anything in PyTorch, the words surrounding the code are good at explaining the concepts.

**VAEs**:
1. I highly recommend this YouTube video as an ["Introduction to Variational Autoencoders"](https://youtu.be/9zKuYvjFFS8)!
2. Once ready for some technical prose and code, check out Miriam Shiffman's series on VAEs: an [introduction](http://blog.fastforwardlabs.com/2016/08/12/introducing-variational-autoencoders-in-prose-and.html) and [under the hood](http://blog.fastforwardlabs.com/2016/08/22/under-the-hood-of-the-variational-autoencoder-in.html).
3. For a focus on text VAEs (another paper!): Bowman, S. R., Vilnis, L., Vinyals, O., Dai, A.M., Jozefowicz, R., Bengio, S (2016). [_Generating Sentences from a Continuous Space_](https://arxiv.org/abs/1511.06349).

### Experiments

I also dabbled with training a seq2seq VAE. I found some code at [`kastnerkyle/pytorch-text-vae`](https://github.com/kastnerkyle/pytorch-text-vae), updated it for Python 3 and PyTorch 0.4, and let it go!

The decoder seemed quite capable of re-generating song titles using the hidden code. I then tried full-text song reviews... until I noticed that **this encoding technique is meant for sentence representations**. It all seems to break pretty hard if you go above a sentence. The Bowman et al. paper stuck to sentence representations, and even then, it mentions:
> _As the sentences get longer, the fidelity of the round-tripped sentences decreases._

When I split the reviews into sentences, it then became capable of re-generating them (makes sense this is comparable to song titles).

The code I was using didn't implement sampling, but it did implement something called _homotopy_, or the linear interpolation between sentences. From Bowman et al.:
>  _Similarly, the homotopy between two sentences decoded (greedily) from codes `z1` and `z2` is the set of sentences decoded from the codes on the line. Examining these homotopies allows us to get a sense of what neighborhoods in code space look like – how the autoencoder organizes information and what it regards as a continuous deformation between two sentences._

After training on review sentences for a long while, I could generate homotopies. The first column uses the same `s0` and `s1` as the code repo; the second uses the same as the paper.

Repo example | Paper example
--- | ---
(s0) _it had taken years to believe_ | (s0) _he was silent for a long moment_
(z0)  it categories hip hop for something | (z0)  i was working for a long moment
(...)  it was last weekend and disco |  (...)  i was hell for a long moment
(...)  it was nothing but the weekend | (...)  i was me for a long moment
(...)  it was all weekend at the end | (...)  i was me in a moment
(z1)  it was it all weekend at the end | (...)  it was one in my least
(s1) _but it was all lies at the end_ | (z1)  did it song in my leave
                                    | (s1) _it was my turn_

<br />

Different data sets, different interpolations!

## Some work notes

Highlights:
- Finally started using `pdb` this week - extremely helpful for inspecting model inputs and outputs and dimensions when writing the `ContextLanguageModelLoader`

Future improvements:
- Desperately need gains in efficiency of model training. I need to break my habit of watching models train :sweat_smile::
    - parallel jobs
    - hyperparameter sweeps
    - organized experiments
    - framework for saving and continuing training
- If I need to break all reviews into sentences to train the VAE, how do I associate each sentence with its review/song?

---
That's all for this week. Next week should be a great one: all about attention!

#### Footnotes

[^context-lml]: To see what I modified to make context work, search for `ContextLanguageModelLoader` in this [notebook](http://nbviewer.jupyter.org/github/iconix/openai/blob/master/nbs/week3_reviews_by_songs.ipynb).
[^genre]: Last week, I discussed wanting to condition on song genres. However, a quick spot check placed doubts in my mind about the accuracy of the labels I scraped from the web. So I've switched to energy, and I plan to condition on multiple Spotify audio features in the future.
[^ppl]: I haven't mentioned _perplexity_ since my [week 1 notebook](http://nbviewer.jupyter.org/github/iconix/openai/blob/master/nbs/n-gram%20music%20reviews.ipynb), but it's a standard language model measure for how well a model fits a test corpus. It can be calculated by taking the exponent of cross-entropy loss.
[^wc]: Word clouds courtesy of [https://github.com/amueller/word_cloud](https://github.com/amueller/word_cloud)
[^holes]: An [example](https://glamglare.com/music/2018/04/12/song-pick-juliana-daugherty-player/): "_starts on just guitar and vocals but slowly opens up into a more cinematic space. It is a story about the experience of watching someone close to you disappear down a rabbit hole_"
