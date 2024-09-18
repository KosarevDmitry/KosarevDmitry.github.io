---
title: Certificates
date: 2024-06-25 00:03:37 +0200
categories: [aspnetcore]
tags: [security]
---

## There only two exports type: pfx and pem  
<https://github.com/dotnet/aspnetcore/blob/a450cb69b5e4549f5515cdb057a68771f56cefd7/src/Shared/CertificateGeneration/CertificateExportFormat.cs#L6>


## X509Certificate2 
A convenient point of consideration might be <https://github.com/dotnet/aspnetcore/blob/0acb0e4c76a6db50baba3546343b0d27848b81f7/src/Tools/dotnet-dev-certs/src/Program.cs>

## Rests on the Crypt32.dll library which opens the storage
<https://github.com/dotnet/runtime/blob/2327a36c5222a8e4e522ab27455bcbd8002efd06/src/libraries/System.Security.Cryptography/src/System/Security/Cryptography/X509Certificates/WindowsInterop.crypt32.cs#L48>


## How build a project with strong name

- generate key `mykey.snk`

- add it to `csproj`

	```
	 <AssemblyOriginatorKeyFile>../mykey.snk</AssemblyOriginatorKeyFile>
		<SignAssembly>True</SignAssembly>
	```

- display public key

	cd  in `bin` subfolder where the assembly is located  
	`sn -Tp tests.dll`


## How to add a access for internal class
 
 > There are different approach 

1.A project file `csproj` 

		```
		<ItemGroup>
		 <AssemblyAttribute Include="System.Runtime.CompilerServices.InternalsVisibleTo">
		   <_Parameter1>tests, PublicKey=eb832f31d8254168cd7ba5700dfbca301fbf8db614ba41ba18474de0a5f4c2d51c995bc3636c641c8cbe76f45717bfcb943b5</_Parameter1>
		  </AssemblyAttribute>
		</ItemGroup>
		````
		
	or   	
    
	<https://learn.microsoft.com/en-us/visualstudio/msbuild/common-msbuild-project-items?view=vs-2022#internalsvisibleto>  
	
	```
	  <ItemGroup>
		<InternalsVisibleTo Include="StackExchange.Redis.Server" />
		<InternalsVisibleTo Include="StackExchange.Redis.Tests" />
		<InternalsVisibleTo Include="MediatR.MyTests"  PublicKey="0024000..." />
	  </ItemGroup>
	```
	


2. Using  file Properties/InternalsVisibleTo.cs  
	
	> `runtime` repo  contains at least  26 similar files  as "...runtime\src\libraries\System.Runtime.Numerics\src\Properties\InternalsVisibleTo.cs"
		
		
	```
	 using System.Runtime.CompilerServices;
	 [assembly: InternalsVisibleTo("bar.tests"), InternalsVisibleTo("bar.tests1")] // access for bar.tests1.dll
	```

3. Assembly.info 

> Example from `OpenTelemetry` repo  

```
// Copyright The OpenTelemetry Authors
// SPDX-License-Identifier: Apache-2.0

using System.Runtime.CompilerServices;

[assembly: InternalsVisibleTo("OpenTelemetry" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Api.ProviderBuilderExtensions" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Api.ProviderBuilderExtensions.Tests" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Api.Tests" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Exporter.Console" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Exporter.InMemory" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Exporter.OpenTelemetryProtocol" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Exporter.OpenTelemetryProtocol.Tests" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Extensions.Hosting" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Extensions.Hosting.Tests" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Shims.OpenTracing.Tests" + AssemblyInfo.PublicKey)]
[assembly: InternalsVisibleTo("OpenTelemetry.Tests" + AssemblyInfo.PublicKey)]

#if SIGNED
file static class AssemblyInfo
{
    public const string PublicKey = ", PublicKey=002400000480000094000000060200000024000052534131000400000100010051C1562A090FB0C9F391012A32198B5E5D9A60E9B80FA2D7B434C9E5CCB7259BD606E66F9660676AFC6692B8CDC6793D190904551D2103B7B22FA636DCBB8208839785BA402EA08FC00C8F1500CCEF28BBF599AA64FFB1E1D5DC1BF3420A3777BADFE697856E9D52070A50C3EA5821C80BEF17CA3ACFFA28F89DD413F096F898";
}
#else
file static class AssemblyInfo
{
    public const string PublicKey = "";
}
#endif
```