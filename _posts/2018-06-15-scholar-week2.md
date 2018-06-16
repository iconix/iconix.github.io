---
layout: post
section-type: post
title: OpenAI Scholar, Week 2
category: Career
tags: []
---

I spent a busy week training _recurrent neural networks_ (RNNs) using PyTorch, with the ultimate goal of training a _long short-term memory_ (LSTM) network, as promised by my [syllabus](https://github.com/iconix/openai/blob/master/syllabus.md).

## Part I. The limitations of n-grams

But why use RNNs when I generated such [_amazing_ text](/career/2018/06/08/scholar-week1#part-ii-generating-terrible-music-reviews-with-n-grams) last week?

Just kidding. While the _Unsmoothed Maximum Likelihood Character Language Model_ generated a few gems, a lot of it was either nonsensical or plagiarized from the training text.

N-gram models generally have issues like the following:

- The smaller the _order_ `n`, the higher the _bias_; the larger the _order_, the higher the _variance_ [[Jacob Eisenstein](https://github.com/jacobeisenstein/gt-nlp-class/blob/master/notes/eisenstein-nlp-notes.pdf)]. Practically, this means a **small `n` will underfit**, struggling to represent the true distribution of the language, while a **large `n` will overfit**, being very dependent on whatever data happens to be in the training set.
![Bias-variance tradeoff](/img/posts/bias-variance-tradeoff.svg)
<p style='text-align: center'><em>The bias-variance tradeoff. Image adapted from <a href='https://towardsdatascience.com/understanding-the-bias-variance-tradeoff-165e6942b229'>"Understanding the Bias-Variance Tradeoff"</a> by Seema Singh.</em></p>

- A restricted or fixed context like `n` means that **any information outside of the context window is ignored** [[Jacob Eisenstein](https://github.com/jacobeisenstein/gt-nlp-class/blob/master/notes/eisenstein-nlp-notes.pdf)]. So _structural_ things like closing a quotation, or _linguistic_ things like subject-verb agreement can only be learned with a very large `n`.
- But aside from overfitting, a larger `n` means an exponentially increasing number of parameters to fit [[Daniel Jurafsky & James Martin](https://web.stanford.edu/~jurafsky/slp3/4.pdf)]. The **_curse of dimensionality_** - bad for learning.
- [Jurafsky & Martin](https://web.stanford.edu/~jurafsky/slp3/4.pdf) also call out n-grams for their **inability to "generalize from training to test set**." Compare this to RNNs and their _representation learning_, which can "project words into a continuous space in which words with similar contexts have similar representations."
- Alex Graves, in his paper [_Generating Sequences with Recurrent Neural Networks (2014)_](https://arxiv.org/pdf/1308.0850.pdf), compares 'fuzzy' RNNs to **'template-based'** algorithms - which points squarely at the duplicating behavior of the n-gram model, particularly at higher orders.

Too small an `n` and you lose context; too large and you make training difficult and brittle. And even if some magical `n` sweet spot exists, it won't generalize to a test set!

In order to generate more complex and compelling text, let's turn our attention (_foreshadowing_) to neural networks!

## Part II. Getting familiar with RNNs

Recurrent neural networks are a _huge_ topic, in a summer of huge topics. This week, I tried to strike a balance between training the best RNN I can train (i.e., using other people's code), versus training the best RNN I can _fully understand_ in a week (i.e., putting networks together with only fundamental building blocks).

I trained a few of each type of network this week. The full, messy notebook is [here](http://nbviewer.jupyter.org/github/iconix/openai/blob/master/nbs/pytorch_starter_music_reviews.ipynb). _Note_: I've only trained on a sample dataset (~2K reviews) so far.

<table style='border: 1px solid black; table-layout: fixed; width: 100%;'>
    <tr>
        <th>Computational Graph</th>
        <th>Notes</th>
        <th>Sample Text (seed='the ')</th>
    </tr>
    <tr>
        <td style='border: 1px solid black'>
            <em>NGram</em>
            <img src='/img/posts/ngram_wk2.png' alt='NGram computational graph'>
        </td>
        <td style='border: 1px solid black'>
            Just one more thing before RNNs! This is similar to last week's model, but as a <em>feedforward</em> neural network (meaning, data flows in one direction and there are no loops).<br/><br/>
            Training time for 5 epochs: 1h 34m 27s (18m 53s/epoch)
        </td>
        <td style='border: 1px solid black; word-wrap: break-word'>
            the t e oo o e toettoooteooee o te o eet eet et    o ote oeeo teetoe t ete et eteoe eoe ooettet oe  eoeo
        </td>
    </tr>
    <tr>
        <td style='border: 1px solid black'>
            <em>MyRNN</em>
            <img src='/img/posts/rnn_wk2.png' alt='MyRNN computational graph'>
        </td>
        <td style='border: 1px solid black'>
            Adapted a recurrent <a href='https://pytorch.org/tutorials/intermediate/char_rnn_generation_tutorial.html'>architecture</a> (notice the loops!), without using the PyTorch RNN layer.<br/><br/>
            Training time for 5 epochs: 2h 1m 48s (24m 21s/epoch)
        </td>
        <td style='border: 1px solid black; word-wrap: break-word'>
            the 2cwap%
jaig aciph} araygay iblptoare josa7, pha]ptpjry iot, il) aydin t?e
iruphy bol war
        </td>
    </tr>
    <tr>
        <td style='border: 1px solid black'>
            <em>PyTorchRNN</em>
            <img src='/img/posts/pytorchrnn_wk2.png' alt='PyTorch RNN computational graph'>
        </td>
        <td style='border: 1px solid black'>
            Using the PyTorch <a href='https://pytorch.org/docs/stable/nn.html#torch.nn.RNN'>RNN</a> layer. This helped me figure out how to implement batching, which helped speed up training a lot!<br/><br/>
            Training time for 1000 epochs: (5.51s/epoch)
        </td>
        <td style='border: 1px solid black; word-wrap: break-word'>
            the || ouzze bdyckeckuckick nd rd st checnezvouvee le&quot;sod (sunoinondonst s g**gy'w dyeni da ts rdms
dic
        </td>
    </tr>
    <tr>
        <td style='border: 1px solid black'>
            <em>FastRNN</em><br /><br />
            (same computational graph as PyTorchRNN)
        </td>
        <td style='border: 1px solid black'>
            Using the same PyTorchRNN layer as above, but with the fastai library. fastai's <em>fit()</em> tracks loss, time, epoch loops, and its dataloader handles batching. Very convenient! It also trained PyTorchRNN faster and better (lower loss more quickly).<br/><br/>
            Training time for 8 epochs: 11s (1.47s/epoch)
        </td>
        <td style='border: 1px solid black; word-wrap: break-word'>
            the geren's beant, feell. out of yfuc wast and is soces**  unsic // shear's memoterayd?**

borustaria thistracome 'pre offacgino:*** **i| apol shopes ient shos alours songs dese --chate of diss, he gear the music /moding &quot; ____
        </td>
    </tr>
    <tr>
        <td style='border: 1px solid black'>
            <em>GRU</em><br /><br />
            (same computational graph as PyTorchRNN but with 'gru' for 'rnn')
        </td>
        <td style='border: 1px solid black'>
            An RNN variant that's meant to be more computationally efficient than an LSTM.<br /><br />
            Training time for 9 epochs: 12s (1.42s/epoch)
        </td>
        <td style='border: 1px solid black; word-wrap: break-word'>
            the and - sing all parts **her, ap solas edy opting anyth is collicofing and bar cono
albud:

it on thative have also, packer likes in face, leef well ever**
        </td>
    </tr>
    <tr>
        <td style='border: 1px solid black'>
            <em>LSTM</em><br /><br />
            (same computational graph as PyTorchRNN but with 'lstm' for 'rnn')
        </td>
        <td style='border: 1px solid black'>
            The main event! An RNN with memory that allows it to control what it remembers and forgets over long ranges.<br/><br/>
            Training time for 78 epochs: 2m 29s (1.92s/epoch)
        </td>
        <td style='border: 1px solid black; word-wrap: break-word'>
            the music your" is to
be're brand part,
kennehom over top with" places,
guite perfedday some sung due
(halbina" saintaway if you theinvipled fries.
        </td>
    </tr>
</table>
_Footnote on table visualizations._[^viz]

Going forward, there are so many things I could tweak - hyperparameters, architectures - but Natasha gave me good advice to focus this week on just getting to an LSTM that trains.

Is this an improvement on the text from last week? Not quite. I'm glad that next week will give me more time with LSTMs, now that I have a grasp of the fundamental building blocks.

For a great explainer on RNNs, LSTMs, and GRUs, check out Chris Colah's post on ["Understanding LSTM Networks"](http://colah.github.io/posts/2015-08-Understanding-LSTMs/).

### textgenrnn

For a fun break from my own garbled generations, I fed the same sample reviews into [textgenrnn](https://github.com/minimaxir/textgenrnn), a project that takes inspiration from both the original [char-rnn](https://github.com/karpathy/char-rnn) project and [DeepMoji](http://deepmoji.mit.edu), which I'm a fan of.

The project makes it really easy to try it out on Google Colaboratory, so I did! You can see the full, messy results [here](http://nbviewer.jupyter.org/github/iconix/openai/blob/master/nbs/Interactive_textgenrnn_Demo_w_GPU.ipynb).

I trained both a character-level and word-level LSTM. Here are two cherry-picked samples at 0.5 temperature[^temp].

<table>
    <tr>
        <th>char-level LSTM
        </th>
        <th>word-level LSTM
        </th>
    </tr>
    <tr>
        <td>have something that something up with a made through the time of the listener with the producers that
see more intern at San Mei and Jeremas are the country of funk
of the same charm of the most pop sound of the songwriting of
the mood. The song is a song about the way to recording his songs
        </td>
        <td>the song is a powerful , stirring and drums and emotive but with
rhythmic , and lighthearted chimes are a perfect backdrop for a more
atmosphere . the track is the perfect blend of the track is a
beautifully effervescent pop number with a cascade of psych - pop , the
track ' s vocals the twosome ' s mournful energetic yet smooth , and
the neon of the track pours over the course of
the beat . it ' s about coming out now , but also always a small
handful of 2017 and if you hear that of these tracks they have to
expect to work with a brand new project called _ * * sketches . " * *
        </td>
    </tr>
</table>
<br />

To be fair to the character-level sample, I only trained it for 5 epochs (compared to 10 epochs for word-level) because it takes longer.

They're both pretty pleasing (word-rnn more so)! This quick jump forward renews my belief that LSTMs are capable of generating expressive music reviews.

For more on the textgenrnn project, check out the blog post: ["How to Quickly Train a Text-Generating Neural Network for Free"](http://minimaxir.com/2018/05/text-neural-networks/)

## Part III. PyTorch: first impressions

1. The [official tutorials](https://pytorch.org/tutorials/) are quite good - and so are some [unofficial](https://github.com/spro/practical-pytorch) ones. They really helped me get off the ground with PyTorch this week.
2. PyTorch really does feel like Python! I like how closely tied to `numpy` it is. I also haven't been tripped up by the _philosophy_ of the library itself yet.
3. Via Google searches, [discuss.pytorch.org](https://discuss.pytorch.org/) has been very useful for debugging small issues so far. I'm glad that the community is so active.
4. I do wish that the [official docs](https://pytorch.org/docs/stable/index.html) weren't long pages with multiple topics on each page. Each page contains a module, and modules can have many functions. It makes Google searches for a particular function hard, and I frequently had multiple tabs with the same page open, just scrolled to different parts. I guess they expect us to use their internal doc search?

### fastai library

Did you notice that the last 3 RNNs in the table above (FastRNN; GRU; LSTM) trained epochs in ~1s, compared to the ~5s it took my train loop (with batching) for PyTorchRNN? That's an 80% improvement!

Alongside convenience functions, I have to thank the [fastai PyTorch library](https://github.com/fastai/fastai) for the impressive speed up!

I _could_ continue grinding out incremental progress on my naive RNN implementations from this week - but for better convenience and reliability, I plan to use the fastai library from now on. It's been [formally benchmarked](http://www.fast.ai/2018/04/30/dawnbench-fastai/) as fast (for computer vision tasks).

Here are some other perks:
- Lots of example code (after all, there's a whole course built around it!)
- Convenient functionality like dataloaders with built-in batching, model saving, and a `fit` function
- Jeremy claims it is easy to customize the library when needed... TBD on that


On the downside, it is hard to know if or how much the library is optimizing things under the hood without digging into the source code.

For example, I only happened to notice that the language model dataloader has implemented _randomized-length backpropagation through time_ (BPTT) - which, great for my model performance, but hard for learning about exactly what makes my model tick.

## Part IV. This week's struggles/learnings

### Tensor dimensions

I had trouble keeping track of the dimensions going in and coming out of my networks, and I don't have intuitive sense of when to reshape ([`view`](https://pytorch.org/docs/stable/tensors.html#torch.Tensor.view)) a tensor before further use (yet).

So often, I reshape tensors due to an explicit dim mismatch error - and when I finally get things running again, I don't know _why_ the reshape was necessary (if it runs, is it always valid input?).

I don't have a solution to this yet. I might try making expected dimensions more explicit in my code. For intuition-building, Natasha suggested that I try using the [Python Debugger](https://docs.python.org/3/library/pdb.html) (`import pdb; pdb.set_trace()`) to check the shape of tensors.

### Defining loss

There appears to be two equivalent ways of defining multi-class loss in PyTorch.
1. Make [`nn.LogSoftmax`](https://pytorch.org/docs/stable/nn.html#torch.nn.LogSoftmax) the final layer called in the `forward` pass. Then have an external `criterion` of [`nn.NLLLoss`](https://pytorch.org/docs/stable/nn.html#torch.nn.NLLLoss). [[example](https://pytorch.org/tutorials/intermediate/char_rnn_generation_tutorial.html)]
2. Skip defining a final activation layer in the `forward` pass. Then have an external `criterion` of [`nn.CrossEntropyLoss`](https://pytorch.org/docs/stable/nn.html#torch.nn.CrossEntropyLoss). [[example](https://pytorch.org/tutorials/beginner/blitz/cifar10_tutorial.html#define-a-loss-function-and-optimizer)]

This was confusing to me at first. The [`nn.CrossEntropyLoss`](https://pytorch.org/docs/stable/nn.html#torch.nn.CrossEntropyLoss) docs do mention that "This criterion combines `nn.LogSoftmax()` and `nn.NLLLoss()` in one single class."

### `tanh` vs `ReLu`?

I had a question early in the week about why I was seeing RNNs with `tanh` activation functions, when I had learned (from [fast.ai](/notes/2018/03/25/fast-ai-in-review) and [CS231n](http://cs231n.github.io/neural-networks-1/)) that ReLu is the go-to activation function for hidden-to-hidden layers.

It turns out that PyTorch does not support `ReLu` activations in its LSTM and GRU implementations! [[issue#1932](https://github.com/pytorch/pytorch/issues/1932)] `ReLu` is an option for vanilla RNNs, but `tanh` is still the default. This was surprising to me - it's probably a side effect of how quickly best practices change in the field.

## Program Updates

### Syllabus edits

Here's a changelog for what I updated in my syllabus this week (see [full commit](https://github.com/iconix/openai/commit/1e1252beda1890d8468268306313f5f22567dec3) if super interested):

1. Updated my resources list for this week (2) based on what I actually ended up using
2. Combined weeks 4-5 (seq2seq + seq2seq with VAE) into one week (4) on seq2seq models
3. Move week 6 up to week 5 and rename to "Classification with Attention" (formerly, "Model interpretability, part 1")
4. Split week 7 into weeks 6-7 on "Model interpretability" - one to survey explicit methods for interpretation, the other to study bias in my own models

### Scholar blogs

I'd like to share and promote the blogs of the other amazing OpenAI Scholars! They can be found below:

- Holly Grimm [https://hollygrimm.com/](https://hollygrimm.com/)
- Christine McLeavey Payne [http://christinemcleavey.com/](http://christinemcleavey.com/)
- Munashe Shumba [http://everyd-ai.com/](http://everyd-ai.com/)
- Dolapo Martins [https://codedolapo.wordpress.com/](https://codedolapo.wordpress.com/)
- Ifu Aniemeka [https://www.lifeasalgorithm.com/](https://www.lifeasalgorithm.com/)
- Hannah Davis [http://www.hannahishere.com/](http://www.hannahishere.com/)
- Sophia Arakelyan [https://medium.com/@sophiaarakelyan](https://medium.com/@sophiaarakelyan)

## Bonus: Here's something useful

I'd encourage anyone interested in Machine Learning and Artificial Intelligence to **subscribe to email newsletters**!

Just this week, I found [three](https://arxiv.org/abs/1806.01973) [interesting](https://blog.openai.com/language-unsupervised/) [pieces](https://medium.com/dailyjs/the-trouble-with-d3-4a84f7de011f)[^scholar-mentors]. Newsletters are an easy way to keep current on noteworthy happenings in the community - and you don't have to go hunting for content. Even if you don't have time every week to read them, your inbox becomes an excellent search engine :slightly_smiling_face:

Here are the ones I am subscribed to:
- [Data Science Weekly](https://www.datascienceweekly.org/) (recommended by a [mentor](/blogging/2017/05/07/hello-world#building-a-portfolio))
- [The Wild Week in AI](https://www.getrevue.co/profile/wildml) (hasn't updated in some months though)
- [NLP News](http://newsletter.ruder.io/) by Sebastian Ruder
- [Import AI](https://jack-clark.net/) (tricky to find the subscribe [button](http://twitter.us13.list-manage.com/subscribe?u=67bd06787e84d73db24fb0aa5&id=6c9d98ff2c))

I'd be curious to hear about other good ones!

#### Footnotes

[^temp]: Temperature is meant to represent the 'creativity' of the text. It controls how suboptimal sampling for the next char or word is allowed to be. The lower the temperature, the more confident the predictions - but also the more conservative. 0.5 is middle of the road.
[^viz]: Wow, look at those computational graphs! How did I draw them?! With MS Paint + a good template from a [tutorial](https://pytorch.org/tutorials/intermediate/char_rnn_generation_tutorial.html). If I have time, I'd like to look into viz libraries for printing the PyTorch autograd graph directly (since there's no official Tensorboard equivalent).
[^scholar-mentors]: The OpenAI paper is actually co-authored by Scholar mentors Alec Radford and Karthik Narasimhan!
