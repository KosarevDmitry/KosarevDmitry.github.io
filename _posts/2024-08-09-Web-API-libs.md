---
title: Web API libs
date: 2024-08-09 17:42:40 +0200
categories: [dotnet]
tags: [rest]
---


1.  If we have only several endpoints for requests - use `httpclient`, define address, base address, path, query, get a response and deserialize it into model.
Pattern <https://github.com/dotnet/docs/tree/main/docs/core/extensions/snippets/http>

2. If it needs to create API from a controller. Use <https://github.com/swagger-api/swagger-ui>

3. If you want to simplify  code for sending http request.  If you want do it simpler than httpclient does. Use <https://github.com/restsharp/RestSharp>.
   
4. if we want to make models based on the existing API. How can we turn `jaml` into a class? Use  <https://openapi-generator.tech/docs/generators/csharp>.

5. How does it write the interface without transformation manually, but clearly. Use  <https://www.nuget.org/packages/RestEase.SourceGenerator>
	
6. If the server is not working yet, but we were given an API and we would like to write the processing code so that everything looks like we are requesting a real server and getting a response.
Use <https://github.com/WireMock-Net/WireMock.Net>

7. Specify a query string for each interface field to obtain it and create an object that will automatically create a class for the interface and methods for queries.
Use <https://www.nuget.org/packages/refit.httpclientfactory>

Other 

- <https://github.com/KosarevDmitry/Hypermedia>
- <https://github.com/FluentValidation/FluentValidation>
