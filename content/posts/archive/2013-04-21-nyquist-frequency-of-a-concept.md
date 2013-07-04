---
title: Nyquist frequency of a concept?
created_at: Sun, 21 Apr 2013 19:23:26 +0000
kind: article
published: true
tags:
- concept
- Nyquist
- sampling
- vtclis13
---

> We get stories much faster than we can make sense of them, informed
> by cellphone pictures and eyewitnesses found on social networks and
> dubious official sources like police scanner streams. Real life
> moves much slower than these technologies. There’s a gap between
> facts and comprehension, between finding some pictures online and
> making sense of how they fit into a story. What ends up filling that
> gap is speculation. <cite>Farhad Manjoo, [Breaking News Is Broken](http://www.slate.com/articles/technology/technology/2013/04/boston_bombing_breaking_news_don_t_watch_cable_shut_off_twitter_you_d_be.html)</cite>

This past week in ECE3704 (Continuous and Discrete Systems) we have
been exploring what happens to the information in a continuous-time
signal when it is sampled and again what happens when discrete samples
are reconstructed into a continuous time signal. Here is an example:

![signal](/assets/posts/signal.png)

The solid blue line is the continuous time signal $$(x(t)=e^{-t})$$ and the black dots are samples of the signal taken at intervals of 0.5 seconds (the sampling period). This process of sampling a signal is a necessity of living in a (mostly) continuous-time world when processing data using a (theoretically) discrete-time device such as a digital computer. Once we have our information nicely digitized we can poke, prod and manipulate it using the wealth of digital tools at our disposal before converting it back to a continuous-time representation that we then observe, commonly in the form of visual or audible signals. The question arises: what does the act of sampling and reconstruction have on the final output that we see and hear? How faithful is the input/output relationship of our original and constructed signal using our digital technology to the ideal relationship. An illustrative example would be the combination of wireless and wired networks that make up the communication channel used to transmit the data associated with a cell phone call. Ideally, the receiver would hear an exact transcript of the audible information as produced by the caller, or at least as exact as it would have been if the two were face to face. In reality the best we can usually hope for is an approximate reconstruction that is "good enough". Here is the reconstruction of our previously sampled signal, overlaid on the original for comparison.

![signal reconstruction](/assets/posts/signal_con.png)

 Clearly the reconstructed signal is not a faithful duplicate of the original, but why is this the case, and what could we do to make it better? We gain some insight by taking a [Fourier transform](http://en.wikipedia.org/wiki/Fourier_transform) of the sampled signal to generate a frequency spectrum which we can then compare with the frequency spectrum of the original.

![magnitude of X](/assets/posts/magX.png)

 The ability to view the signal from this vantage point makes some features of the sampling process easy to see that otherwise would not be obvious looking at the time-domain representation, namely, we note that the frequency spectrum of the continuous time signal can potentially live on the entire infinite frequency axis,

![magnitude of sampled signal](/assets/posts/magXstar.png)

 while the sampled signal is restricted to a finite frequency interval, the interval between plus and minus and half the sampling frequency, between the dashed red lines (it turns out that the frequency spectrum of all real-valued signals has a [negative component](http://en.wikipedia.org/wiki/Negative_frequency) that mirrors the positive spectrum. Who knew?).

 The dashed red lines are drawn at plus and minus 2*pi radians/sec, the information starts repeating after this, shown by the green curve. Note that 2*pi rad/sec is one half the sampling frequency of 4*pi rad/sec. Viewing the information in this form allows us to intuit why we might not be able to uniquely reconstruct all sampled signals perfectly: The act of sampling is restricting the domain on which we can encode information to a finite interval, so we can conclude that sampled versions of continuous-time signals that make use of the entire infinite frequency axis will never contain all the information of the original signal, and for those signals that are naturally [bandlimited](https://en.wikipedia.org/wiki/Bandlimiting) we will need to choose our sampling frequency in such a way that finite frequency interval of the discrete-time signal is large enough to contain all the information in the original. This leads to the [Nyquist sampling theorem](https://en.wikipedia.org/wiki/Nyquist_sampling) which states that if the sampling frequency is greater than twice the bandlimit of the original signal then the signal can be uniquely reconstructed from its samples.

 In [a recent post](https://blogs.lt.vt.edu/oddwallaby/2013/04/17/medium/), [Adam](https://blogs.lt.vt.edu/oddwallaby/author/aburke3/) commented that we (humans, though this most likely applies to any non-humans able to read and comprehend this just as well) engage in a sampling and reconstruction process every time we communicate a thought. Concepts and ideas live in the continuous domain (at least, so it seams, not being an expert in neuroscience perhaps one could make a sound argument that thoughts are in fact discrete, but for today's purposes I think it would not be egregiously inaccurate to compare them to continuous-time signals), and yet there are only so many words we have available to us when communicating those thoughts. What's more, we can't be sure that another sentient being will hear the words we are using and reconstruct our original thought perfectly. In fact, it's likely that this imperfect reconstruction of communicated thought results in a great deal of innovation and creativity and "thinking outside the box", so it's certainly not always a bad thing, just a thing. But it's a thing we don't really have any tools to quantitatively analyze. How much off the original information was lost or distorted by the conversion into language or another medium? How far from the original thought is the reconstructed thought (assuming we can even define a [metric space](http://en.wikipedia.org/wiki/Metric_space#Definition) for concepts).

 It would seem that some thoughts, like signals, have bandlimited information content, while others may not. The feeling expressed by the phrase "I am thirsty" is fairly well understood (even if we don't really understand what the essence of "I" is). There are some variations: "I am very thirsty", "I am parched", etc. but I'm going to go out on a limb and say that that particular thought can be accurately communicated in a finite number of words (generally about 3). I'm not sure I could make that claim about some others, like the concept of "I". Are there more parallels between sampling theory and communication through a medium? It would seem that like signals, some ideas can be sampled and reconstructed accurately, while others can not. Are there any tools available that parallel [Fourier analysis](https://en.wikipedia.org/wiki/Fourier_analysis) for signals that could yield a different view of the information contained in a raw idea or concept? Does it even make sense to talk about such a tool?

