---
layout: post
section-type: post
title: A Musical Arxiv Experiment
category: DL
tags: [ 'openai' ]
---

This post is inspired by researcher [Janelle Shane](https://twitter.com/JanelleCShane) and her blog [aiweirdness.com](http://aiweirdness.com/), where she trains neural networks and lets them "be weird" :slightly_smiling_face:

Shane recently experimented with [generating metal band ice cream flavors](http://aiweirdness.com/post/173797162852/ai-scream-for-ice-cream)[^austin], and my mentor Natasha and I (and a lot of [Twitter](https://twitter.com/JanelleCShane/status/997190921958473729)) were highly entertained by them. We chatted about how I could generate some weird things during my [OpenAI Scholar summer](/dl/2018/05/30/openai-scholar) too. And since I'm working in deep learning with data about songs, we thought:

> _song titles + deep learning paper titles from arXiv[^arxiv] = something hilarious???_

### Fickle Alchemy

Throughout my experimentation this week, these two sets of titles tried their darndest not to mix with each other - so sad! Many, many of the results were clearly either **only influenced by deep learning**:

> Structural Model for Deep Learning for Parallel Problem Evolutional Recognition
>
> Quee Reflet : Semi-Supervised A Learning-Model and Hierarchical Variational Architrate Networks for Invementation Selection

...or **only influenced by songs**:

> Love Me Down (Manis Edit)
>
> Boy (feat. Stron The Remix)

But right at the beginning, after just 2 training epochs and 9 samples, things we're looking **promising with these samples**:

> Flexing To The Study
>
> Embedding feat. Cetya Readm

Amazing! Thanks to [textgenrnn](https://github.com/minimaxir/textgenrnn), this fun side experiment was all set to be a breeze, right?

Well, I got misleadingly lucky on those very first two epochs because my samples didn't achieve hilarity like that again for a while. I probably generated well over 500 samples total. Things got a bit frustrating - I was mostly sampling boring-sounding deep learning paper titles.

But occasionally, the titles would play together as intended!

### What seemed to help

Overall, my strategy was to encourage song/arXiv mixing by ensuring my network didn't overfit to any particular training data.

- A **character-based network**: my word-based experimentation seemed to result in even less arXiv/song mixing - plus textgenrnn is robust enough to still generate real words even while predicting a character at a time!
- **Higher temperatures**: this let the network be 'creative' in its sampling by letting it predict lower probability characters to continue a sequence.
- **Dropout**: this purposefully added some chaos to the network by randomly removing parts of the text while training.
- **Smaller `max_length`**: this forced the network to work with a smaller memory by limiting the number of previous characters it could use to predict the next character.
- **Fewer epochs**: this limited training time because textgenrnn is so robust that it quickly gets _too_ good at telling the difference between songs and arXiv papers.
- **Mixing up the titles in a single text file**: Shane mentioned that she (accidentally) pre-trained on only metal bands first and then used _transfer learning_ to add in ice cream flavors. I tried this too, but the network seemed to immediately forget what the first thing it learned was and would just generate the second thing. This is known as [_catastrophic forgetting_](https://en.wikipedia.org/wiki/Catastrophic_interference), which is the tendency for a neural network to completely erase what it learned about a first task when training on a second task in sequence. I got better results from just mixing the two sets of titles together and training in one go.
- **Balancing the number of titles from each set**: this encouraged the network to learn from each set evenly.

I would definitely still get meh results, but adjusting these configurations seemed to improve chances of generating something fun.

### Text generation is a messy affair

I think the textgenrnn project says this well in its disclaimer:

> **You will not get quality generated text 100% of the time**, even with a heavily-trained neural network ... NN text generation often generate lots of texts and [you'll need to] curate/edit the best ones afterward.

And indeed, lots of curating and editing went into my 'best of' list!

### Best of

After much tinkering and sampling, I did eventually achieve some fun mashup titles! Here are my favorites:

> Flexing To The Study
>
> Embedding feat. Ceyta Readm
>
> Strong (feat. Salial Networks)
>
> Moon (feat. Ligoning for Structured Remix)[^remix]
>
> Completion and Continuous remix
>
> State (Feat. Kanna Alignment Algorithms)
>
> Like You Way To (Original Learning[^original] from a Hadcer convex framework)
>
> Space Camera & Anomaly[^band]
>
> Correction in Remix
>
> Automatic Samples for sea Remix
>
> Silver (Sving Recognitive Network prooft Remix)
>
> A Subspaces
>
> Learning Theory (Live Self Model)[^live]
>
> A Problems of Gents
>
> Task2Quous Dreams
>
> Drop Loud
>
> DeepSEGK: A Reconstruction[^album]
>
> DeepMe (feat. Remix)
>
> Framework for Subspace (Dance of Resolutional Networks)
>
> An Every of Localization Me Down (feat. A. Gradi)
>
> Deep Sentiment of Character[^just-deep]
>
> Semantic Segmentation in Semantic Segmentation

You can check out my [work notebook](http://nbviewer.jupyter.org/github/iconix/openai/blob/master/nbs/textgenrnn_deep_song_titles.ipynb) for the messier results (and check out [older commits](https://github.com/iconix/openai/commits/master/nbs/textgenrnn_deep_song_titles.ipynb) too with more samples).

This was a lot of fun for me! People like Janelle Shane sharing experiments like these are what got me interested in text generation in the first place :slightly_smiling_face: I hope you enjoyed this as well!

### _Follow my progress this summer with this blog's [#openai](/tags/openai) tag, or on [GitHub](https://github.com/iconix/openai)._

#### Footnotes

[^austin]: And shout out to the Austin middle school coding class who provided Shane with the original dataset of 1,600 ice cream flavors - sweeet!
[^arxiv]: [arXiv](https://arxiv.org/) (pronounced like 'archive') has become the go-to open repository for the latest deep learning papers. The paper titles I used here were grabbed from the [Brundage Bot collection of arXiv papers](https://github.com/amauboussin/arxiv-twitterbot).
[^remix]: The most surefire way my network found to create a mashup title was to add "remix" to the end.
[^original]: This reminded me of tracks that add "(original mix)" or "(original score)" to the end.
[^band]: Could also be a hipster band name.
[^live]: Live tracks too, huh?
[^album]: Nice album title as well IMO.
[^just-deep]: The last two didn't actually mix with song titles at all... but they still seemed musical to me.