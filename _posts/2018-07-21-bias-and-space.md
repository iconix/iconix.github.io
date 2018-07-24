---
layout: post
section-type: post
title: Interpreting Bias and Latent Space
category: DL
tags: [ 'openai' ]
---

For week 7, and my second week on model interpretability (see [first week post](/dl/2018/07/13/interpret-attn)), I focused in on one particularly cool VAE-based visualization example from Ha & Schmidhuber's [World Models](https://worldmodels.github.io/) work. I also did some broader thinking around _selection bias_ in my song review training data.

## Playing in VAE latent space

I spent some quality time this week with the wonderfully interactive and engaging [World Models](https://worldmodels.github.io/) project from David Ha and Jürgen Schmidhuber. It is really impressive to see such an interactive site accompany a [paper](https://arxiv.org/abs/1803.10122) like this!

I particularly enjoyed the demo that allows users to play with the latent vector `z` of a [variational autoencoder (VAE)](/dl/2018/06/29/energy-and-vae#seq2seq-vae-for-text-generation) and see how it affects the reconstruction:

![VizDoom VAE demo from original World Models project](/img/posts/doom-vae.gif)
<small>_VizDoom VAE demo from original World Models project._</small>

So I created my own **scaled-down version of this demo**! It features my text-based seq2seq VAE from [week 4](/dl/2018/06/29/energy-and-vae#experiments), rather than screenshots from Doom.

<script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.6.1/p5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.6.1/addons/p5.dom.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
<div style="text-align: left;border: 1px solid darkgray;padding: 10px;">
    <div id="sketch"></div>
</div>
<script src="/js/vae_demo.js"></script>
<script>
  var vae = {
    data_dir: '/assets/data/vae_demo/',
    div_name: 'sketch',
    min_range: 0,
    max_range: 5
  };
  var custom_p5 = new p5(vae_demo(vae), vae.div_name);
</script>
<small>_The VAE I trained in [week 4](/dl/2018/06/29/energy-and-vae#experiments) on sentences in song reviews. You can load sentences that the model reconstructed well using a particular latent vector `z` and experiment with adjusting the values of `z` to see how it affects the reconstruction. Inspired by a more sophisticated demo from Ha &amp; Schmidhuber's [World Models](https://worldmodels.github.io/) project._</small>

The original demo uses [tensorflow.js](https://js.tensorflow.org/), a JavaScript library for deploying ML models in the browser. Since I didn't want to learn a new library right now, I instead pre-computed all samples offline with my PyTorch model.

The `z` vector is actually a 128-dimensional vector. Because 128 knobs would be highly unwieldy, I used principal component analysis (PCA) to reduce dimensionality down to 5. Fortunately, PCA allows us to [reverse its effect and reconstruct](https://stats.stackexchange.com/a/229093) the `z` vector, making it feasible to compute all possible samples at each available step (3 available steps in this demo) of each dimension:

$$ \mathit{n\_samples} = \mathit{n\_steps}^\mathit{n\_dimensions} * \mathit{n\_sentences} = (3^5)*5 = 243 * 5 = 1,215 \mathit{samples} $$

While these dimensions are not easily interpretable to me (i.e., it's difficult to cleanly describe what `dim1` might represent), it's interesting to explore the possible space of sentences available. Many points in the space still produce coherent sentences and phrases, which is encouraging to see.

## Selection bias

Since first crafting my [direction and syllabus for the summer](/dl/2018/06/03/project-ideation), centered around a data set of my own creation, I knew there were potential issues around where and how I get the data I wanted.

Put simply, I collected the data I collected out of **convenience**.

![Hype Machine logo](/img/posts/hype-machine.png)

During college, I religiously used a little-known site called [Hype Machine](https://hypem.com/) (HypeM) for discovering new music to add to my rotation. At the time, I was broke and used it for free, but now that I work, I am a paid subscriber. This subscription gives me access to their developer API, which gave me a great jumping off point for extracting music blog writing. Hype Machine is a brand that I _personally_ know and trust - but this is a clearly biased perspective.

In relying on HypeM, I am making a **value judgment** that the HypeM blog list represents the only valuable type of music writing on the internet (and thereby excluding, for example, social music writing on platforms like Tumblr or Twitter); conversely, I'm largely assuming that all writing from this blog list is valuable.

HypeM is **a single source that aggregates many blog sources**. It was recognized (by folks like [The Chainsmokers](https://www.billboard.com/articles/news/magazine-feature/7510387/the-chainsmokers-billboard-cover-closer) and [VICE](https://noisey.vice.com/en_au/article/kzgwvm/the-rise-and-fall-of-hype-machine-the-internets-forgotten-fave)) as an **internet 'tastemaker'** in its heyday.

But then, what is taste? When the likes of The Chainsmokers and VICE sing your praises, **whose tastes are left out**? Take for instance SoundCloud rap, which is having [a big mainstream moment right now](http://www.vulture.com/2018/04/2018-soundcloud-rappers-guide.html). What happens if we (roughly) compare the performance of **The Chainsmokers** on HypeM to that of a **Lil Uzi Vert**, who has successfully transitioned from SoundCloud to the top of the charts?

<table style='border: none'>
    <tr>
        <td style='border: none'>
            <img src='/img/posts/lil-uzi-vert.jpg' alt='Lil Uzi Vert' style='max-height:279px'>
        </td>
        <td style='border: none'>
            <img src='/img/posts/chainsmokers.jpg' alt='The Chainsmokers'>
        </td>
    </tr>
</table>
<br />

#### Lil Uzi Vert:
  - **1** #1 hit, **2** Top 10 hits, **23** total songs on [Billboard Hot 100](https://www.billboard.com/music/lil-uzi-vert/chart-history/hot-100)
  - **42** tracks (3,129 times loved by community)

#### The Chainsmokers:
  - **1** #1 hit, **5** Top 10 hits, **12** total songs on [Billboard Hot 100](https://www.billboard.com/music/the-chainsmokers/chart-history/hot-100)
  - **97** tracks on HypeM (188,696 times loved by community)

Billboard numbers are used here as an indictor of popularity, and The Chainsmokers and Lil Uzi Vert are fairly comparable. Yet The Chainsmokers have **2.3x more tracks listed** on HypeM (including remixes by other artists) than Lil Uzi Vert. This is a rather shallow analysis as many factors can influence HypeM chart performance -- but the **EDM-pop Chainsmokers do seem a bit over-represented on HypeM**.

Let's throw in another rap group: **Migos**. Better Billboard numbers, but they still underperform The Chainsmokers on HypeM:

#### Migos:
  - **1** #1 hit, **4** Top 10 hits, **32** total songs on [Billboard Hot 100](https://www.billboard.com/music/migos/chart-history/hot-100)
  - **82** tracks on HypeM (17,322 times loved by community)

In general, **pop-leaning tracks dominate** the HypeM popular charts. According to Genius.com labeling, here's a single-genre breakdown of the last 5 years on Hype Machine:

<table style="margin-left: auto;margin-right: auto;">
  <thead>
    <tr>
      <th>pop</th>
      <th>64%</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>rap</td>
      <td>15%</td>
    </tr>
    <tr>
      <td>rock</td>
      <td>14.5%</td>
    </tr>
    <tr>
      <td>r-b</td>
      <td>6.3%</td>
    </tr>
    <tr>
      <td>country</td>
      <td>0.2%</td>
    </tr>
  </tbody>
</table>
<br />
I've mentioned before not entirely trusting these labels - but assuming they are at least in the ballpark of accurate, the skew is clear.

I could also detect anecdotal evidence of bias in the kinds of samples my models have been most willing to generate:
- bias towards certain locations, e.g., "Berlin-based producer" and "LA-based producer" (this also echoes the Germany/California split from week 4's [energy-conditioned LM](/dl/2018/06/29/energy-and-vae#energy-conditioned-language-model) word clouds!)
- bias towards male-gendered pronouns, e.g., "_his_ soulfully introspective" or "_his_ debut/take/new track"

Much of this analysis is fairly imprecise, but I think it still emphasizes an important point: there are [many opportunities for discrimination in deploying machine learning systems](https://nlpers.blogspot.com/2018/06/many-opportunities-for-discimination-in.html), and it is important to be self-critical as a machine learning practitioner.
