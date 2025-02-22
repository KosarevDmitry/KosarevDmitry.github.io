---
title: Specificity of DotNetPeek
date: 2025-02-01 20:06:46 +0100
categories: [dotnet]
tags: [tools]
---

There are several states of code:
- C# code
- compiled code, optimized one or not. If decompile compiled code, it will be different from source code.
- IL code 
- binary 

DotNetPeek provides

- decompiled code.  There is sense to look at decompiled code otherwise, you have not got a clue how 	it looks like  `IEnumerable`, `record`,  and other features of C#.   
- IL code.  You will be able at least to see that the boxing operation represented by  ILCode commands -  `box` and `box.any`.
- decompiled pdb file

IL code has  popup tips  with  descriptions similar to the one presented on this page
<https://en.wikipedia.org/wiki/List_of_CIL_instruction>


If you have access to the source code and use `JetBrain IDE`, it is very convenient to view the decompiled code and IL directly in the `IDE`.
Searching for the current code fragment in a dll file, for example, located in the output directory `aspnetcore\artifacts\bin\Microsoft.AspNetCore.Mvc\Debug\net8.0` dll, is not so easy.

The panel with IL code in the `Rider`

![The panel with IL code in `Rider](/assets/DotNetPeek.jpg) 
