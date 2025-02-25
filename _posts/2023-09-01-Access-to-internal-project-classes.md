---
title: Access to internal project classes
date: 2023-09-01 09:55:20 +0200
categories: [dotnet]
tags: [infrastructure]
---

There are several approaches to providing access to another project's internal classes.

1. Add any class (usually `/root/Properties/InternalsVisibleTo.cs`) with following content 
    > `runtime` repo  contains at least  26 similar files  as 
	"...runtime\src\libraries\System.Runtime.Numerics\src\Properties\InternalsVisibleTo.cs"
	
	```csharp
	 using System.Runtime.CompilerServices;
	 [assembly: InternalsVisibleTo("bar.tests"), InternalsVisibleTo("bar.tests1")] 
	```

2. Adding to Assembly.info  

	```csharp
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

1. Adding items to msbuild csproj  

	```csharp
	  <ItemGroup>
		<InternalsVisibleTo Include="StackExchange.Redis.Server" />
		<InternalsVisibleTo Include="StackExchange.Redis.Tests" />
	  </ItemGroup>
	```