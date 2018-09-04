---
layout: post
section-type: post
title: Notes on topic modeling
category: DL
tags: [ 'openai' ]
---

I've [talked a bit about topic modeling](/notes/2017/12/07/topics-and-dim-reduction) on this blog before, pre-Scholars program. I revisit the subject now as a potential _automatic reward function_ for the [LC-GAN](/dl/2018/07/28/lcgan) I am using in [my final project](/dl/2018/08/03/deephypebot). My hypothesis is that topic modeling can distill the sentences in my music commentary data set down into distinct, crisp types; this information can then be used to teach the LC-GAN what types of sentences to encourage the downstream language model to generate.

Fortunately, my experiments this week indicate that topic modeling can indeed make a good reward function.

**_Topic modeling_ is a set of techniques for discovering "topics" (clusters of words) that best represent collections of text**. This is a form of _dimensionality reduction_, itself a set of techniques for transforming a high-dimensional data set (i.e., sentences) into a lower dimension (i.e., topics), with as little information loss as possible[^ae]. It can be thought of as a kind of summarization, distillation, or representation learning.

Topic modeling can be particularly useful for:
1. Finding structure and understanding over collections of text
2. Clustering similar texts and words
3. Inferring abstract topics on new texts

I explored a topic modeling technique called **_latent Dirichlet allocation_ (LDA)** this week using the wonderful [`gensim`](https://radimrehurek.com/gensim/) and [`pyLDAvis`](https://github.com/bmabey/pyLDAvis) packages for Python. LDA is a neat application of _Bayesian inference_: it learns a set of probability distributions for both words in a topic and topics in a text, where a topic can be represented by a mixture of words and a text by a mixture of topics.

## Choosing n_topics

The single-most important hyperparameter to choose when performing LDA is the _number of topics_ `n_topics` with which to cluster your collection of texts. I've found that this is a bit of a Goldilocks problem: too low and topics become unfocused, with not-so-related texts appearing in the same topic; too high and topics are unfocused and even more fragmented, with a singular topic splitting across multiple.

Here are some `n_topics` experiments with my commentary data set, as well as a few observations.

Note that I care most about encouraging what I call _song descriptions_ : description, almost flowery language about the music itself (e.g., ). Therefore, I'd like a topic that isolates this type of sentence. I would consider it a bonus if another topic could isolate junk types like _tour dates_, _repetitive nonsense_, and _promotional writing_[^just-remove].

`n_topics` | topic descriptions |
--- | --- |
2 | _repetitive nonsense + song description_ **vs.** _tour and release dates + expository language on artist_ |
3 | _tour dates + song description_ **vs.** _repetitive nonsense + personal-style writing_ **vs.** _expository language on artists_ |
4 | _song description_ **vs.** _repetitive nonsense + personal-style writing_ **vs.** _tour dates + repeated phrases across sentences_ **vs.** _wwws + expository language on artist and releases_ |
5 | _promotional writing + "check it outs"s + social media sharing_ **vs.** _personal-style writing_ **vs.** _common prefixings + expository language on artists and releases_ **vs.** _non-English language + song description + repetitive nonsense_ **vs.** _tour dates + expository language on artists_ |

<br />

**`n_topics=4` appears to be the ideal setting for achieving the separation I want.** I would like to reiterate how subjective and task-oriented this choice is though - if my objective changed to just, say, discouraging _promotional writing_ and _social media sharing_, then 5 topics would be more suitable.

Full observations and results (including `pyLDAvis` visualizations) available at [`quilt.ipynb`](http://nbviewer.jupyter.org/github/iconix/openai/blob/master/nbs/quilt.ipynb#topic-modeling)

<small>A few notes on reading `pyLDAvis` visualizations in the notebook:</small>
- <small>circle size is "proportional to the proportions of the topics across the N total tokens in the
corpus"</small>
- <small>_relevance_ (red bars) and _saliency_ (blue bars) are alternative ways of measuring the importance or information value of a term to a topic. they both prefer more distinctive terms to generic ones.</small>
- <small>more details: <https://cran.r-project.org/web/packages/LDAvis/vignettes/details.pdf></small>

### _Follow my progress this summer with this blog's [#openai](/tags/openai) tag, or on [GitHub](https://github.com/iconix/openai)._

#### Footnotes

[^ae]: Autoencoders like [VAEs](/dl/2018/06/29/energy-and-vae#how) do dimensionality reduction as well!
[^just-remove]: I originally had the idea to also use topic modeling to just remove "junk-ier" sentences from the data set entirely. This seemed like a reasonable method of cleaning the data set to me. However, my mentor Natasha persuaded me otherwise, arguing that it is more important to keep that data in order to improve the network's understanding of language more generally.
