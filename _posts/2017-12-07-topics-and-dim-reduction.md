---
layout: post
section-type: post
title: Topic Models and Dimensionality Reduction
category: Notes
tags: [ ]
---

Over the past few weeks, I spent some time building this slide deck[^ppt] as a comprehensive overview of the subject of _topic models_ in NLP. It has been assembled from many other online resources, which I took care to cite throughout.

<iframe src='https://onedrive.live.com/embed?cid=50B446BDCC8197B6&resid=50B446BDCC8197B6%21101313&authkey=AEVpYFhVVYWH5IM&em=2&wdAr=1.7777777777777777' width='610px' height='367px' frameborder='0'>This is an embedded <a target='_blank' href='https://office.com'>Microsoft Office</a> presentation, powered by <a target='_blank' href='https://office.com/webapps'>Office Online</a>.</iframe>
<br />

My motivations were many. I wanted to push myself to provide more visual content on this blog, and an original slide deck seemed like a good stepping stone towards that.

I also wanted to learn more about unsupervised learning techniques (having spent [most of my](/notes/2017/08/18/fast-week2.html) [recent time](/portfolio-building/2017/09/25/nlp-for-tasks.html) in the supervised domain), in hopes of ultimately building a prototype that could annotate notes to improve product search at work[^postponed].

Further, _dimensionality reduction_ is a technique that seems to keep popping up everywhere, and I am a bit rusty in my linear algebra.

The fact that there's a robust, popular Python library specifically for topic modeling in [`gensim`](https://radimrehurek.com/gensim/) proves (to me, at least) how interesting and practical topic modeling is. I hope you agree!

![Topic flow chart (SVG)](/img/posts/topic_flow_chart.svg)

#### Footnotes

[^ppt]: PowerPoint today, HTML5 native next. I was not aware of how low res rendering would be in PowerPoint Online...
[^postponed]: The prototype will have to wait though, as unfortunately, business priorities on the team have shifted enough to put the ML incubation team on pause for several months.
