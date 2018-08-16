---
layout: post
section-type: post
title: Notes on genre and inspiration
category: DL
tags: [ 'openai' ]
---

My [final project](/dl/2018/08/03/deephypebot) is underway, and it feels like I get to return to my software engineering roots with these powerful, new deep learning techniques in my tool belt. This is a welcome opportunity to flex what I've learned this summer.[^flex]

It is also quite freeing to be able to focus once again on a single objective for a few weeks, in contrast to my [one-new-thing-a-week pace](/dl/2018/07/06/not-enough-attention#diversions-and-a-breakthrough) from earlier in the program.

## Inspiration: Live from Chicago

I have been working from Chicago this August -- this is my first trip to the Windy City, and the change of scenery has brought inspiration and refreshment.

I visited the [Chicago History Museum](https://www.chicagohistory.org/) and found the [**_Amplified: Chicago Blues_ exhibit**](https://www.chicagohistory.org/blues) particularly inspiring towards my final project aim of paying homage to good, expressive music commentary.

It was also a sobering reminder that not all commentary is worth amplifying or computationally imitating.

<table style='border: none;margin-left: auto;margin-right: auto;'>
  <tbody>
    <tr>
      <td style='border: none'><img src="/img/posts/chi_commentary_good.jpg" alt="good commentary" style="max-height: 400px"></td>
      <td style='border: none'><img src="/img/posts/chi_commentary_bad.jpg" alt="bad commentary" style="max-height: 400px"></td>
    </tr>
  </tbody>
</table>
<small><i>eclectic guitar, amplified harp solos, and driving rhythm section</i> - this is the ideal type of writing I'd love to consistently see my model generate. and yet, I must also be wary of amplifying the troll-like writing on the right, i.e., <i>screaming, idiotic words, and savage music</i> - which, in this case, is also blatantly racist.</small>
<br />

A good friend of mine here in Chicago reminded me of the **social responsibilities** that I must strive to always keep in mind, even when developing in a seemingly harmless domain (because what could be so bad about automatic music commentary, right?).

If I make contributions towards realistic text generation, **what am I enabling?** [Automated fake Yelp reviews](https://www.businessinsider.com/researchers-teach-ai-neural-network-write-fake-reviews-fake-news-2017-8), fake news, troll bots? **How can this tech be re-purposed, and how should this affect the work that I do?** These are questions that I continue to grapple with.

## Inspiration: Twitter edition

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">weirdly motivating for me right now <a href="https://t.co/6tUGNSPqva">https://t.co/6tUGNSPqva</a></p>&mdash; Nadja Rhodes (@ohnadj) <a href="https://twitter.com/ohnadj/status/1027026347137400834?ref_src=twsrc%5Etfw">August 8, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<small>_re:actually building out this final project :grimacing: exciting, yet slightly intimidating in the given time frame._</small>

## Exploring genre

For several weeks now, I have [expressed doubt](/dl/2018/06/29/energy-and-vae#fn:genre) in the genre information I collected in weeks 2-3. Genres were collected (along with song audio features) as a way of conditioning my generated music commentary on something concrete about the song being commented on.

### Data cleaning

This week, I finally revisited and addressed the situation by collecting new genre information from the Spotify API instead. The genres themselves are extremely fascinating, and I had no idea they would be so amazingly specific![^everynoise]

_"vapor twitch" -- "indie poptimism" -- "stomp and holler"_ -- these new genres go far beyond the _bland_ labels of pop/rap/rock/r&b/country that I had previously gathered. **These genres feel like they are _really_ trying to tell me something, as expressively and concisely as possible.**

At first, this discovery was actually a little discouraging: I could only imagine how long the genre data tail would be once applied to my commentary collection. I worried that this would result in conditioning that really isolated certain writing, greatly restricting the creativity of my model. Imagine a request for commentary on a _"chamber pop/chillwave/neo-psychedelic/nu gaze"_ (:nerd_face:) song came in to my model, but it's never seen such a genre combination before -- what will it do? (I'm still not sure actually, so stay tuned for when I get to conditioning!)

Nevertheless, I was able to run some numbers to find that the tail doesn't appear absolutely unmanageable. I also applied some simple genre clustering to further reduce the tail.

When all was said and done this week, I had **130** unique genre labels over almost **20,000** writing samples. There are **1,135** unique genre _combinations_, since each sample can contain multiple genres.

I am using this notebook to track data revision history from now on: [**`quilt.ipynb`**](http://nbviewer.jupyter.org/github/iconix/openai/blob/master/nbs/quilt.ipynb). Check it out for a more detailed sketch of the genre data cleaning I performed this week. I also switched from [Git LFS](https://git-lfs.github.com/) to [**Quilt**](https://quiltdata.com) this week for **better data packaging and versioning**.

### Data exploring

When I started clustering genres, many neat insights emerged. This section turned into a spiritual successor to my [earlier bias investigation](/dl/2018/07/21/bias-and-space#selection-bias).
- #1 genre found in my commentary collection? _vapor soul_
- How different is the #1 from the #2 genre, indie poptimism, according to Every Noise? [_not very_](http://everynoise.com/engenremap-indiepoptimism.html)
- Which genre that was at least visible ([at 0.2% representation](/dl/2018/07/21/bias-and-space#selection-bias)) in my old genre labels is conspicuously missing now? _country_

[The Every Noise project](http://everynoise.com) enabled some deeper diving into how to better interpret these somewhat opaque labels. It provides "an algorithmically-generated, readability-adjusted **scatter-plot** of the musical genre-space", where:
> "in general down is more organic, up is more mechanical and electric; left is denser and more atmospheric, right is spikier and bouncier."

These scatter plots can show both **similar and dissimilar genres** to a specific genre, as well as which artist tend to belong to a genre.

It can tell you what it believes is the ["most representative"](https://artists.spotify.com/blog/how-spotify-discovers-the-genres-of-tomorrow) song for a genre label. It links to genre-based playlists on Spotify.

Let's take a look at the **top genres** in my commentary collection:

![genre cloud](/img/posts/genrecloud.png)
<small><i>Top 25: 1. vapor soul (4344), 2. indie poptimism (3886), 3. pop (3799), 4. indietronica (3462), 5. electropop (3406), 6. indie r&b (3242), 7. tropical house (2359), 8. modern rock (2171), 9. indie psych-rock (1942), 10. indie pop (1845), 11. shimmer pop (1827), 12. edm (1826), 13. chillwave (1705), 14. rap (1452), 15. indie electro-pop (1451), 16. alternative dance (1418), 17. metropopolis (1303), 18. hip hop (1230), 19. pop rap (1174), 20. nu disco (1086), 21. dance pop (1054), 22. chamber pop (996), 23. aussietronica (973), 24. art pop (973), 25. house (917).</i></small>

<table style='border: 1px solid black'>
  <thead>
    <tr>
      <th>Genre (Rank)</th>
      <th>Most Representative Track</th>
      <th>Similar Genre Map</th>
      <th>Similar Top Genres</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style='border: 1px solid black'><strong>vapor soul (#1)</strong></td>
      <td style='border: 1px solid black'><iframe src="https://open.spotify.com/embed/track/28axGcu9he7YdQ0xwXIaC9" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe><br>“No One - Kayge Calypso &amp; DUNN Remix” by Mothica</td>
      <td style='border: 1px solid black'>
<img src="/img/posts/genremap_vaporsoup.png" alt="'vapor soul' genre map"><a href="http://everynoise.com/engenremap-vaporsoul.html">http://everynoise.com/engenremap-vaporsoul.html</a>
</td>
      <td style='border: 1px solid black'>indie poptimism (#2), indietronica (#4), electropop (#5), indie r&amp;b (#6), tropical house (#7), modern rock (#8), indie psych-rock (#9), indie pop (#10), shimmer pop (#11), chillwave (#13), indie electro-pop (#15), metropopolis (#17), aussietronica (#23), vapor twitch (#26), vapor pop (#30), gauze pop (#33)</td>
    </tr>
    <tr>
      <td style='border: 1px solid black'><strong>edm (#12)</strong></td>
      <td style='border: 1px solid black'><iframe src="https://open.spotify.com/embed/track/4ABdTWafMCXfATpILRuZFW" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe><br>“IDWK” by DVBBS</td>
      <td style='border: 1px solid black'>
<img src="/img/posts/genremap_edm.png" alt="'edm' genre map"> <a href="http://everynoise.com/engenremap-edm.html">http://everynoise.com/engenremap-edm.html</a>
</td>
      <td style='border: 1px solid black'>pop (#3), tropical house (#7), house (#25), electro house (#31), electronic trap (#38), big room (#42), deep tropical house (#46), brostep (#48), australian dance (#54), tropical pop edm (#56), bass trap (#58), progressive house (#59), progressive electro house (#71), deep groove house (#74), complextro (#81), catstep (#91), chillstep (#99), trance (#124)</td>
    </tr>
    <tr>
      <td style='border: 1px solid black'><strong>rap (#14)</strong></td>
      <td style='border: 1px solid black'><iframe src="https://open.spotify.com/embed/track/5S1IUPueD0xE0vj4zU3nSf" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe><br>“Bigger Than You (feat. Drake &amp; Quavo)” by 2 Chainz</td>
      <td style='border: 1px solid black'>
<img src="/img/posts/genremap_rap.png" alt="'rap' genre map"> <a href="http://everynoise.com/engenremap-rap.html">http://everynoise.com/engenremap-rap.html</a>
</td>
      <td style='border: 1px solid black'>pop (#3), indie r&amp;b (#6), pop rap (#19), dance pop (#21), r&amp;b (#53), trap music (#40), gangster rap (#65), dirty south rap (#98), hip hop (#18), southern hip hop (#39), underground hip hop (#43), conscious hip hop (#64), alternative hip hop (#67), urban contemporary (#76), hip pop (#121), hardcore hip hop (#130)</td>
    </tr>
    <tr>
      <td style='border: 1px solid black'><strong>nu disco (#20)</strong></td>
      <td style='border: 1px solid black'><iframe src="https://open.spotify.com/embed/track/3fDrZa4ksxA5lgi0utGu6k" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe><br>“So Good to Me” by Chris Malinchak</td>
      <td style='border: 1px solid black'>
<img src="/img/posts/genremap_nudisco.png" alt="'nu disco' genre map"> <a href="http://everynoise.com/engenremap-nudisco.html">http://everynoise.com/engenremap-nudisco.html</a>
</td>
      <td style='border: 1px solid black'>indietronica (#4), tropical house (#7), chillwave (#13), alternative dance (#16), new rave (#27), filter house (#44), deep house (#51), disco house (#86), balearic (#123)</td>
    </tr>
    <tr>
      <td style='border: 1px solid black'><strong>electronic (#47)</strong></td>
      <td style='border: 1px solid black'><iframe src="https://open.spotify.com/embed/track/7xQYVjs4wZNdCwO0EeAWMC" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe><br>“Born Slippy (Nuxx)” by Underworld</td>
      <td style='border: 1px solid black'>
<img src="/img/posts/genremap_electronic.png" alt="'electronic' genre map"> <a href="http://everynoise.com/engenremap-electronic.html">http://everynoise.com/engenremap-electronic.html</a>
</td>
      <td style='border: 1px solid black'>indietronica (#4), electropop (#5), chillwave (#13), alternative dance (#16), art pop (#24), new rave (#27), indie rock (#29), filter house (#44), dance-punk (#45), chamber psych (#49), downtempo (#52), microhouse (#69), bass music (#75), trip hop (#77), ninja (#79), wonky (#90), danish electro-pop (#92), alternative rock (#97), swedish synthpop (#100), intelligent dance music (#103), nu jazz (#105), minimal techno (#110), fluxwork (#111), big beat (#116), future funk (#122)</td>
    </tr>
    <tr>
      <td style='border: 1px solid black'><strong>freak folk (#55)</strong></td>
      <td style='border: 1px solid black'><iframe src="https://open.spotify.com/embed/track/5Ob2Wt2IifgoFrSFrBnRZJ" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe><br>“Bum Bum Bum” by Cass McCombs</td>
      <td style='border: 1px solid black'>
<img src="/img/posts/genremap_freakfolk.png" alt="'freak folk' genre map"> <a href="http://everynoise.com/engenremap-freakfolk.html">http://everynoise.com/engenremap-freakfolk.html</a>
</td>
      <td style='border: 1px solid black'>indietronica (#4), modern rock (#8), indie pop (#10), chillwave (#13), alternative dance (#16), chamber pop (#22), art pop (#24), new rave (#27), indie rock (#29), folk-pop (#36), neo-psychedelic (#41), dance-punk (#45), stomp and holler (#50), nu gaze (#57), brooklyn indie (#61), dream pop (#62), preverb (#66), garage rock (#84), noise pop (#87), lo-fi (#89), alternative rock (#97), fluxwork (#111)</td>
    </tr>
    <tr>
      <td style='border: 1px solid black'><strong>neo soul (#60)</strong></td>
      <td style='border: 1px solid black'><iframe src="https://open.spotify.com/embed/track/0tNuJpBgtE65diL6Q8Q7fI" width="300" height="380" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe><br>“On &amp; On” by Erykah Badu</td>
      <td style='border: 1px solid black'>
<img src="/img/posts/genremap_neosoul.png" alt="'neo soul' genre map"> <a href="http://everynoise.com/engenremap-neosoul.html">http://everynoise.com/engenremap-neosoul.html</a>
</td>
      <td style='border: 1px solid black'>pop (#3), indie r&amp;b (#6), hip hop (#18), dance pop (#21), southern hip hop (#39), urban contemporary (#76), funk (#94), soul (#101), hip pop (#121)</td>
    </tr>
  </tbody>
</table>

<br/>

<small>Observations from the rabbit hole:</small>
- <small>The top 11 genres are considered very similar to each other. Also similar: #13, #15, #17, #23...</small>
- <small>Rap and freak folk have tall genre maps, indicating more variation between "organic" and "mechanical and electric" and less variation between "atmospheric" and "spikier and bouncier" sounds. Interestingly, rap and freak folk are considered very dissimilar genres by Every Noise.</small>
- <small>Another comment on representation is to note the sparsity of similar top genres to nu disco and neo soul ... and the density to genres vapor soul, edm, and electronic.</small>
- <small>I do like the distinctions between the edm and electronic genres... a tale of two houses.</small>
- <small>There are still many interesting top genres left out of this manual clustering: indie folk (#28), indie anthem-folk (#32), escape room (#34), post-teen pop (#35), deep australian indie (#37), future garage (#63), swedish electropop (#68), modern alternative rock (#70)...</small>
- <small>Interesting to look at top genres that didn't cluster as I expected... e.g., rap (#14) was _not_ particularly similar to electronic trap (#38), bass trap (#58), or trap soul (#80). And despite its affinity for other house genres, edm (#12) was _not_ particularly similar to filter house (#44), deep house (#51), microhouse (#69), disco house (#86), or float house (#108).</small>
- <small>Interesting to also look at the dissimilarity scatter-plots and notice what's under-represented in top genres, e.g.,: negations of vapor soul (anti-folk, no wave, art rock, modern blues, blues-rock); negations of edm (movie tunes, christmas, broadway, disney, lots of region-specific music); negations of rap (post rock, anime score, hauntology, neoclassical)</small>

This _Every Noise_-based clustering (e.g., adding under-represented "new jack swing" to the similar but better-represented "rap" genre) to reduce the genre tail is not what I'm using for the project, although this would be a very cool extension.

I'm looking forward to seeing the effects of conditioning my model on this genre information!

### _Follow my progress this summer with this blog's [#openai](/tags/openai) tag, or on [GitHub](https://github.com/iconix/openai)._

#### Footnotes

[^flex]: Perhaps this is the true meaning of ["Flexing To The Study"](/dl/2018/06/20/arxiv-song-titles#best-of) :slightly_smiling_face:
[^everynoise]: I definitely went down an internet rabbit hole on [how Spotify genres came to be so specific](https://insights.spotify.com/us/2015/09/30/50-strangest-genre-names/), the truly fascinating [Every Noise project](http://everynoise.com/) (#goals), and [the 'data alchemist' behind it all, Glenn McDonald](https://www.thestar.com/entertainment/2016/01/14/meet-the-man-classifying-every-genre-of-music-on-spotify-all-1387-of-them.html). I am shocked I had never heard of _any_ of this before!


