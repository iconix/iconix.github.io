---
layout: post
section-type: post
title: OpenAI Scholar, Week 3
category: DL
tags: []
---

This week had two planned tracks:
1. Modify a word-based version of [my LSTM from last week](/dl/2018/06/15/scholar-week2#part-ii-getting-familiar-with-rnns) to consider _context_ like song genres or audio features when generating text.
2. Train an LSTM on song titles and "something stodgy" like deep learning paper titles.

I talked about the entertaining results of #2 in [**"A Musical Arxiv Experiment"**](/dl/2018/06/20/arxiv-song-titles) - be sure to check that out!

Figuring out #1 proved more elusive in a week. I was able to modify the baseline LSTM to use words instead of characters, but it looks like the `fastai` library I'm relying on didn't anticipate someone like me wanting to consider context while generating text.

Let's step through how track #1 derailed this week :slightly_smiling_face:

## Part I. Word-based LSTM

Going from a character-based to word-based LSTM is **wonderfully simple** with `torchtext` (more on this library later): I just changed the tokenizer on the `torchtext.data.Field` from `list` to `'spacy'`! The English spaCy [tokenizer](https://spacy.io/usage/linguistic-features#tokenization) is the gold standard for word tokenization in Python nowadays, and it is built into `torchtext`.

One very helpful tip I received from Natasha this week: work out the kinks in a new model on a **very small sampled data set**. I used 250 samples: 200 training and 50 validation. Training is faster, output is more easily debugged (like when I had a bug in my sampling code), and ensuring your model _can_ overfit to small data provides a sanity check on your model architecture. I had also received this advice from the fast.ai course, but I really needed the reminder.

Here's the type of output I was seeing on the sample data set after 100 epochs (seed='the song', num_reviews=200):
> the songoff timberlake show having electronic together that of collaborative <unk> <unk> <unk> a if lot ben timberlake tells ben of so <unk> <unk> the ingredients <unk> <unk> <unk> gorgeous and everyone . the trend everyone . <unk> we crush continues <unk> y chill bass is the eager something <unk> <unk> <unk> there to word washed her mark and together ' <unk> the band vocalist himself 1 instruments . <unk> <unk> the friend in explain of of take half " tracks <unk> <unk> <unk> you soft <unk> uk steel melodic 's word perfect qui in-

So, y'know- still not readable, but I figured once I had contextualized output, I could still compare that output to this in a bag-of-words way (e.g., what words output more when genre is specified as 'pop'?). Didn't quite make it there though!

## Part II. How fastai handles languagemodel data

I spent a lot of time this week digging through `fastai` library [source code](https://github.com/fastai/fastai/tree/master/fastai), especially [`nlp.py`](https://github.com/fastai/fastai/blob/master/fastai/nlp.py). Here's what I came to understand[^google-draw].

![LanguageModelData](/img/posts/fastai-langmodeldata.svg)

The `fastai` library handles natural language processing (NLP) data with its `LanguageModelData` class. You can construct one either `from_dataframes` or `from_text_files` - but the end result is essentially 2-3 Datasets (one for training, validation, and optionally test) and 2-3 Dataloaders (again, train, val, test).

An instance of `LanguageModelData` is expected by the [`fit`](https://github.com/fastai/fastai/blob/master/fastai/model.py) function (the one that I mentioned appreciating [last week](/dl/2018/06/15/scholar-week2#fastai-library)) for NLP tasks, along with other things like the model itself and number of epochs.

But how are the Datasets and Dataloaders created?

![Datasets to Dataloaders](/img/posts/fastai-ds-dl.svg)

This is where `fastai`'s tight integration with `torchtext` really kicks in. [torchtext](https://github.com/pytorch/text) is the official PyTorch library for "data loaders and abstractions for text and NLP." My first experience with `torchtext` was a lot like [this tutorial writer's experience](http://anie.me/On-Torchtext/):

> About 2-3 months ago, I encountered this library: Torchtext. I nonchalantly scanned through the README file and realize I have no idea how to use it or what kind of problem is it solving. I moved on.

The thing is, the [documentation](http://torchtext.readthedocs.io/en/latest/) is light and there are no official tutorials (unlike the main PyTorch library). Blogger Nie ended up digging through source code to write his tutorial.

Anyway, once you get it, `torchtext` seems pretty nice for common NLP preprocessing tasks like train/val/text splits, tokenization, generating vocab lists, numericalization, and batching.

As you can see in the above diagram, a `Dataset` is a `torchtext` abstraction. It is constructed using other `torchtext` abstractions named `Field` (which "defines a datatype together with instructions for converting to Tensor") and `Example` ("defines a single training or text example").

The `Dataset` is then used to construct a `fastai.LanguageModelLoader`, aka the aforementioned Dataloader (reminder that there's a dataset and corresponding dataloader for each train/val/test split).

## Part III. The dataloader I need

This is all well and good for language modeling on text only. But notice the new callout in the diagram from earlier.

![Datasets to Dataloaders](/img/posts/fastai-ds-dl-issues.svg)

Unfortunately, the `fastai` library wraps the `Dataset` in a way that hard-codes all model data as a single text `Field` - and **this prevents me from adding contextual `Field`s like genre and audio features** :disappointed: I need a `Dataset` with multiple `Field`s that I can then manipulate as I like in my LSTM `forward` pass.

## Part IV. Moving forward

By my estimation, getting the `fastai` library to support multiple `Field`s will require a non-trivial change. I'd like to make that change - I'd even like to generalize it enough to send a pull request to the library.

But things are very go-go-go this summer, so I don't know when I'll have the time to contribute officially.

I think it will be very worthwhile for my summer to invest in getting more familiar with raw `torchtext` though. Another bright side of this `fastai` probe was getting introduced to `torchtext` by example.

---

So- that's how I ran out of time this week :sweat_smile: At least my setback was informative.

Next week, I am meant to start on seq2seq models. This weekend, I plan to evaluate whether I think I've done enough groundwork with LSTMs to stick to this schedule, or if I need to re-think the pacing of my syllabus. So... stay tuned!

#### Footnotes

[^google-draw]: This week, I tried out the free [Google Drawings](https://docs.google.com/drawings/) for my graphics - not bad! By the way, I like pointing out _how_ I make graphics because the tools of the trade feel kind of secretive to me. Blogs just have all of these cool graphics, and I've long assumed I wasn't artsy enough to do my own.
