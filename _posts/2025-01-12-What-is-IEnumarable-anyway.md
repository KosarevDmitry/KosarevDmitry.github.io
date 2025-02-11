---
title: What is IEnumarable anyway
date: 2025-01-12 10:55:10 +0100
categories: [dotnet]
tags: [feature]
---

What is IEnumarable anyway.

How many years have passed and I still   read into `yield return`, "Mene tekel Peres" of sorts  and didn't understand a thing really.
Then I found it again  in one of Toub's articles I  read it waslike state mashine in an old article when trees were still big and open source no way.


How many years have passed, and I still read into these `yield return`, "Mene tekel Peres" of sorts, and didn't understand a thing.
Then I found it again, in one of Toub's articles I read that it was a `state machine`, in an old article, when the trees were still big and open source - no way.
And I was already in my  "dug deeper" period.
And then for some reason I opened `DotNetPeek`. Wow, so that's what a reindeer he is! Why did you fool me. It is easy.
If you replace the unusual (with tags) variable names with familiar ones, you will get working code. And no need to explain anything. Thanks everyone, you are all free to go.

<https://github.com/KosarevDmitry/patterns-example/blob/029206e68cffadfa16977ea79f81c63be794e300/src/Other/IEnumerableTest.cs#L69>

And the same approach - seeing the decompiled code - works with different functions, such as

`Props {get;set;}`  
`async/await`  
`out`  
`record`  

Better yet, look at the IL code in `Rider`. And make it a rule to always do this with a new C# innovations.
Very clear and convincing.


![Il code](/assets/ILcode_panel.jpg)