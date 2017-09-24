---
layout: post
section-type: post
title: The Master Algorithm
category: Notes
tags: [ ]
---

> People worry that computers will get too smart and take over the world, but the real problem is that they're too stupid and they've already taken over the world.
>
> &mdash; _The Master Algorithm_ by Pedro Domingos (p. 286)

#### Book Takeaways
- <span style="color:green;">**&#43;**</span> Great at summarizing a broad field that is chock-full of seemingly complex concepts; math-free[^math-free] with lots of vocabulary clearly illustrated.
- <span style="color:green;">**&#43;**</span> Does a great job at one of its stated goals of providing a _conceptual model_ of machine learning, by breaking down its prevailing schools of thought on how to answer questions like, "how do we learn? is there a better way? what can we predict? can we trust what we've learned?" (p. xvii).
- <span style="color:green;">**&#43;**</span> As one blurb on the back cover of the book says, "writing breezily but with deep authority" is something that seems to come easily to Domingos. I enjoyed treating this book like a textbook full of gems from an almost 30-year career.
- <span style="color:red;">**&minus;**</span> Bombastic at times about the power and opportunities of machine learning, especially in the earlier chapters.[^bombastic-quotes]
- <span style="color:red;">**&minus;**</span> Its second stated goal of enabling readers to invent the Master Algorithm for themselves (p. xviii)... yeah, I'm not quite there. I appreciate Domingos's optimism though.
- <span style="color:red;">**&minus;**</span> Did not go as deeply into the ethics of machine learning as I had hoped, despite touting this in the prologue.[^ethics]

#### What is Machine Learning?

Since reading _The Master Algorithm_ by Pedro Domingos, a University of Washington professor of Computer Science, I've been engaged in a thought experiment on how to run _Principal Component Analysis (PCA)_ on the field of machine learning itself... namely, what are the principal components of ML? How can I reduce and differentiate all the jargon, discovering the shape of the field, reducing its dimensionality?

It's a fun and challenging problem to think about, searching for the minimum set of concepts to describe "the direction along which the spread [of machine learning] is greatest" (p. 214)[^pca]. Domingos favors his "five tribes" idea in the book as something like a first principal component, an overarching structure for understanding machine learning at its most essential.

>| Tribe[^t]         | Representation[^r]| Evaluation[^e]        | Optimization[^o]          |
>| ----------------- | ----------------- | --------------------- | ------------------------- |
>| _Symbolists_      | Logic             | Accuracy              | Inverse Deduction         |
>| _Connectionists_  | Neural Networks   | Squared Error         | Gradient Descent          |
>| _Evolutionaries_  | Genetic Programs  | Fitness               | Genetic Search            |
>| _Bayesians_       | Graphical Models  | Posterior Probability | Probabilistic Inference   |
>| _Analogizers_     | Support Vectors   | Margin                | Constrained Optimization  |
>
> _translated from figure on p. 240._

The five tribes analogy also got me thinking about [Brandon Rohrer](https://brohrer.github.io/blog.html)'s breakdown of the ["5 questions data science answers"](https://docs.microsoft.com/en-us/azure/machine-learning/machine-learning-data-science-for-beginners-the-5-questions-data-science-answers)[^5qs]:
1. Is this A or B? => _Classification algorithms_
2. Is this weird? => _Anomaly detection algorithms_
3. How much&mdash;or&mdash;How many? => _Regression algorithms_
4. How is this organized? => _Clustering algorithms, Dimensionality reduction_
5. What should I do next? => _Reinforcement learning algorithms_

When I view the "5 tribes" through the lens of the "5 questions," I realize that Domingos's tribe analogy only extends to the first 3 questions, which all can be answered with _supervised machine learning_ techniques. Domingos touches on techniques that deal with _unsupervised learning_ (question 4) and _reinforcement learning_ (question 5), but he does so in a single chapter (8~_Learning Without a Teacher_) that strangely does not tie back to the discussion of which tribes prefer what techniques... rather, unsupervised learning and reinforcement learning are treated like tricks in an opaque bag. It's as if Domingos is suggesting the tribes have no opinions outside of the supervised domain, which if true, would be a huge weakness for the tribes being the first principle component. The 5 questions may be a better choice.

#### The Master Algorithm

So, what is The Master Algorithm? It is ... _"a **general-purpose** learner"_ (p. xxi) ... an algorithm that, _"if it exists, [it] **can derive all knowledge in the world**&mdash;past, present, and future&mdash;from data"_ (p. xviii) ... an algorithm that can _"learn to **simulate any other algorithm** by reading examples of its input-output behavior"_ (p. 34) ... _"**the unifier of machine learning**: it lets any application use any learner, by abstracting the learner into a common form that is all the applications need to know"_ (p. 237).

What a promise.

What drew me to the book was the idea that I could get layman exposure to the entire problem space of machine learning: what types of problems it can solve, what current solutions look like, and how to express these pieces. It delivered exceedingly well for me on that level.

#### A note on my blogging process

_Originally this post was going to be extremely long and encompass many sources to output a veritable "guide to machine learning" - I figured that teaching what it is would help me learn what it is. My notes and references got longer and longer, and compiling them into a post became too daunting a task. I'm also trying to keep in mind that I tend to not bother reading "walls of words" whenever I come across them in the wild... so I should try not to write them. I haven't given up on compiling a guide - but I'd like it to be much less verbose, maybe even visual._

#### References

[^math-free]: From the book: "Textbooks are liable to give you math indigestion. This difficulty is more apparent than real, however. All of the important ideas in machine learning can be expressed math-free" (9).
[^ethics]: The _This Is the World on Machine Learning_ chapter is ostensibly the chapter to tackle these issues, and he does discuss topics such as robot warfare, restaurants with human waiters as the future's hipster/nostalgic trend, the idea that _reducing the employment rate_ will be the new sign of progress in this future ("The transition will be tumultuous, but thanks to democracy, it will have a happy ending" ...right), and killer AI (favorite contradiction found on p. 283: "The chances that an AI equipped with the Master Algorithm will take over the world are zero... Of course, if we're so foolish as to deliberately program a computer to put itself above us, then maybe we'll get what we deserve"). I don't know which it is - whether I lack imagination at this level, or if Domingos is too quick to brush off how engrained certain human behavior (ambition, pride, harming the 'other') is. I did, however, enjoy the discussion in this same chapter of the digital mirror and a society of models and federally-insured data banks.
[^bombastic-quotes]: A couple flourishes that pulled me out of the book: "A programmer&mdash;someone who creates algorithms and codes them up&mdash;is a minor god, creating universes at will" (p. 4); _day-in-the-life_ scenarios from the Prologue like, "Crime in your city is noticeably down since the police started using statistical learning to predict where crimes are most likely to occur and concentrating beat officers there" (p. xv) - sure, because ethics in policing are that straightforward.
[^pca]: Borrowing from Domingos's definition of PCA.
[^t]: _Symbolists_ believe in the power of pre-existing knowledge and manipulating symbols; _Connectionists_ base their practice on reverse-engineering of the brain; _Evolutionaries_ see natural selection and learning structure as the key; _Bayesians_ hold uncertainty as inescapable; _Analogizers_ recognize similarities and use them to infer other similarities.
[^r]: Representation: "the formal language in which the learner expresses its models" (p. 240).
[^e]: Evaluation: "a scoring function that says how good a model is" (p. 241).
[^o]: Optimization: "the algorithm that searches for the highest-scoring model and returns it" (p. 241).
[^5qs]: This 25-minute "Data Science for Beginners" video series is one of my favorite data science references.
