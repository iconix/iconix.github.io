---
layout: post
section-type: post
title: Notes on topic modeling
category: DL
tags: [ 'openai' ]
---

I've [talked a bit about topic modeling](/notes/2017/12/07/topics-and-dim-reduction) on this blog before, pre-Scholars program. I revisit the subject now as a potential _automatic reward function_ for the [LC-GAN](/dl/2018/07/28/lcgan) I am using in [my final project](/dl/2018/08/03/deephypebot). My hypothesis is that topic modeling can distill the sentences in my music commentary data set down into distinct sentence types; this information can then be used to teach the LC-GAN what types of sentences to encourage the downstream language model to generate.

Fortunately, my experiments this week suggest that topic modeling can indeed make a good reward function.

**_Topic modeling_ is a set of techniques for discovering "topics" (clusters of words) that best represent collections of text**. This is a form of _dimensionality reduction_, itself a set of techniques for transforming a high-dimensional data set (i.e., sentences) into a lower dimension (i.e., topics), with as little information loss as possible[^ae]. It can be thought of as a kind of summarization, distillation, or learning of representation.

Topic modeling can be particularly useful for:
1. Finding structure and understanding over collections of text
2. Clustering similar texts and words
3. Inferring these abstract topics on new texts

I explored a topic modeling technique called **_latent Dirichlet allocation_ (LDA)** this week using the wonderful [`gensim`](https://radimrehurek.com/gensim/) and [`pyLDAvis`](https://github.com/bmabey/pyLDAvis) packages for Python. LDA is a neat application of _Bayesian inference_: it learns a set of probability distributions for both words in a topic (where a topic can be represented by a mixture of words) and topics in a text (where a text can be represented by a mixture of topics).

## Choosing n_topics

The single-most important hyperparameter to choose when performing LDA is the _number of topics_ `n_topics` with which to cluster your collection of texts. I've found that this is a bit of a Goldilocks problem: too low and topics become unfocused, with not-so-related texts appearing in the same topic; too high and topics are both unfocused and sometimes fragmented, with a singular topic splitting across multiple topics.

I observed a range of `n_topics` parameters on my commentary data set. I care most about encouraging the generation of what I call _song descriptions_: descriptive, almost flowery language about the music itself (e.g., "beginning with driving drums and bass paired with his songbird vocal harmonies..."). Therefore, I'd like a single topic to isolate this type of descriptive sentence. I would consider it a bonus if another topic could isolate junk types like _tour dates_, _repetitive nonsense_, and _promotional writing_ so that I can discourage these types simultaneously[^just-remove].

`n_topics` | topic descriptions |
--- | --- |
2 | **1)** _repetitive nonsense + song description_ **2)** _tour and release dates + expository language on artist_ |
3 | **1)** _tour dates + song description_ **2)** _repetitive nonsense + personal-style writing_ **3)** _expository language on artists_ |
4 | **1)** _song description_ **2)** _repetitive nonsense + personal-style writing_ **3)** _tour dates + repeated phrases across sentences_ **4)** _wwws + expository language on artist and releases_ |
5 | **1)** _promotional writing + "check it outs"s + social media sharing_ **2)** _personal-style writing_ **3)** _common prefixings + expository language on artists and releases_ **4)** _non-English language + song description + repetitive nonsense_ **5)** _tour dates + expository language on artists_ |

<br />

Full observations and results (including `pyLDAvis` visualizations like the one below) available at [`quilt.ipynb`](http://nbviewer.jupyter.org/github/iconix/openai/blob/f7eb47dbdf9ec7196e1e3a2ebfdfa0552c5fe302/nbs/quilt.ipynb#Topic-modeling).

**`n_topics=4` appears to be the ideal setting for achieving the separation I want.** I would like to reiterate how subjective and task-oriented this choice is though: if my objective changed to just, say, discouraging _promotional writing_ and _social media sharing_, then 5 topics might be more suitable.

<small>A few notes on reading `pyLDAvis` visualizations:</small>
- <small>Circle size is proportional to the topic's overall prevalence in the corpus.</small>
- <small>_Saliency_ (blue bars) measures the overall frequency of a term in the corpus.</small>
- <small>_Relevance_ (red bars) is a weighted measure of the frequency of each term in a topic. It is meant to show how much information a term conveys about a topic. The smaller the weight $$\lambda$$ (which you can slide to adjust), the more preference given towards terms distinctive to a topic -- making a topic more distinguishable from the others.</small>
- <small>Hidden feature: if you _hover_ over a word on the right, you can see all topics in which the term appears.</small>
- <small>Helpful explainer video: <http://stat-graphics.org/movies/ldavis.html></small>


<div style='overflow: hidden; padding-top: 85%; position: relative;'>
    <iframe src='/assets/iframes/lda_4topics.html' scrolling='no' style='border: 0; height: 100%; left: 0; position: absolute; top: 0; width: 100%;'></iframe>
</div>

### _Follow my progress this summer with this blog's [#openai](/tags/openai) tag, or on [GitHub](https://github.com/iconix/openai)._

#### Footnotes

[^ae]: Autoencoders like [VAEs](/dl/2018/06/29/energy-and-vae#how) do dimensionality reduction as well!
[^just-remove]: I originally had the idea to also use topic modeling to just remove "junk-ier" sentences from the data set entirely. This seemed like a reasonable method of cleaning the data set to me. However, my mentor Natasha persuaded me otherwise, arguing that it is more important to keep that data in order to improve the network's understanding of language more generally.
