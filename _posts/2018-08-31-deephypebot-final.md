---
layout: post
section-type: post
title: deephypebot&#58; an overview
category: DL
tags: [ 'openai' ]
---

## Motivation:

[@deephypebot](https://twitter.com/deephypebot) is a music commentary generator. It is essentially a _language model_, trained on past human music writing from the web and conditioned on attributes of the referenced music. There is an additional training step that attempts to encourage a certain type of descriptive, almost flowery writing commonly found in this genre.

Our goal is to teach this language model to generate consistently good and entertaining new writing about songs.

## Project Achievements:

- Functional, documented pipeline code ([GitHub repo](https://github.com/iconix/deephypebot))
- Inference through trained LC-GAN + VAE architecture
- A technical white paper (_coming soon_)

## Components:

![Project architecture diagram](/img/posts/deephypebot-architecture.svg)

_A detailed breakdown of the project architecture can be found in the [**project proposal**](https://github.com/iconix/deephypebot/blob/master/proposal.md)_.

## Future Work:

Here are some ideas that I didn't quite get to but would love to in the future!

- [ ] A second worker agent to automatically post human-approved retweets to bot account
- [ ] A Docker-ized pipeline
- [ ] Enable @ tweets of the bot to trigger on-demand samples
- [ ] Try out conditioning VAE on audio features instead of genre
- [ ] Try out sentiment from deepmoji as an automatic rewards functions for the LC-GAN
- [ ] Online learning with tweet likes
- [ ] Further data source diversity (e.g, from Tumblr, SoundCloud comments, etc.)
- [ ] Use a VAE pretrained on Wikipedia or some other large, relevant corpus (if possible?)

## What I've Learned This Summer

I have a friend currently in a bioscience PhD program who likened my summer to a [lab rotation](https://en.wikipedia.org/wiki/Laboratory_rotation) (or two) during the first year of a PhD program. I essentially got a 13-week test run of what it might look like to join a great AI lab.

This summer has been an intense foray into the independence and self-determination required for graduate studies, and I couldn't have done it without a solid support system! My biggest thanks goes to my program mentor, [**Natasha Jaques**](https://twitter.com/natashajaques), who never failed to balance her own intensive research this summer with helping me out by proofreading my blog posts, explaining concepts on the whiteboard, providing me with access to other top experts in the field, brainstorming and debugging, and just generally encouraging and cheering me on. Thanks to program director **Larissa Schiavo** for keeping us together as a cohort and on track throughout the summer, always ready to unblock or assist us as needed. Thanks to my fellow Scholars for being truly brilliant and good-natured folks: **[Christine](http://christinemcleavey.com/), [Dolapo](https://codedolapo.wordpress.com/), [Hannah](http://www.hannahishere.com/), [Holly](https://hollygrimm.com/), [Ifu](https://www.lifeasalgorithm.com/), [Munashe](http://everyd-ai.com/), and [Sophia](https://medium.com/@sophiaarakelyan)**. Last but not least, thanks to the **family, friends, and coworkers both at OneNote and the OpenAI offices** for supporting me with places to work and stay across the country, as well as with room to grow on this summer "sabbatical."

I am grateful that this program allowed me to find and refine my blogging voice, including more visual storytelling than ever before. I am much more comfortable working with deep learning frameworks, especially PyTorch. And I now have experience building an end-to-end, deep learning product. Kudos all around!

## Future Plans:

- Moving back east!
- Going broader on/experimenting more with creative applications in ML - both new and existing.
- Even more explorations with NLP and language.

Thanks to everyone who has followed my journey as an OpenAI Scholar! You can find me [**on Twitter**](https://twitter.com/ohnadj).

### _Follow my progress this summer with this blog's [#openai](/tags/openai) tag, or on [GitHub](https://github.com/iconix/openai)._
