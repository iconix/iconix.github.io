---
layout: post
section-type: post
title: Good Enough
category: Career
tags: []
---

_What happened when I tried to "JFDI" today._

Right now, the [incubation crew at work](/career/2017/07/14/ai-at-work) is really just trying to build up a little engineering muscle in the AI/ML space. So to start, I am working on a scenario where we would like to automatically identify task-like/ToDo-like phrases within user notes and then suggest that they treat these phrases as such (perhaps in the To-Do app).

So I did all of this research into various techniques to detect an actionable, task-like line of text. I wanted to develop a linguistic approach. I think the deepest I ever really went into grammar was in the 7th/8th grade. Now I actually really loved this stuff back then... but I am pretty rusty today. I started drawing parse trees.

![Linguistic whiteboard session :nerd_face:](/img/posts/7_20_17_2PM_Office_Lens.jpg)

I settled on a few techniques after my session on the whiteboard. I was feeling good, like I had a plan.

I approached a coworker with this: first, I'd determine which was the very best of my few techniques, using a corpus (TBD) and some measure of accuracy for each; second, I'd code up the best technique and have it show suggested tasks to my crew-mates for a while, in order to test it out on "real" OneNote data; I'd come up with a way to receive feedback from my teammates that would improve the technique (automatically!); and finally, _clearly_ battle-tested, we'd expand the feature audience incrementally from there to GA. Boom.

My coworker looked pretty skeptical after all of my explanations and suggested **1)** I didn't have enough of a corpus (from my mind + 5 engineers testing on their real but limited notebook collection...) for this to be useful even slightly more broadly; **2)** even if I did have a large corpus from (say) the To-Do app, the context of where the corpus came from may not necessarily lend itself to OneNote; and **3)** even if I did have a corpus that I could trust and model off of perfectly, the best _static_ model will still require manual upkeep and maintenance and will almost certainly get stale if it can't _learn_ from our users itself.

He suggested that I was focused too deeply on model selection, when really, if user feedback is the actual key, I needed to accept that the initial model "will mostly have the wrong answer."

I thought about this and realized that he was probably right. I had already figured that there is a lot of utility in incorporating user feedback. But I was still spiraling too deep into the heavier idea of building "the best" model. Really, the model need only be "good enough":
- **Good**: suggestions that the model provides need to strike a balance between too spam-y (low precision) and too sparse (low recall) in order to compel users to interact with the feature and provide the valuable feedback needed to learn.
- **Enough**: if our system is ultimately meant to learn from our users, then model selection can be optimized for how quickly we can get it in front of customers. I can avoid getting caught up in hairy details around data collection, feature selection, training, etc. (and save that for later) and instead focus on the user feedback mechanism.

So by the end of the day, I JF-did-nothing, at least from a coding perspective. This was okay. I would have been just doing some misguided things anyway.
