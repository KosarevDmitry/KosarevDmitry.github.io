---
title: About sources
date: 2025-03-19 19:41:25 +0100
categories: [aspnet]
tags: [indexer]
---

I got the impression that the average programmer, and maybe any programmer, frankly, is in a pretty stupid state when he turns to the Internet. Always with an outstretched hand. Meanwhile, essentially, all he needs are the basic repositories he works with. But we surf the Internet. I did it all the time, non-stop. and I was in constant anxiety whether I would be able to find the right pattern. Or, on the contrary, I was excited because I found it. Then I used the dtsearch indexer for a very long time and I still use it, but very rarely. Then I made snippets. I did it almost automatically - if I came across an interesting example, I saved it, thinking that it would be useful later. But this is not a systematic approach.

If you take the source code as a whole, it is better to look at it by sections, by libraries. And tests for them, although they can be quite specific. For "deep drilling"
And sometimes, on the contrary, only with their help can you clearly and convincingly understand the meaning of a method or object.
But if we talk about patterns and snippets, then this is not what is needed.
But examples from these libraries are needed. And they are there, for example, in aspnetcore.
And there are also general educational illustrative ones and as part of the general system of support and popularization of Microsoft.
- <https://github.com/dotnet/AspNetCore.Docs> 
- <https://github.com/dotnet/AspNetCore.Docs.Samples> 
- <https://github.com/dotnet/samples> 
- <https://github.com/dotnet/aspnetcore> 
- etc

If you select only the directories that contain examples in these repositories, you'll get about 1,500 `*. csproj`.
And then combine all the `*.cs` files, remove the `///` comments, why the hell do you need them, and add your own single line comment with the file path, you'll get the final file, all in one bottle, only about 20 MB in size. Just imagine, only 20 MB!

That is, what my computer can handle more or less successfully and can show in `notepad++` with highlighting. Just leave the `.cs` extension or with `.cs_` may be such way 
![assets/notepad_ext.jpg](/assets/notepad_ext.jpg)  

No need for any search engines. When everything is at hand in one file, it's nice, you must admit.
If you really want to, you can make notes in the margins there, but it's easier than copy-pasting snippets from there.
True, you still need the code from https://github.com/dotnet/dotnet-api-docs.git - it's 16 MB. I look at 2 files. Because 36 MB in one file is too much for my machine.

Perhaps you will say that, generally speaking, the examples may be weak, imperfect, for beginners.
There is such a moment. I agree.
But in `dotnet/aspnetcore` the examples are professional, because they were written by the developers of this software, and not consultants.

This is not a panacea, it is not even discussed, such an approach does not exempt from a systemic review of projects or target repositories. But it is easier than opening each project separately in the IDE or viewing the source code page by page. Only a text editor with highlighting is enough. In principle, for searching in `notepad++`, everything I need exists: `regex`, selections `Find all in current document`.  
The same way you can merge files of large repositories. For example, the total size of aspnetcore `.cs` files is about 55 Mb.

To write script or cli for merging files you can using any language.
My result looks like this 
![assets/content.jpg](/assets/content.jpg)    

In any case, it is better to look at "your tested" code,  which you know where it came from, and then request your issue on the Internet or big brother Artifical Intelligence, whose  "spectre is haunting Europe".