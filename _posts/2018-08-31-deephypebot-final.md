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

- Functional, documented pipeline code
- Inference through trained LC-GAN + VAE architecture
- A technical white paper (_coming soon_)

## Important Components:

A detailed breakdown of the project architecture can be found at [proposal.md](https://github.com/iconix/deephypebot/blob/master/proposal.md).

## Future Work:

Here are things I didn't get to - but would love to if I get the chance!

- [ ] A second worker agent to automatically post human-approved retweets to bot account
- [ ] A Docker-ized pipeline
- [ ] Enable @ tweets of the bot to trigger on-demand samples
- [ ] Try out conditioning VAE on audio features instead of genre
- [ ] Try out sentiment from deepmoji as an automatic rewards functions for the LC-GAN
- [ ] Online learning with tweet likes
- [ ] Further data source diversity (e.g, from Tumblr, SoundCloud comments, etc.)
- [ ] Use a VAE pretrained on Wikipedia or some other large, relevant corpus (if possible?)

## What I've Learned This Summer

I have a friend currently in a Bioscience PhD program who likened my summer to a [lab rotation](https://en.wikipedia.org/wiki/Laboratory_rotation) (or two) during the first year of a PhD program. I essentially got a 12-week test run of what it might look like to join a great AI lab.

This summer has been an intense foray into the independence and self-determination required for graduate studies, and I couldn't have done it without a support system! The biggest thanks to my program mentor, [**Natasha Jaques**](https://twitter.com/natashajaques), who never failed to balance her own intensive research this summer with helping me out by proofreading my blog posts, explaining concepts on the whiteboard, providing me with access to other top experts in the field, brainstorming and debugging, and just generally encouraging and cheering me on. Thanks to program director **Larissa Schiavo** for keeping us together as a cohort and on track throughout the summer, always ready to unblock or assist us as needed. Thanks to my fellow Scholars for being brilliant and truly good-natured folks: **Christine, Dolapo, Hannah, Holly, Ifu, Munashe, and Sophia**. And last but not least, thanks to the **family, friends, and coworkers back at OneNote** who supported me with a place to stay and room to grow on this summer "sabbatical."

I'm grateful that this program allowed me to find and refine my blogging voice, including more visual components like diagrams than ever before. I am much more comfortable working with deep learning frameworks, especially PyTorch. And I now have experience building an end-to-end, deep learning product. Kudos all around!

## Future Plans:

- Moving back east!
- Go broader on/experiment more with creative applications in ML - both new and existing

Thanks to everyone who has followed my journey as an OpenAI Scholar!

### _Follow my progress this summer with this blog's [#openai](/tags/openai) tag, or on [GitHub](https://github.com/iconix/openai)._
