---
layout: post
section-type: post
title: Advice on OpenAI Scholars
category: Notes
tags: [ 'openai' ]
---

I am taking some blogging advice that I've read elsewhere: if multiple people ask you similar questions offline, answer those questions in a blog post!

It has been awesome to hear that others are **eager to apply for the next cohort** of OpenAI Scholars. I wrote a bit about [my 2018 summer takeaways](/dl/2018/08/31/deephypebot-final#what-ive-learned-this-summer) in my final "official" blog post for the program, but I would like to expand a bit on:
1. What I learned and got out of this program
2. What I wish I had approached differently
3. My advice on how to both apply and succeed once accepted.

Note: Much of what I will say is _subject to change_ since I participated in the inaugural Scholar cohort. OpenAI will naturally iterate like any good engineer 😊

## What I've Learned

The OpenAI Scholars program is a really great opportunity for **self-motivated newcomers to deep learning**. It is important to recognize that Scholars are asked to set aside their regular schedules for 13 weeks of intensive self-study, with a touch of guidance from their assigned mentor.

**What you put in is what you get out.** It starts with the syllabus you create for your own program ([here was mine](https://github.com/iconix/openai/blob/master/syllabus.md)). I decided to focus on _natural language processing_; some Scholars had other focuses like [_reinforcement learning_](https://hollygrimm.com/reinforcementlearning), while others took more of a [broad survey](https://everyd-ai.com/blog/) of deep learning approaches.

**Preparation can only help.** While the Scholars program is especially geared towards software engineers with little-to-no deep learning experience, it can't hurt to become familiar with the subject matter of the program. Prior to the summer, I had taken (a now outdated version of) [Andrew Ng's _Machine Learning_ course](/notes/2017/07/03/ng-ml-notes) and [fast.ai's _Practical Deep Learning for Coders_](http://course.fast.ai/). I still had a ton of learning to do over the summer, but it was helpful not having to start at ground zero.

**13 weeks can fly by _fast_.** The time pressure this summer was really real. This is all the more reason to try to keep to a schedule. Even so, nearly every Scholar in my cohort created an overambitious syllabus. This turned out to be fine, generally -- we could adjust our syllabi and schedules as we went. I even wrote a little bit about the craziness of my schedule [in week 5](/dl/2018/07/06/not-enough-attention#diversions-and-a-breakthrough), when **I determined to _not_ get discouraged by the pace, as long as I kept working and making progress**. I'd really encourage this mindset -- my [final project](/dl/2018/08/31/deephypebot-final) turned out fine in the end 😊

**Learn by doing.** Textbooks are cool, but being able to apply a new skill each week (or week-and-a-half) is really rewarding. Re-implementing tutorials and running experiments in Jupyter notebooks were helpful activities week to week.

Other miscellaneous tips:
- Start reading background/related work early in order to inform your syllabus and program experience
- Use version control early on
- Take the writing assignments seriously -- your blog is a valuable platform!
- Get an early start on setting up a personal blog (this site is built on [GitHub Pages](https://pages.github.com/) and [Jekyll](https://jekyllrb.com/docs/github-pages/))
- Get on [Twitter](https://twitter.com/ohnadj) -- there's a lot of ML and deep learning discussions going on there (which I didn't know before the program)!

## How to Apply and Succeed

When applying, I would suggest highlighting what about your personal story makes you an interesting candidate for this program. Also make sure that your strong technical aptitude comes across clearly throughout the application.

**Be aware** of both the benefits and requirements of the program.

Benefits
- World-class mentorship (really take full advantage of this and create a strong partnership)
- Raw computing resources through AWS
- Time + space + a stipend to learn
- A visible platform through OpenAI
- Your choice between fully remote work, a desk in San Francisco, or a mix of both (I was not based in SF but made a couple visits anyway to make in-person connections -- and this was welcomed by OpenAI)

Cautions
- Truly self-driven
- Quite unstructured
- Since this is a very new program that isn't really being done elsewhere (e.g., residencies at Brain and FAIR, which I believe are the next closest program type, seem to cater towards a different applicant pool with different goals and expectations), expect some open-endedness and mild chaos at times. But also know that the program is evolving, and there are good intentions at OpenAI.
- I feel that OpenAI moving forward could do a better job of preparing future Scholars for industry -- how to navigate the field/job market, best practices and how to succeed -- directly from researchers and engineers who have these experiences.

## Things I Would Do Differently

These reflections are about ways I personally think I could have approached the summer a bit differently.

- With the fast pacing, I ignored writing test code (what does it even mean to test ML code?), which felt pretty bad as an engineer. In general, more time spent on engineering fundamentals would have made me feel better.
- Due to concerns about not having enough training data for deep learning, I did not create validation or test sets early on in the summer. So by the final project when I needed a test set especially, my existing data was too tampered with to use for those purposes, and I didn't have enough time to collect new data. (I do have plans to collect a new data set of more recent music commentary.)
- While my syllabus period was fairly incremental, my final project was not so much. I wish I had the time to incrementally build out and tweak my final model, but engineering tasks for building an end-to-end system competed hard for my time.

I hope this provides useful information for anyone considering applying to be a Scholar! Overall, it was definitely a worthwhile summer for me.

### _Follow my progress this summer with this blog's [#openai](/tags/openai) tag, or on [GitHub](https://github.com/iconix/openai)._
