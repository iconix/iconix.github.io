---
layout: post
section-type: post
title: Data Is All Around Us
category: Portfolio-Building
tags: [ 'python', 'r' ]
---

In my [first post](/blogging/2017/05/07/hello-world.html#building-a-portfolio), I mentioned having a mentor who _encouraged me to build up a portfolio of at least 3 well-curated, beautiful data projects_. Unsure on how to get to beautiful, I asked whether she could share any projects that I could hold as the "gold standard" while building my own portfolio.

She shared a few of her favorites on the web, mentioning that David Robinson of the [Variance Explained](http://varianceexplained.org/) blog has a lot of great examples.

Right now, I want to focus on one particular blog post of David's that I admire: ["Analyzing networks of characters in _Love Actually_"](http://varianceexplained.org/r/love-actually-network/). Why? It's a cute and simple and effective example of playing with data for neat results. I especially like his closing paragraphs on the why behind the post:

> Have you heard the complaint that we are "drowning in data"? How about the horror stories about how no one understands statistics, and we need trained statisticians as the "police" to keep people from misinterpreting their methods? It sure makes data science sound like important, dreary work.
>
> Whenever I get gloomy about those topics, I try to spend a little time on silly projects like this, which remind me why I learned statistical programming in the first place. It took *minutes* to download a movie script and turn it into usable data, and within a few hours, I was able to see the movie in a new way. We're living in a wonderful world: one with powerful tools like R and Shiny, and one overflowing with resources that are just a Google search away.
>
> Maybe you don't like 'Love Actually'; you like [Star Wars](https://github.com/Ironholds/rwars). Or you like [baseball](http://varianceexplained.org/r/bayesian_fdr_baseball/), or you like [comparing programming languages](http://varianceexplained.org/r/polarizing-technologies/). Or you're interested in [dating](http://oktrends.okcupid.com/), or [hip hop](http://poly-graph.co/vocabulary.html). Whatever questions you're interested in, the answers are just a search and a script away. If you look for it, I've got a sneaky feeling you'll find that **data actually is all around us.**
>
> &mdash; ["Analyzing networks of characters in _Love Actually_"](http://varianceexplained.org/r/love-actually-network/) by [David Robinson](http://varianceexplained.org/about/) / [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)

Silly projects make the world go 'round. And to me, this post is an opportunity to warm up my own skills with a remix: I am going to replicate this analysis, replacing R with Python and a Jupyter notebook, for a hands-on guided experience into great technique. I'll also add more commentary on the smaller choices made in the project.

This will allow me to set up my coding environment, reacquaint myself with nitty-gritty R and Python, build my first Jupyter notebook, and really understand the subtleties of the code David wrote. I'm excited, so let's jump in!

---

### Tips

**1. Environment setup**

For understanding David's script, I already had R and RStudio installed from [an intro course I took on R](https://www.coursera.org/learn/r-programming). Note that the `installr` package (I reference it later) recommends usage through RGui rather than RStudio. Since it wasn't obvious to me, RGui is the default R console that comes with your R installation.

**2. Error: package or namespace load failed for 'dplyr'**

I took the preceding _Warning: package 'dplyr' was built under R version 3.2.5_ as a hint to update my version of R from 3.2.3. I'm unsure if this affects all Tidyverse libraries, but after the update to 3.4.1 (using the [`installr`](https://www.r-statistics.com/2013/03/updating-r-from-r-on-windows-using-the-installr-package/) package), I had no other installation issues.

**3. ? for R's built-in help files**

My first instinct was to Google libraries and functions that I didn't recognize, but that didn't always return anything definitive. Then I remembered the power of the `?`. It is especially hard in R to track which functions comes from what libraries, but the help files can tell you.
> <pre><code data-trim class="r">> ? data_frame</code></pre>

**4. Install libraries with `install.packages()`**

I forgot and had to look up this command.

### Code Walkthrough

First pass through the R code was to understand what each line does. There was plenty unfamiliar, and the code could get dense at times. ...

#### R Libraries

To get acquainted with:
> tidyverse (dplyr, stringr, tidyr, ggplot2, magrittr), reshape2, stats, graphics, igraph, base

[**Tidyverse**](http://tidyverse.org/) is a collection of R packages working in harmony towards tidying your data. As explained by the collection's companion book [_R for Data Science_](http://r4ds.had.co.nz/introduction.html), "Tidy data is important because the consistent structure lets you focus your struggle on questions about the data, not fighting to get the data into the right form for different functions." Tidyverse (currently) contains [3 of the top 10 most downloaded R packages](https://www.rdocumentation.org/trends): readr, dplyr, and ggplot2.

Tidyverse packages used in David's code: dplyr, stringr, tidyr, ggplot2, magrittr.

[**Reshape2**](https://github.com/hadley/reshape) is written by one of the chief contributors to the Tidyverse (who, I just discovered while checking out his Github, is [Chief Scientist at RStudio](https://github.com/hadley)). It ["makes it easy to transform data between wide and long formats"](http://seananderson.ca/2013/10/19/reshape.html) - the whole melting+casting paradigm of this library is pretty cool.
> It turns out that you need wide-format data for some types of data analysis and long-format data for others. In reality, you need long-format data much more commonly than wide-format data. For example, `ggplot2` requires long-format data (technically [tidy data](http://vita.had.co.nz/papers/tidy-data.html)), `plyr` requires long-format data, and most modelling functions (such as `lm()`, `glm()`, and `gam()`) require long-format data. But people often find it easier to record their data in wide format.
>
> &mdash; ["An Introduction to reshape2"](http://seananderson.ca/2013/10/19/reshape.html) by [Sean C. Anderson](http://seananderson.ca/) / [CC BY-NC 3.0](https://creativecommons.org/licenses/by-nc/3.0/deed.en_US)

[**igraph**](http://igraph.org/) is collection of network analysis tools.

[**Base R**](https://stat.ethz.ch/R-manual/R-devel/library/): stats, graphics, base.

#### Terminology

> .Rdata (.rda, load), Shiny app, hierarchical clustering, melting and casting, dendrogram, tidy data, cooccurence(/adjacency?) matrix

### From R to Python

Questions:
> 1. Python IDE: should I use Spyder (that came with Anaconda)? VS Code? Jupyter directly?
> 2. pip install, pandas, anaconda (cheat sheet), matplotlib, numpy, scipy
> 3. Where to start?/Where is Python now? [Data Analysis with Python and Pandas Tutorial Introduction](https://www.youtube.com/watch?v=Iqjy9UqKKuo)

Tasks to accomplish:
> 1. Read in script lines, character->actor csv
> 2. Transform script into data frame with scene#, line#, character speaking, line of dialogue, and actor
> 3. Counts lines per scene per character
> 4. Cast into binary speaker-scene matrix
> 5. Hierarchical clustering
> 6. Timeline visualization
> 7. Coocurrence heatmap
> 8. Network graph visualization
> 9. Output data frame in a way R can consume for Shiny app usage

Tasks 1-4 are data munging/parsing/tidying. 5-8 are analysis and visualization. Task 9 is UX-friendly output.

### Shiny

### Jupyter

### David's pearls of wisdom

"Whenever we have a matrix, it's worth trying to cluster it."

"One reason it's good to lay out raw data like this (as opposed to processed metrics like distances) is that anomalies stand out."
