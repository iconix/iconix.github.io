---
layout: post
section-type: post
title: NLP for Task Classification
category: Portfolio Building
tags: [ ]
---

_**UPDATE 11/17/2017**: I wrote a follow-up post about deploying this model to a web service via Azure ML - [check it out](/career/2017/11/16/azure-ml)!_

_Everything between this sentence and the [Wrap Up](/portfolio-building/2017/09/25/nlp-for-tasks#wrap-up) section has been converted from my [nlp_classifier notebook](http://nbviewer.jupyter.org/github/iconix/nlp-sandbox/blob/master/nlp_classifier.ipynb)[^nbconvert] on GitHub._

{% include notebooks/nlp_classifier.html %}

# Wrap Up

Another way to describe this notebook: as both **1)** generalizing (by devaluing specific word choice) _bag-of-words_ using part-of-speech, and **2)** enhancing n-gram (bigram) selection using _syntactic dependencies_.

#### Towards functional over topical similarity for task classification

[_Dependency-Based Word Embeddings_](https://levyomer.files.wordpress.com/2014/06/dependency-based-word-embeddings-acl-2014.pptx) by Omer Levy & Yoav Goldberg is a presentation I discovered after writing this notebook. The following hints at why the methodology in this notebook works:
>- Bag-of-words contexts induce topical similarities
>- Dependency contexts induce functional similarities
>    - Share the same semantic type
>    - [Co-hyponyms](https://en.wikipedia.org/wiki/Hyponymy_and_hypernymy#Co-hyponyms)

This duo also provided [dependency-based embeddings from English Wikipedia](https://levyomer.wordpress.com/2014/04/25/dependency-based-word-embeddings/), which is awesome - one cool extension I'd like to pursue is comparing my very manually-engineered classifiers against a classifier with these pre-trained embeddings at its core.

#### Demo Fridays: Redux

This notebook was used as part of my second [team-wide demo](/career/2017/09/01/demo-fridays) - so here's to pushing myself!
> ...even if it’s frankly terrifying to think about putting my name on something half-baked in front of ~40 people.
>
> &mdash; Me, three weeks ago

#### Footnotes

[^nbconvert]: Huge thanks to [Michele Pratusevich](http://www.mprat.org/blog/2017/03/18/blogging-with-jupyter.html) for the detailed blog post on _Blogging with Jupyter_ - I've been wanting to do this! Last convert: 11/13/2017.
