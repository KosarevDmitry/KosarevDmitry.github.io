---
title: Runtime debugging
date: 2025-02-25 15:55:51 +0100
categories: [dotnet]
tags: [runtime]
---


runtime now represent themself 3 repo indeed - corefx, coreclr and runtime 
For my purpose it doesn't matter  version I attempted to compile archived version first.
I have got some error, so I decided to do it on my 8 version's repo. 

https://github.com/dotnet/diagnostics


Both repos now is part of runtime repo
https://github.com/dotnet/corefx
https://github.com/dotnet/coreclr/

The smaller but at the same time integral module for studying the better
For my aim of learnig TPL Task class it is not important that the version od coreclr already is already legacy. 

important part of diagnostics . You should be carefull sorting out the repo
https://github.com/dotnet/diagnostics


#@ Coreclr 

This manual is about C++ coreclr debugging
https://github.com/dotnet/runtime/blob/main/docs/workflow/debugging/coreclr/debugging-runtime.md

```
cd D:\src\runtime-v8.0.110
.\build.cmd  :: to download .dotnet create ./artifacts and comile ->  check powershell project that provide only scripts that participated in  execution
```

```
.\build.cmd clr.nativeprereqs
```

output 
```cmd
  Determining projects to restore...
  Tool 'coverlet.console' (version '6.0.0') was restored. Available commands: coverlet
  Tool 'dotnet-reportgenerator-globaltool' (version '5.0.2') was restored. Available commands: reportgenerator
  Tool 'microsoft.dotnet.xharness.cli' (version '8.0.0-prerelease.25064.4') was restored. Available commands: xharness
  Tool 'microsoft.visualstudio.slngen.tool' (version '10.0.0') was restored. Available commands: slngen
  Tool 'dotnet-format' (version '6.0.240501') was restored. Available commands: dotnet-format
```


`.\build.cmd -vs coreclr.sln :: open devenv.exe `

> notice that $(SolutionDir)  is D:\src\runtime-v8.0.110\artifacts\obj\coreclr\windows.x64.Debug\ide

Properties
command
$(SolutionDir)\..\..\..\..\bin\coreclr\windows.$(Platform).$(Configuration)\corerun.exe
"D:\src\runtime-v8.0.110\artifacts\bin\coreclr\windows.x64.Debug\corerun.exe"

`.\build.cmd -vs coreclr.sln`
choose `INSTALL` project in solution treeview

working dir 
$(SolutionDir)\..\..\..\..\bin\coreclr\windows.$(Platform).$(Configuration)
D:\src\runtime-v8.0.110\artifacts\bin\coreclr\windows.x64.Debug

command argument
factually absolute path 
D:\src\runtime-v8.0.110\artifacts\bin\Foo\Debug\net8.0\Foo.dll  
I added
$(SolutionDir)\..\..\..\..\bin\Foo\Debug\net8.0\Foo.dll

// Foo.dll was compiled previously by `build.cmd -restore -build -projects "D:\src\runtime-v8.0.110\src\libraries\Foo\Foo.csproj"`

Enviroment
 offer to do
CORE_LIBRARIES=$(SolutionDir)\..\..\..\..\bin\runtime\<target-framework>-windows-$(Configuration)-$(Platform)
factually absolute path 
D:\src\runtime-v8.0.110\artifacts\bin\runtime\net8.0-windows-Debug-x64
I added
$(SolutionDir)\..\..\..\..\bin\runtime\net8.0-windows-Debug-x64

I added brakepoint in clrrun.cpp main  clicked F11 
:+1: and debugging is work, that's great.


## CoreFx
downloading  archive 
https://github.com/dotnet/corefx/releases/tag/release%2F3.1
and have been tring to ./build.cmd
I have got error  - build-native.proj require Visual Studio 2017 or 2019. 
So I decide not to download v19 awhile.   https://archive.org/details/vs_Community
the manual for archive version
https://github.com/dotnet/corefx/blob/master/Documentation/project-docs/developer-guide.md#testing-with-private-coreclr-bits


for v9.0.100
Debugging corefx  described in following doc
D:\src\runtime-test_v9.0.100\docs\workflow\debugging\libraries\windows-instructions.md 

it requires to install SDK and WDK, all this things were installed in `C:\Program Files (x86)\Windows Kits\10`
 https://learn.microsoft.com/en-us/windows-hardware/drivers/download-the-wdk
install `winget install Microsoft.WinDbg`
  <https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/>
 

