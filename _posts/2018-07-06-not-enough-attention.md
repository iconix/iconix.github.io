---
layout: post
section-type: post
title: Not Enough Attention
category: DL
tags: [ 'openai' ]
---

_Attention week: what an ironic week to get distracted._

My stated goal for week 5 was to **adapt an LSTM-LM[^lstm-lm] to do classification _with_ attention**. Because I still don't trust the genre labels I pulled from the web (as mentioned [last week](/dl/2018/06/29/energy-and-vae#fn:genre)), I decided I would try to **enter a Kaggle competition** that would provide a cleaned, labeled data set to work with.

I chose to work on the [Movie Review Sentiment Analysis](https://www.kaggle.com/c/movie-review-sentiment-analysis-kernels-only/) competition (kernels only), one of the only two active NLP competitions at the moment. It's a "Playground Code Competition" and the prize is "knowledge" rather than, say, [$70,000](https://www.kaggle.com/c/home-credit-default-risk).

This week, I spent much more time on figuring out transfer learning with LSTM-LMs (plus applying last week's seq2seq VAE learnings) than I did on applying attention. Meanwhile, attention received a high-level treatment.

<small>_To skip ahead to my attention explainer, [click here](#understanding-attention)._</small>

## Kaggle + ULMFiT

![The high level ULMFiT approach](/img/posts/ulmfit-approach.png)
<small>_The high level ULMFiT approach. Image courtesy of ["Introducing state of the art text classification with universal language models"](http://nlp.fast.ai/classification/2018/05/15/introducting-ulmfit.html) by Jeremy Howard and Sebastian Ruder._</small>

I did eventually enter the competition, but _without_ an attention mechanism (I talk more about why [later](#diversions-and-a-breakthrough)). This is the first Kaggle competition I've entered [without a lot of hand holding](/portfolio-building/2017/07/26/first-kaggle). I wrote about the pre-training process I used to enter the competition in my data set description:

> _Check out [**https://www.kaggle.com/iconix/ulmfit-rt/home**](https://www.kaggle.com/iconix/ulmfit-rt) for more details about my entry!_

My entry is currently in the top 50%, which is ok-ish (top 5 public kernels though!).

![Entry #1 for Kaggle's movie-review-sentiment-analysis-kernels-only](/img/posts/kaggle-movie-entry1.png)
<small>_If you're wondering why "Phil's Old High Score" is distinctly highlighted (like I was): Phil Culliton of Kaggle [explained](https://www.kaggle.com/c/movie-review-sentiment-analysis-kernels-only/discussion/59490) that it's meant to be a **benchmark** from a previous run of this competition. #themoreyouknow_</small>

At the beginning of this week, I didn't know what Kaggle meant by a "[kernels](http://blog.kaggle.com/2016/07/08/kaggle-kernel-a-new-name-for-scripts/) only" competition. I ended up understanding and liking how kernels encouraged me to **clean up, document, and share my work**. I appreciated being able to peek at other public kernels to see other approaches and simple tricks (like an efficient way to create the submission .csv). It's a neat, reproducible system, and while the web-based interface was buggy at times, it's ultimately well-designed and flexible.

I'd like to re-enter the competition with the _attention_ mechanism I originally intended to add. But first, what is attention anyway?

## Understanding attention

![An attentional encoder-decoder network animation](/img/posts/nmt-model.gif)
<small>_An attentional encoder-decoder network for neural machine translation. From Distill's ["Attention and Augmented Recurrent Neural Networks"](https://distill.pub/2016/augmented-rnns/)._</small>

Attention is usually discussed in the context of regular (i.e., not auto) encoder-decoder networks[^no-vae].

For regular encoder-decoder networks (doing tasks like neural machine translation), the thought vector is a clear bottleneck. While the thought vector encourages *auto*encoders to learn useful features of the data (rather than acting as the identity function), it is limiting for regular encoder-decoders.

It turns out this limit is unnecessary. Attention extends the encoder-decoder network by enabling the network to perform a sort of _soft search_ for the most relevant information in the source sequence while predicting the target word. Rather than a single thought vector, each target word gets a distinct context vector, and attention allows the decoder to selectively retrieve information spread across these vectors.

Here's how the attentive network described in the seminal [Bahdanau et al. paper](https://arxiv.org/abs/1409.0473) works:

1. A bidirectional RNN encoder _annotates_ each word in the sequence with info about the words surrounding it (both preceding and following, since it's bidirectional). The annotation is simply a concatenation of the forward and backward hidden states of the word.
2. For each target word to predict, the RNN decoder is provided a distinct _context vector_ (contrast this with the single thought vector). Each context vector is a weighted sum or weighted average of the annotations provided by the encoder.
3. The _weights_ assigned to the annotations are determined by the **attention mechanism**, which is a feedforward (i.e., no loops) network in front of the decoder. Intuitively, the attention mechanism uses these weights to decide which annotations each word "pays attention" to.

Because one can inspect these weight assignments to see what the decoder pays attention to at any given time step, attention can boost the interpretability of a network. You can even visualize what a network attended to at each step, as the Bahdanau et al. paper and GIF above demonstrate.

### Self-attention

I will also touch briefly on the _self-attention_ (or intra-attention) mechanism, first introduced by Paulus et al. in [_A Deep Reinforced Model for Abstractive Summarization_ (2017)](https://arxiv.org/abs/1705.04304) and then popularized by the Transformer architecture introduced in the [_Attention Is All You Need_ (2017)](https://arxiv.org/abs/1706.03762) paper by Vaswani et al.

While the original attention mechanism learns dependencies _between_ a source and target sequence, **self-attention learns dependencies _within_ a single sequence**. It computes the relevance and relationships of the other words in the sequence to the target word. This idea is so powerful that the Transformer architecture was able to completely eliminate the RNN encoder and decoder, replacing them with self-attention for learning how the words in a sequence relate!

Self-attention has a few other advantages:
- Long-distance dependencies are more manageable because relationships between words are modeled as positionally invariant.
- Unlike RNNs, self-attention does not rely on sequential processing, so computations can happen in parallel (taking advantage of what GPUs do best).
- Using self-attention for seq2seq is more computationally efficient (fewer number of steps) than both RNN-based _and_ [convolution-based](https://arxiv.org/abs/1705.03122) seq2seq networks.

I'll leave off with my favorite visualization from Google's blog post on the ["Transformer: A Novel Neural Network Architecture for Language Understanding"](https://ai.googleblog.com/2017/08/transformer-novel-neural-network.html):

![Transformer handling coreference resolution](/img/posts/self-attention-coreference.png)
<small>_How the Transformer works: it "starts by generating initial representations, or embeddings, for each word. ... Then, using self-attention, it aggregates information from all of the other words, generating a new representation per word informed by the entire context. ... This step is then repeated multiple times in parallel for all words, successively generating new representations."_</small>

The Transformer's ability to understand that "it" is the "animal" in the context of "it" being "tired", while "it" is the "street" in the context of "it" being "wide" (also known as _coreference resolution_) -- that's totally bonkers to me.

Definitely do check out the full [blog post](https://ai.googleblog.com/2017/08/transformer-novel-neural-network.html) and [paper](https://arxiv.org/abs/1706.03762)!

## Diversions and a Breakthrough

On a more personal note, I'd feel amiss not to talk about the struggle I've had with sticking to my own schedule this summer, and the mental shift I'm working to embrace.

Here's a non-exhaustive list of things that ended up distracting me from my stated topic of the attention mechanism this week:
- Ramping up on the competition's Rotten Tomatoes movie review data set (the format was _not_ what I was expecting).
- Ramping up on using language model transfer learning and fine-tuning for text classification (à la [ULMFiT](http://nlp.fast.ai/category/classification.html)).
- Getting lackluster results with said transfer learning using the competition data, then figuring out that fine-tuning with IMDB first worked much better.
- Trying to make a dent in my [model training infrastructure debt](/dl/2018/06/29/energy-and-vae#work-notes).
- Adding sampling to my seq2seq VAE code fork from last week[^sample-code].

And I could have made a similar list every week of the program so far.

I've been trying to fight through a pattern that's emerged week after week for me so far as a scholar -- and I think I'd do better to just embrace the pattern. When designing my [syllabus](https://github.com/iconix/openai/blob/master/syllabus.md), I scheduled one full week each to **both learn _and_ implement some heavy topics**: [RNNs](/dl/2018/06/15/scholar-week2), [conditioned LSTMs](/dl/2018/06/22/scholar-week3), [seq2seq VAEs](/dl/2018/06/29/energy-and-vae), and now the [attention mechanism](#understanding-attention).

But with each topic so far, it's taken me about that one week just to understand the concepts at a high-level and start tinkering with code. I've only internalized each topic well enough to reasonably apply it by the following week.

**So instead of feeling like I'm failing in some way every week, I am taking the hint that I just need a little more time with these topics, and that is totally fine.** My syllabus has provided me with a clear, instructive path through the first 8 weeks of the program, and even if slightly delayed -- I'm making a lot of progress, and I'm getting stuff done. This is what matters.

---
Next week, I expect to implement attention in an LSTM-LM model, as part of my first week on model interpretability (a topic I am particularly excited about).

### _Follow my progress this summer with this blog's [#openai](/tags/openai) tag, or on [GitHub](https://github.com/iconix/openai)._

#### Footnotes

[^lstm-lm]: I started using the acronym `LSTM-LM` last week to mean LSTM-based Language Models. And while we're here, a reminder that `LSTM` stands for Long Short-Term Memory ([good explainer](http://www.wildml.com/2015/10/recurrent-neural-network-tutorial-part-4-implementing-a-grulstm-rnn-with-python-and-theano/)). Later, `seq2seq VAE` == Sequence-to-Sequence Variational Autoencoder; `RNN` == Recurrent Neural Network; `NLP` == Natural Language Processing.
[^no-vae]: By the way (because this was an idea on my syllabus draft for a while), an _attentive_ seq2seq VAE would be ineffective. Why? The network is going to be as lazy as you allow it to be, and it just won't bother learning to use a thought vector, variational or otherwise, when it can simply search with attention as needed.
[^sample-code]: Quick sidebar follow-up from last week: I mentioned that the seq2seq VAE code that I forked hadn't implemented sampling, so I [shared the _homotopies_](/dl/2018/06/29/energy-and-vae#experiments) it could generate instead. My mentor Natasha then pointed out that sampling is actually very simple to implement. She was right (per usual) - so I added [`generate.py`](https://github.com/iconix/pytorch-text-vae/blob/master/generate.py) to my fork this week!
