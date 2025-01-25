---
title: Async-Await
date: 2024-08-22 16:20:32 +0200
categories: [C#]
tags: [multithreading, task]
---

To understand `await/async` try debug the following code. 

You will see that `await`  automatically call the `GetAwaiter()` of class implementing INotifyCompletion.
And then CLR automatically calls `IsCompleted()`, then if it returns `true`, `GetResult()` is called, if `false`, `OnCompleted()` and `GetResult()` subsequently are called.  
  
`Debugger.Break()` I added it on purpose, if you don't put the breakpoints there, the debugger won't go there.  

- My test: <https://github.com/KosarevDmitry/patterns-example/blob/main/src/Other/Async_Await_Pattern.cs>
- Roslyn repo tests: <https://github.com/dotnet/roslyn/blob/main/src/Compilers/CSharp/Test/Semantic/Semantics/BindingAwaitTests.cs>

