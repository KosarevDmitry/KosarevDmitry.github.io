---
title: Add project to aspnetcore
date: 2024-06-25 11:28:28 +0200
categories: [C#]
tags: []
---
  
# If you need to add unittest to a project such as `aspnetcore` and access the internal class  

There is no tests for `\Tools\dotnet-dev-certs` in aspnetcore,
so I decided to add it solely for myself.   

All projects in the assembly are signed, so a `public key` is needed to allow access

(dotnet-dev-certs/src/Properties/InternalsVisibleTo.cs)   
```
using System.Runtime.CompilerServices;
[assembly: InternalsVisibleTo("dotnet-dev-certs.Tests , PublicKey= ...")]
```

All projects are automatically compiled to `.\aspnetcore\artifacts`   

Get the key  
```
cd .\aspnetcore\artifacts\obj\dotnet-dev-certs.Tests\Debug\net8.0
sn -v dotnet-dev-certs.Tests.dll
```