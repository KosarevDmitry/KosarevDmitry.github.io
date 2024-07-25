---
title: Certificates
date: 2024-06-25 00:03:37 +0200
categories: [aspnetcore]
tags: []
---

There only two exports type: pfx and pem  
[ref] (https://github.com/dotnet/aspnetcore/blob/a450cb69b5e4549f5515cdb057a68771f56cefd7/src/Shared/CertificateGeneration/CertificateExportFormat.cs#L6)


X509Certificate2 
Удобной точкой рассмотрения можеть служить [ref](
https://github.com/dotnet/aspnetcore/blob/0acb0e4c76a6db50baba3546343b0d27848b81f7/src/Tools/dotnet-dev-certs/src/Program.cs)

упирается в библиотеку Crypt32.dll которая открывает хранилище
https://github.com/dotnet/runtime/blob/2327a36c5222a8e4e522ab27455bcbd8002efd06/src/libraries/System.Security.Cryptography/src/System/Security/Cryptography/X509Certificates/WindowsInterop.crypt32.cs#L48