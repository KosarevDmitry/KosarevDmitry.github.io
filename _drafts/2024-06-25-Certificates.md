---
title: Certificates
date: 2024-06-25 00:03:37 +0200
categories: [aspnetcore]
tags: []
---

## There only two exports type: pfx and pem  
[ref] (https://github.com/dotnet/aspnetcore/blob/a450cb69b5e4549f5515cdb057a68771f56cefd7/src/Shared/CertificateGeneration/CertificateExportFormat.cs#L6)


## X509Certificate2 
A convenient point of consideration might be [ref](
https://github.com/dotnet/aspnetcore/blob/0acb0e4c76a6db50baba3546343b0d27848b81f7/src/Tools/dotnet-dev-certs/src/Program.cs)

## rests on the Crypt32.dll library which opens the storage

https://github.com/dotnet/runtime/blob/2327a36c5222a8e4e522ab27455bcbd8002efd06/src/libraries/System.Security.Cryptography/src/System/Security/Cryptography/X509Certificates/WindowsInterop.crypt32.cs#L48


## How build a project with strong name


- generate key `snk`

`sn -k Drive.Kosarev.Tests.snk`

- add it to `csproj`

it is not nesserary to add key if key already exists in the repo root. and there is reference in prop. There need only to add SignAssembly. 

	```
	<SignAssembly>True</SignAssembly>
	 <AssemblyOriginatorKeyFile>Drive.Kosarev.Tests.snk</AssemblyOriginatorKeyFile>
	```

- extract public key 
`sn -p Drive.Kosarev.Tests.snk test.pubkey`
- display  key
`sn -tp test.pubkey`
- or cd  in `bin` subfolder where the assembly is located  
`sn -Tp tests.dll`


- to add a access for internal class insert into  `csproj` 

	```
	<ItemGroup>
	 <AssemblyAttribute Include="System.Runtime.CompilerServices.InternalsVisibleTo">
	   <_Parameter1>tests, PublicKey=eb832f31d8254168cd7ba5700dfbca301fbf8db614ba41ba18474de0a5f4c2d51c995bc3636c641c8cbe76f45717bfcb943b5</_Parameter1>
	  </AssemblyAttribute>
	</ItemGroup>
	````