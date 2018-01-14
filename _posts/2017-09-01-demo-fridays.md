---
layout: post
section-type: post
title: Demo Fridays
category: Career
tags: []
---

My newly re-orged[^reorg] team has instituted a weekly demo block on Fridays, where the team gathers around a [Surface Hub](https://www.microsoft.com/microsoft-surface-hub/en-us) and members give live "demos of the cool stuff we've got working during the week!"

As with all forms of public speaking, this idea made me nervous. It also interested me because I would genuinely like to know what's going on around the team. So I lurked on the first one today - I attended but did not prepare a demo.

Two of my teammates on my AI/ML incubation team did demo, however - one I expected and the other I did not. Both went well, and people are very interested in what we are up to so we got peppered with questions after each demo.

My teammates' success reminded me to shift my perspective on what these demos could mean for me. If I continuously look at my work during the week through the lens of an end-of-week demo, it could help me get better at sharing out my work and knowledge, and with finding checkpoints to divvy up longer running projects into presentable parts. As I am well aware from peer and manager feedback, both sharing and iterating out in the open are things I struggle with historically. I tend to feel like my progress isn't worthwhile or polished enough until it's done. But I can learn to do better than to disappear for weeks and then come up for air with a finished product, even if it's frankly terrifying to think about putting my name on something half-baked in front of ~40 people.

Another useful product of the demos was the Q&A after each one. My incubation teammates definitely got the most questions out of all the demos - which means people are curious!

A couple ideas that came up during Q&A:
1. An interesting discussion happened around the difference between my current scenario for task detection and my teammate's scenario around OneNote section classification. For task detection, it is better if the model generalizes well so that it can be applied across multiple users. A benefit of this would be a model with access to more data for training, aggregated across users. This also brings more value to a user feedback loop. For section classification, it is likely the case that each user will own their own finely tuned model, unique to their notebook content; in this case, overfitting to the user's content might actually be the goal (when normally, overfitting is considered an undesirable final state for a model). A benefit of this would be being able to keep user content siloed during training.
2. A teammate in the larger team (not the AI/ML incubation team) essentially suggested applying the related notes area I am interested in to search. He said something like, what if a notebook had all of its pages in one _Quick Notes_ type of section, and searching was what provided the organization, on the fly. It made me envision a new OneNote navigational paradigm, "search and filter": the search bar pushed to the top-right corner of the UI today moves front-and-center, and instead of being an explicit keyword search, it becomes a keyword+related content search. As it filters, it updates the pages visible in this single section to create a new "meta-section." How cool would that be!

#### Footnotes

[^reorg]: It's a Microsoft thing where an organization like Notes shuffles people around, usually because management thinks it's a good idea for like, _synergy_, or something... I'm being mildly facetious. The re-org (of which I've been through at least one a year during my 4 years at Microsoft) actually greatly benefitted me personally this time around, as [blogged about earlier](/career/2017/07/14/ai-at-work.html).
