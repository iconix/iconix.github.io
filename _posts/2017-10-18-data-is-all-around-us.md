---
layout: post
section-type: post
title: Data Is All Around Us
category: Portfolio Building
tags: [ ] # 'python', 'r'
---

In my [first post](/blogging/2017/05/07/hello-world.html#building-a-portfolio), I mentioned having a mentor who _encouraged me to build up a portfolio of at least 3 well-curated, beautiful data projects_. Unsure on how to get to beautiful, I asked whether she could share any projects that I could hold as the "gold standard" while building my own portfolio.

She shared a few of her favorites on the web, mentioning that David Robinson of the [Variance Explained](http://varianceexplained.org/) blog has a lot of great examples.

Right now, I want to focus on one particular blog post of David's that I admire: ["Analyzing networks of characters in _Love Actually_"](http://varianceexplained.org/r/love-actually-network/). Why? It's a cute, simple, effective example of playing with data for neat results. I especially like his closing paragraphs on the why behind the post:

> Have you heard the complaint that we are "drowning in data"? How about the horror stories about how no one understands statistics, and we need trained statisticians as the "police" to keep people from misinterpreting their methods? It sure makes data science sound like important, dreary work.
>
> Whenever I get gloomy about those topics, I try to spend a little time on silly projects like this, which remind me why I learned statistical programming in the first place. It took *minutes* to download a movie script and turn it into usable data, and within a few hours, I was able to see the movie in a new way. We're living in a wonderful world: one with powerful tools like R and Shiny, and one overflowing with resources that are just a Google search away.
>
> Maybe you don't like 'Love Actually'; you like [Star Wars](https://github.com/Ironholds/rwars). Or you like [baseball](http://varianceexplained.org/r/bayesian_fdr_baseball/), or you like [comparing programming languages](http://varianceexplained.org/r/polarizing-technologies/). Or you're interested in [dating](http://oktrends.okcupid.com/), or [hip hop](http://poly-graph.co/vocabulary.html). Whatever questions you're interested in, the answers are just a search and a script away. If you look for it, I've got a sneaky feeling you'll find that **data actually is all around us.**
>
> &mdash; ["Analyzing networks of characters in _Love Actually_"](http://varianceexplained.org/r/love-actually-network/) by [David Robinson](http://varianceexplained.org/about/) / [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)

Silly projects make the world go 'round. And to me, this post is an opportunity to warm up my own skills with a remix: I am going to replicate this analysis, replacing R with Python and a Jupyter notebook, for a hands-on guided experience into great technique. I'll also add more commentary on the smaller choices made in the project.

This will allow me to set up my coding environment, reacquaint myself with nitty-gritty R and Python, build my ~~first~~ Jupyter notebook[^first], and really understand the subtleties of the code David wrote. I'm excited, so let's jump in!

---

## Code

GitHub repo: [https://github.com/iconix/love-actually](https://github.com/iconix/love-actually) - includes the Jupyter (Python) notebook, Shiny app code, and documentation I added to the R code.

Shiny app: [https://iconix.shinyapps.io/love-actually-network/](https://iconix.shinyapps.io/love-actually-network/)

## R Walkthrough

My first pass through the R code, way back in July, was in order to understand what each line does. There was plenty unfamiliar, and the code could get dense at times. Feel free to take a look at the [comments I added](https://github.com/iconix/love-actually/blob/master/r/love_actually.R) to David's original R file during this process - most are about defining what different libraries and functions in R do.

# From R to Python

**My goal**: Recreate `love_actually_data.rda` in Python using pandas; then convert output into `.Rdata` format and feed into Shiny app.

[Notebook](https://github.com/iconix/love-actually/blob/master/python/love-actually.ipynb) embed below[^cmd].

---
{% include notebooks/love-actually.html %}

# Shiny App

Here is the grande finale output of this code - try hovering over the nodes and moving the slider around!

<iframe src="https://iconix.shinyapps.io/love-actually-network/" style="border: none; width: 100%; height: 863px"></iframe>

### R Tips

**1. Environment setup**

For understanding David's script, I already had R and RStudio installed from [an intro course I took on R](https://www.coursera.org/learn/r-programming). Note that the `installr` package (I reference it later) recommends usage through RGui rather than RStudio. Since it wasn't obvious to me, RGui is the default R console that comes with your R installation. (I went back to RStudio after running `installr`.)

**2. Error: package or namespace load failed for 'dplyr'**

I took the preceding _Warning: package 'dplyr' was built under R version 3.2.5_ as a hint to update my version of R from 3.2.3. I'm unsure if this affects all Tidyverse libraries, but after the update to 3.4.1 (using the [`installr`](https://www.r-statistics.com/2013/03/updating-r-from-r-on-windows-using-the-installr-package/) package), I had no other installation issues.

**3. ? for R's built-in help files**

My first instinct was to Google libraries and functions that I didn't recognize, but that didn't always return anything definitive. Then I remembered the power of the `?`. It is especially hard in R to track which functions comes from what libraries, but the help files can tell you.
> <pre><code data-trim class="r">> ? data_frame</code></pre>

**4. Install libraries with `install.packages()`**

I forgot and had to look up this command.

#### References

[^first]: When I first started drafting this post on 4th of July weekend, I had no hands-on experience with Juypter. The fast.ai coursework I [started in mid-July](/portfolio-building/2017/07/26/first-kaggle.html) changed that and helped clear up the "where to start?/where is Python now?" questions I had initially. I got caught up in [various](/notes/2017/08/18/fast-week2.html) [other](/notes/2017/09/23/master-algorithm.html) [efforts](/portfolio-building/2017/09/25/nlp-for-tasks.html), big and small - but I'm here now to finally complete this post.
[^cmd]: Embed via ```jupyter nbconvert --config scripts/nbconvert_config.py ../love-actually/python/love-actually.ipynb```
