---
layout: post
section-type: post
title: Topic Models and Dimensionality Reduction
category: Notes
tags: [ ]
---

Over the past few weeks, I spent some time building this slide deck as a comprehensive overview of the subject of _topic models_ in NLP. It has been assembled from many other online resources, which I took care to cite throughout.

<iframe src='https://onedrive.live.com/embed?cid=50B446BDCC8197B6&resid=50B446BDCC8197B6%21101313&authkey=AEVpYFhVVYWH5IM&em=2&wdAr=1.7777777777777777' width='610px' height='367px' frameborder='0'>This is an embedded <a target='_blank' href='https://office.com'>Microsoft Office</a> presentation, powered by <a target='_blank' href='https://office.com/webapps'>Office Online</a>.</iframe>
<br />

My motivations were many. I wanted to push myself to provide more visual content on this blog, and an original slide deck seemed like a good stepping stone towards that.

I also wanted to learn more about unsupervised learning techniques (having spent [most of my](/notes/2017/08/18/fast-week2.html) [recent time](/portfolio-building/2017/09/25/nlp-for-tasks.html) in the supervised domain), in hopes of ultimately building a prototype that could annotate notes to improve product search at work[^postponed].

Further, _dimensionality reduction_ is a technique that seems to keep popping up everywhere, and I am a bit rusty in my linear algebra.

The fact that there's a robust, popular Python library specifically for topic modeling in [`gensim`](https://radimrehurek.com/gensim/) proves (to me, at least) how interesting and practical topic modeling is. I hope you agree!

#### Footnotes

[^postponed]: The prototype will have to wait though, as unfortunately, business priorities on the team have shifted enough to put the ML incubation team on pause for several months.

===

sklearn

n_components=10
doc_topic_prior=None
topic_word_prior=None
learning_decay=0.7
learning_offset=10.0
evaluate_every=-1
max_iter=10
random_state=None

# batch learning
learning_method=None -> 'batch'
batch_size=128 -> n_samples

total_samples=1000000.0
perp_tol=0.1 # Only used when evaluate_every is greater than 0
mean_change_tol=0.001
max_doc_update_iter=100
n_jobs=1
verbose=0

"When [learning_decay] is 0.0 and batch_size is n_samples, the update method is same as batch learning"
n_batch_iter_

===

gensim

num_topics=100
alpha='symmetric'
eta=None
decay=0.5
offset=1.0
eval_every=10
iterations=50
random_state=None

# batch learning
update_every=1 -> 0
passes=1

# online learning
chunksize=2000

id2word=None -> dictionary
distributed=False
gamma_threshold=0.001
minimum_probability=0.01
ns_conf=None
minimum_phi_value=0.01
per_word_topics=False
callbacks=None
dtype=<type 'numpy.float32'>
