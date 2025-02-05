---
title: Turn a warning into an error
date: 2024-07-29 07:46:13 +0200
categories: [dotnet]
tags: [syntax]
---
That way you will receive a more strict warning that will look like an error. 

`<MSBuildTreatWarningsAsErrors>True</MSBuildTreatWarningsAsErrors>`

JetBrain Rider displays `Succeeded: False`, however the compilation will be successful.

```console
0>Program.cs(5,29): Error CS8625 : Cannot convert null literal to non-nullable reference type.
temp -> D:\Dmitry\EDX\_Test\temp\temp\bin\Debug\net8.0\temp.dll
0>------- Finished building project: temp. Succeeded: False. Errors: 1. Warnings: 0
Build completed in 00:00:01.378
```
