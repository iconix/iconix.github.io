---
layout: post
section-type: post
title: How I designed my OpenAI project
category: Career
tags: []
---

Upon learning that I'd been [accepted to be an OpenAI Scholar this summer](/career/2018/05/30/openai-scholar), I didn't give myself much room to celebrate. Instead, I immediately started stressing over my next set of decisions[^gratitude]. One of the bigger decisions to appear in front me:

> _What exactly will I focus on in deep learning for 13 weeks?!?_

The Scholars application was clear about our end goal: study deep learning and open-source a final project. But from here to August 31 laid a chasm.

A chasm of opportunity, thankfully. But also, a bit intimidatingly.

## Wandering

![Some frantic early brainstorming](/img/posts/huh-brainstorm.jpg)

_Some who wander are lost._

To bridge the gully, I began trying to establish more parameters for the summer. How 'novel' did I need to be in this final project? What should my weekly blog posts look like? Could I collaborate on a project with my mentor?

I also began searching for inspiration from others. Tabs and tabs of [arXiv](http://www.arxiv-sanity.com/) papers open on my laptop at any given moment. Blog posts and internet rabbit holes and the growing feeling that _literally everything doable for me had been done already_.

I felt like I couldn't possibly know enough to contribute anything novel or interesting to the field, _especially in 3 months_. I felt wholly unqualified and stressed out.

## Some Friendly Advice

Sitting around at a bar in Austin, TX, explaining the feeling of drowning in deep learning, a couple of close friends pointed out the elegantly obvious: **maybe I should focus on what I love and enjoy, and _then_ figure out the deep learning component**.

One friend then said,
> "like... you like _music_,"

and I said,
> "yeah yeah I thought about that but I'm not a musician and audio is _scary_ ... ... but maybe it doesn't have to involve audio to be about music?"

and then my friends couldn't answer that for me - but I had a new lead.

## Second Wind

I do like music, but I'm a fan and not usually a participant (not since middle school piano lessons). As a fan, I have particular respect for the music blog community and the music blog aggregator [Hype Machine](https://hypem.com/). No project captures the energy of this community quite like HypeM and its ["eclectic stream"](https://noisey.vice.com/en_au/article/kzgwvm/the-rise-and-fall-of-hype-machine-the-internets-forgotten-fave).

Pivoting to focus more on what I do know (myself) was a great step forward. But what about deep learning - isn't it the entire point of the program? My mentor Natasha (she's great, you should [look her up](https://www.media.mit.edu/people/jaquesn/overview/)) said it best:

> "Hey, that's exactly why we can brainstorm things together! I know what's going on in deep learning, and you know your passions/interests!"

And so I learned to lean more on my mentor for what I don't know about deep learning in these early days.

She generously flooded me with resources, from a "best of" list of deep learning papers to her own personal notes. I also started studying up and reviewing fundamentals rather than the cutting edge - mostly from the [Deep Learning](http://deeplearningbook.org) book, but also from online deep NLP lectures by [Stanford](http://cs224n.stanford.edu) and [Oxford](https://github.com/oxford-cs-deepnlp-2017/lectures).

## Finding My Niche

After about a month of fretting, my big breakthrough happened during a brainstorming meeting with Natasha, where my idea heap and her DL knowledge propelled us towards my current project direction[^mentoring].

Music + text. The language _around_ music - manifested by hundreds of ["nice, small blogs"](https://www.theverge.com/2018/1/2/16840940/spotify-algorithm-music-discovery-mix-cds-resolution) on the internet, then beautifully aggregated by the [Hype Machine](https://hypem.com/sites) - has personally fueled my discovery of new music for many years. I'd love to **pay homage** to these labors of love. I'd like to see how much a machine learning algorithm of my own design can describe music, not by an up-or-down vote on whether or not I might like it, but by why it might resonate with me.

So rather than generating music recommendations, I'd like to generate music reviews. **I will attempt to generate opinionated new writing about songs, based on a set of characteristics about the song and knowledge of past human music writing**[^fallback]

Is this possible? Depends on what we mean by possible. Machine learning algorithms have certainly proven capable of [stringing together words](http://aiweirdness.com/), albeit with varying degrees of coherence. The trick will be to string together words that are _topical, structured, and specific_ to attributes of the provided song.

Is my final project novel? I mean, I won't be pioneering a new sub-field of deep learning, but I think my target application is pretty unique :stuck_out_tongue: And more importantly, I'm very excited about its potential and all that I'll need to learn to achieve it.

After some initial trepidation, I'm very happy with how this summer is shaping up. I am exceedingly thankful for the people in my life that have listened and brainstormed and supported me through the rough patches.

#### Footnotes

[^gratitude]: This isn't something I'm proud of - I'm still working on my gratitude :sweat_smile:

[^mentoring]: This 1:1 mentorship has already been invaluable to me!

[^fallback]: Due to potential data issues (that I'll discuss in a future blog post), I have a fallback project of generating _lyrics_ rather than reviews.
