---
layout: post
section-type: post
title: Feedback loops and exploration
category: Career
tags: [ ]
---

I've touted the virtues of [feedback loops](/career/2017/07/21/good-enough.html) on this blog before. So I found it surprising to read a blog post on ["Technical Debt in Machine Learning"](https://towardsdatascience.com/technical-debt-in-machine-learning-8b0fae938657) and find feedback loops listed as an _anti_-pattern (post based on NIPS papers from [2014](https://research.google.com/pubs/pub43146.html) and [2015](https://papers.nips.cc/paper/5656-hidden-technical-debt-in-machine-learning-systems.pdf)).

Thinking about this assertion more, I'd rephrase the concern to be around the most straightforward ([_exploit_](https://en.wikipedia.org/wiki/Multi-armed_bandit#Empirical_motivation)-only) feedback loop's tendency to quickly "collapse" the space of possible predictions for a user.

This is actually something I was thinking about during the [task extraction prototype](/career/2017/11/16/azure-ml.html)... for example, if we eventually got this great feedback loop going where users are telling us whether they agreed or disagreed with a suggested task, we could eventually end up with _too narrow_ a definition of a task, and the system could stop learning anything useful (hence the importance of [_exploring_ while you _exploit_](https://en.wikipedia.org/wiki/Multi-armed_bandit#Empirical_motivation) 😄).
