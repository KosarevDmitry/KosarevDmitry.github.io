---
title: DotNetPeek
date: 2025-02-01 20:06:46 +0100
categories: [dotnet]
tags: [tool]
---

Specificity of DotNetPeek


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