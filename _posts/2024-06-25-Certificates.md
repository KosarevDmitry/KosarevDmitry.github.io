---
title: Certificates
date: 2024-06-25 00:03:37 +0200
categories: [aspnetcore]
tags: [security]
---

- There only two exports type: pfx and pem  
: <https://github.com/dotnet/aspnetcore/blob/a450cb69b5e4549f5515cdb057a68771f56cefd7/src/Shared/CertificateGeneration/CertificateExportFormat.cs#L6>


- X509Certificate2
: A convenient point of consideration might be <https://github.com/dotnet/aspnetcore/blob/0acb0e4c76a6db50baba3546343b0d27848b81f7/src/Tools/dotnet-dev-certs/src/Program.cs>

- The main work is done by Crypt32.dll, which opens the storage
: <https://github.com/dotnet/runtime/blob/2327a36c5222a8e4e522ab27455bcbd8002efd06/src/libraries/System.Security.Cryptography/src/System/Security/Cryptography/X509Certificates/WindowsInterop.crypt32.cs#L48>


- **How build a project with strong name**

	- generate key `mykey.snk`
	- add it to `csproj`

		```
		 <AssemblyOriginatorKeyFile>../mykey.snk</AssemblyOriginatorKeyFile>
			<SignAssembly>True</SignAssembly>
		```

	- display public key

		cd  in `bin` subfolder where the assembly is located  
		`sn -Tp tests.dll`





