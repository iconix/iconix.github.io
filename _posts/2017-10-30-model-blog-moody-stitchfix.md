---
layout: post
section-type: post
title: Model Blog&#x3a; Chris Moody of Stitch Fix
category: blogging
tags: []
---

<p style="text-align: center"><a href="http://multithreaded.stitchfix.com/blog/">http://multithreaded.stitchfix.com/blog/</a></p>

As I find resources online to learn more and more about word embeddings[^embed], I keep coming back to one resource in particular.

It started in September with the discovery of ["A Word is Worth a Thousand Vectors"](http://multithreaded.stitchfix.com/blog/2015/03/11/word-is-worth-a-thousand-vectors/) (and the corresponding [_Text By the Bay_ 2015 talk](https://www.youtube.com/watch?v=vkfXBGnDplQ) + [slides](https://www.slideshare.net/ChristopherMoody3/word2vec-lda-and-introducing-a-new-hybrid-algorithm-lda2vec-57135994)). Then a week later, I found a link to ["Introducing our Hybrid lda2vec Algorithm"](http://multithreaded.stitchfix.com/blog/2016/05/27/lda2vec/) through a forums.fast.ai search[^fast-search] for more on `LDA`[^lda].

The author for both incredibly detailed yet accessible blog posts is Chris Moody (["Caltech - Astrostats - PhD supercomputing. Now Applied AI"](https://twitter.com/chrisemoody)).

Despite his deeply technical background in things like _whatever astrostatistics is_, I admire Moody's commitment to explaining things well. He provides both the bird's eye view and the implementation details (the latter of which I happen to be very interested in at the moment). He illustrates his ideas with examples and lots of appealing, brightly-colored visualizations. His references sections at the end of posts are extraordinarily helpful unto themselves[^ref]. All the while, he never seems to dumb his content down, and so the posts stand as complete works on their own.

**The biggest point I'd like to take away from Moody's blogging is the importance of _visual language_.** The more I blog, the more I feel like I use too many words per post. I want to push myself to _stitch_ together a more visual portfolio of work[^robinson].

#### References

[^embed]: _Word embeddings_ are a neat way of encoding semantic relationships between words into numeric vectors, which is important because these vectors are what machine learning models accept as input. At the moment, word embeddings appear to be the #1 preferred building block for natural language processing (NLP) in machine learning.
[^fast-search]: Searching the [fast.ai](/notes/2017/08/18/fast-week2.html) forums for ML-related content has become a solid go-to move for me.
[^lda]: LDA stands for _Latent Dirichlet Allocation_, a technique for topic modeling. `lda2vec` is a word embeddings + topic modeling extension... invented by Chris Moody!
[^ref]: For example, "A Word is Worth a Thousand Vectors" had a reference to ["Dependency-Based Word Embeddings"](https://levyomer.wordpress.com/2014/04/25/dependency-based-word-embeddings/) by Omer Levy - which I wasn't looking for but in the end found very useful while thinking through the work behind my own [NLP for Task Classification](/portfolio-building/2017/09/25/nlp-for-tasks.html) post.
[^robinson]: Visual work like the [Shiny app and other charts](/portfolio-building/2017/10/18/data-is-all-around-us.html#shiny-app) that I replicated earlier this month from David Robinson of StackOverflow, as an example.
