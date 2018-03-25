---
layout: post
section-type: post
title: fast.ai in review
category: Notes
tags: []
---

The last time I blogged specifically about my fast.ai experience was after [Week 2]({% link _posts/2017-08-18-fast-week2.md %}), where I talked about being introduced to great technical writing, learning through experimenting, and some of my initial trust issues with the top-down learning approach.

I finished the course back in February, and overall, it has been a wonderful, worthwhile journey of several months. I leave it feeling more capable of immediately applying what I've learned than I did at the end of [Andrew Ng's _Machine Learning_ course]({% link _posts/2017-07-03-ng-ml-notes.md %}) back in 2014[^applicable]. I owe this confidence to fast.ai's _top-down_ teaching philosophy (despite the [drawbacks]({% link _posts/2017-08-18-fast-week2.md %}#drawbacks-of-top-down-learning) discussed in week 2).

### Notes from [Deep Learning for Coders (2017)](http://course17.fast.ai/)

#### [View on GitHub](https://github.com/iconix/fast.ai/blob/master/help/2017/README.md)

I hosted my [Ng course notes in OneNote](https://1drv.ms/u/s!AraXgcy9RrRQhchBmtnUm1hHaageog?wd=target%28Ng%20ML%20Notes.one%7CBB2FD368-5C9F-4366-A3FE-33B132AB4D9E%2F%29)[^I-work-for-OneNote], which turned out to be a great platform for supporting Ng's heavy use of mathematical notation.

I've put my fast.ai notes up on GitHub, as part of my repo of course work. My notes for this course are less in-depth (versus my Ng notes) because the fast.ai course itself supplied [excellent notes](http://wiki.fast.ai/index.php/Course_notes) on the course wiki.

My notes aggregate tips from each lesson, as well as provide a [glossary of course terminology](https://github.com/iconix/fast.ai/blob/master/help/glossary.md), [commands cheat sheet](https://github.com/iconix/fast.ai/blob/master/help/cmd-cheat.md), and a list of [recurring resources](https://github.com/iconix/fast.ai/blob/master/help/resources.md).

#### 2017 vs 2018 course editions

As of the publish date of this post, my notes are based on the 2017/v1 edition of this course.

I plan to revisit the 2018/v2 edition of this course too, so I will gradually add notes on interesting differences between the editions to the same repository.

The most obvious difference: 2017/v1 uses Theano + Keras; 2018/v2 uses PyTorch + a custom library built for the course.

### Who should take this course?

Take this course if you are:
- More interested in the _how_ (practice) of deep learning than the _why_ (theory)
- Looking for a hands-on tour of what deep learning can do

This course is less helpful if you are:
- Way more interested in processing language over images (NLP is touched upon, but image classification is the flagship scenario for the course)
- Looking to learn about various deep learning frameworks (course doesn't detail the trade-offs for selecting Theano over Tensorflow much beyond "Theano is easier to use and good for a single GPU")

### Did my deep learning server really cost $31.50?

#### Expectations:

- The [course home page](http://course17.fast.ai/index.html) states that one should **"plan to spend around 10 hours a week for 7 weeks."** Since the course also recommended we watch each lecture twice, 4-5 of those hours would be spent watching lecture. The remaining 5-6 hours are left for reading the lesson's wiki notes and running/replicating the lesson notebook.
- It is suggested in the [AWS lesson](http://course17.fast.ai/lessons/aws.html) that the deep learning server will cost **$0.90 per hour**. This is the cost of running an AWS P2 instance.

So given these expectations, **this course should have costed ~$31.50 in AWS spending**. Haha.

#### Cost reality:

My bill included significant charges that are, unfortunately, not mentioned by the course:
- Elastic Block Store (EBS) was costing a solid chunk: **~$13.11 per month** on average [^ebs]
- Elastic IP address added another **~$3.61 a month** here[^elastic-ip]

These non-P2 charges resulted in me spending, on average, $16.72/month. In fact, **only a _third_ of my billed weeks show a majority of cost coming from up-time of the P2 instance** (11 of 33 weeks). The other two-thirds show 50%+ of the weekly cost coming from storage volume and an idling IP.

![Percentage spent on EC2 Box vs EBS+ElasticIP](/img/posts/aws-percent-spending.svg)

And here I was so worried about instance up-time...

My actual costs from July '17-February '18? **$296.92 in AWS spending**.

#### Did I really spend 10 hours/week?

- Again, **lectures** took **4-5 hours per week**. Run times were 2-2.5 hours/week, and I watched each twice (as recommended by the class: first time for high-level ideas; second time for more detail and after engaging with the lesson material).
- Let's assume **suggested readings** took another **1 hour per week** (this is conservative, particularly for Lessons 2 and 4 for me).
- My AWS bill shows 170.5 hours in **compute time**. If I had spent all of that compute time in the 7 weeks allotted for this course, that would be **24 hours per week** - _way_ over the expected 5-6 hours.

There are _caveats_ to this 170.5 hours of compute.
1. All compute time was not spent staring at my monitor because deep learning models can take lots of time to train.
2. I will also note that I was quite bad at following Jeremy's advice to develop the model on a sample data set first, which would have resulted in quicker training times.
3. There was one day where I accidentally forgot to stop the instance overnight.

The caveats still don't explain away the great difference between 24 hours and 5-6 hours. To have spent the time I did in 7 weeks, I would have had to have treated this course like a heavy part-time job.

In reality, my compute time was spent over 33 weeks rather than 7. If I remove weeks with no compute spend, 33 reduces to 22 weeks.

**Over 22 weeks, my compute time averaged out to ~7.75 hours per week.** So even at my extended pace, I was spending solidly >6 hours a week on compute alone for the course.

### Charges Per Net Code Change

Here's another interesting way to look at my course spending: did more spending correlate with more work? I'm roughly correlating _effort_ with _net change in lines of code_ (additions - deletions), as told by GitHub.

![AWS Charges Per Net Code Change](/img/posts/aws-charges-per-net-code-change.svg)

Size of bubble == net code change.

### Next Steps

- Quick tour through the 2018 re-recording of this course in PyTorch (instead of Keras/Theano).
- Applying RNN character generated text to my fun side project.
- Applying word embeddings and NLP classification via deep learning at work.

#### Footnotes

[^applicable]: e.g., right now, I'm applying RNN character generated text from [Lesson 6](https://github.com/iconix/fast.ai/blob/master/nbs/lesson6-hmwk.ipynb) to a fun [side project](https://github.com/iconix/fb-chat-rnn).
[^I-work-for-OneNote]: Using OneNote back then also let me [eat my own dog food](https://en.wikipedia.org/wiki/Eating_your_own_dog_food).
[^ebs]: "$0.10 per GB-month of General Purpose SSD (gp2) provisioned storage"
[^elastic-ip]: "$0.005 per Elastic IP address not attached to a running instance per hour (prorated)"
