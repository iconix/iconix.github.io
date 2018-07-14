---
layout: post
section-type: post
title: Attention and Interpretability
category: DL
tags: [ 'openai' ]
---

This week, I picked up from [last week's study of attention](/dl/2018/07/06/not-enough-attention#understanding-attention) and applied it towards **model interpretability**, or the ability for humans to understand a model. I also explored some other ["attribution-based"](https://distill.pub/2018/building-blocks/) methods of interpretability that credit different parts of the model input with the prediction.

## Insights from explanations

This is the first of the 2 weeks I plan to spend on the subject of model interpretability, so I must think it's pretty important. Deep learning models have the reputation of being inscrutable "black boxes" because their problem-solving abilities can feel almost magical.

Even now, with all of the hype and effort being applied towards deep learning, little theory about _why_ these networks work so well exist. There's a surprising amount of intuition and guesswork going around for a bunch of researchers and engineers. This leaves room for doubt, especially when deploying these models into the real world.

_So why interpret?_
- debugging/diagnosis
- trust/confidence in decisions
- real-world applicability
- detecting bias

## Attention

Attention is computed as part of the network learning how to accomplish its task, which makes it very appealing as a method of interpretability. Colloquially, it tells us what the model is "paying attention" to at each time step - however, there's [evidence](http://www.abigailsee.com/2017/08/30/four-deep-learning-trends-from-acl-2017-part-2.html#post-hoc-explainability) that it can also learn more complicated relationships that aren't as immediately interpretable.

[`textgenrnn`](https://github.com/minimaxir/textgenrnn) implements a weighted average attention layer at the end of its LSTM-LM. I modified the library slightly to output the attention weights at every generation time step. Then I trained the network on my song reviews dataset. The heatmaps are from the attention weights used during sampling.

Here's how attention shifts as the model generates the phrase, "a nice reminder of summer":

![Attention heatmap for the generated phrase "a nice reminder of summer"](/img/posts/attention-lm.png)
<small>_<center>The lighter the color, the more attention paid to the corresponding word in the history.</center>_</small>

You can infer that the network paid close attention to the recently generated "reminder" when generating both "of" and "summer", and earlier to "nice" when generating "reminder". This is pretty neat!

It's surprising to me that so much attention is paid to the `<pad>` tokens, particularly early on. I was expecting the model to learn to ignore them and instead focus on `<s>` and eventually actual words as they slide into history. I did not train the model for long, however.

## Perturbations

I also explored assigning credit for a model prediction with input _perturbations_. This involves making slight changes to the input and observing how this affects the prediction.

These methods are usually applied to interpreting classification problems, which provide a nice test bed for detecting meaningful changes in the output. In particular, I looked at methods known as _LIME_ and _input gradients_.

### LIME
_Local Interpretable Model-agnostic Explanations_

[LIME](https://arxiv.org/abs/1602.04938) perturbs the input by selectively masking words in the input, then fitting a linear model. Note that local here means it interprets individual inputs and predictions, rather than making observations that hold globally for the model. From the project [README](https://github.com/marcotcr/lime#what-are-explanations):

> "Intuitively, an explanation is a local linear approximation of the model's behaviour. While the model may be very complex globally, it is easier to approximate it around the vicinity of a particular instance."

The [Anchor](https://github.com/marcotcr/anchor) and [SHAP](https://github.com/slundberg/shap) (SHapley Additive exPlanations) projects are improved, generalized versions of LIME.

Below, we can see LIME provide some insight into why my [movie sentiment classifier from last week](/dl/2018/07/06/not-enough-attention#kaggle--ulmfit) incorrectly classifies the phrase, "Not once does it come close to being exciting." as a neutral statement:

![LIME explainer for neutral classification of "Not once does it come close to being exciting"](/img/posts/lime-rt.png)

Unfortunately, because these explanations require multiple runs of the algorithm with slightly different inputs, it is computationally expensive to use. It also does not handle noise or surprise well.

### Input gradients

Input gradients (or "right for the right reasons (rrr)" as the [original paper](https://arxiv.org/abs/1703.03717) terms itself) use backpropagation as a different kind of perturbation - one of infinitesimal changes. The gradients "help define the decision boundary and lie normal to it."[^intuition-source]

![input gradients vs LIME](/img/posts/rrr-v-lime.png)
<small>_Input gradients explainers on the left; LIME explainers on the right. Image from [this notebook](https://github.com/dtak/rrr/blob/master/experiments/20%20Newsgroups.ipynb)._</small>

It turns out that the explanations provided by input gradients are very similar to those of LIME - input gradients are just _much_ more computationally efficient, as well as less sparse about assigning credit. Practically however, the LIME library is more polished and easier to use.

## Activations

Karpathy et al. explored the concept of "interpretable activations" in the paper [_Visualizing and Understanding Recurrent Networks_](https://arxiv.org/abs/1506.02078). They liken these interpretable activations to neurons firing at different rates in the brain as it processes the input. From ["The Unreasonable Effectiveness of Recurrent Neural Networks"](http://karpathy.github.io/2015/05/21/rnn-effectiveness/#visualizing-the-predictions-and-the-neuron-firings-in-the-rnn):

![Quote cell and if-statement cell](/img/posts/rnn-cells-firing.png)

Karpathy also makes the point that many/most activations are not easily interpretable - meaning you have to manually search for the ones that are.

#### Footnotes

[^intuition-source]: [https://github.com/dtak/rrr/blob/master/experiments/2D%20Intuition.ipynb](https://github.com/dtak/rrr/blob/master/experiments/2D%20Intuition.ipynb)
