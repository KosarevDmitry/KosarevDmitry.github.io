---
title: How to add project in aspnetcore repo?
date: 2025-02-10 19:38:50 +0100
categories: [aspnetcore]
tags: [aspnetcore]
---

I tried to add  my project as described in `\aspnetcore\docs\ReferenceResolution.md`
but some of the explanations were not obvious to me, so I made a small guide.

1. Add project  (it is obvious) in dir  `\src\MyProject`. Add a inner dir `src` as is customary here  so eventually path to project  will be `\src\MyProject\sec`.

2. Add  in `\eng\Build.props`
	```xml
	  <DotNetProjects Include="
							  $(RepoRoot)src\MyProject\**\src\*.csproj;
						   ...
							  "
							Exclude="
							  ..."
							Condition=" '$(BuildMainlyReferenceProviders)' == 'true' " />
	```
	
3. Run `\eng\scripts\GenerateProjectList.ps1`
4. Add  in `eng\Dependencies.props`  
	
	```xml
	<ItemGroup Label=".NET team dependencies (Non-source-build)" Condition="'$(DotNetBuildFromSource)' != 'true'">
    ...
		<LatestPackageReference Include="MyProject" />
	</ItemGroup>
	```
	
5. Run `\restore.cmd`

6. `dotnet sln AspNetCore.sln add .\src\MyProject\src`
7. Now you can add links to any `csproj`
 `<Reference Include="MyProject" /> `
8. Add scripts to `\src\MyProject\` to work with project 

	- build.cmd
		```
		@ECHO OFF
		SET RepoRoot=%~dp0..\..

		%RepoRoot%\eng\build.cmd -projects %~dp0**\*.*proj %*
	```

	- MyProject.slnf 
		```
		{
		  "solution": {
			"path": "..\\..\\AspNetCore.sln",
			"projects": [
			  "src\\MyProject\\src\\MyProject.csproj"
			]
		  }
		}
		```

	- startvs.cmd

		```
		@ECHO OFF

		%~dp0..\..\startvs.cmd %~dp0MyProject.slnf
		```


