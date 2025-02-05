---
title: Is there a necessity to know what's going on under the hood?
date: 2024-08-31 13:24:37 +0200
categories: ["common sense"]
tags: [learning]
---

Microsoft opinion in 2012 г.  
WARNING: This post goes deep into an advanced area of .NET that most developers never need to think about.  

This is the opinion of a great developer, Microsoft employee, lead developer of `Tasks library`.

- 2012

	ExecutionContext is one of those things that the vast majority of developers **never need to think about**. It’s kind of like air:
	it’s important that it’s there, but except at some crucial times (e.g. when something goes wrong with it), we don’t think about
	it being there. ExecutionContext is actually just a container for other contexts. Some of these other contexts are ancillary,
	while some are vital to the execution model of .NET, but they all follow the same philosophy I described for
	ExecutionContext:** if you have to know they’re there, either you’re doing something super advanced, or something’s gone wrong**.

- 2023

	While it’s common to use this support without knowing exactly what’s happening under the hood, 
	I’m a firm believer that understanding how something actually works helps you to make even better use of it. 


 
I suppose he knew it before, but Microsoft had the opportunity to sell closed source code. 

No books, blogs, eloquent explanations, pictures, Stanford courses can replace the code itself, you will only waste time. 
The feeling that I don’t know a damn thing remains. And there is no “clean code”.
This will always continue, everything will need to be done quickly and all the sites in the world will tell how easy it is.

Download the source code, find this word that is not clear, find tests.
I can’t do it any other way.


