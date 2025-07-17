---
title: The binding types in csproj
date: 2025-07-17 22:22:49 +0200
categories: [C#]
tags: []
---

What types of binding are possible in `csproj`

1.  project   `dotnet add reference`

2.  package 
`dotnet  add package`

3. dll

	```xml
	<ItemGroup>
		<Reference Include="Microsoft.DotNet.RemoteExecutor">
		  <HintPath>..\Microsoft.DotNet.RemoteExecutor\src\bin\Release\net9.0\publish\Microsoft.DotNet.RemoteExecutor.dll</HintPath>
		</Reference>
	  </ItemGroup>
	```

4. files

	```xml
	 <Compile Include="$(CommonTestPath)System\Diagnostics\Tracing\TestEventListener.cs" Link="Common\System\Diagnostics\Tracing\TestEventListener.cs" />
	```

