---
title: IdentytyServer
date: 2025-05-14 21:18:11 +0200
categories: [Identity]
tags: [oid]
---
tesis
1 Every middleware filter etc can serves as identity server , any method receiveing httpcontext can check, update, breake proccess 
2. but usually class implied interface   called identityserver
3. login and password, clientid and credential   keyvalue pair are passed in  header or body. 
4. stages 
  - parse  Duende.IdentityServer.Validation.ISecretParser.ParseAsync
  - validate - compare  actual and excepted - Duende.IdentityServer.Validation.ISecretValidator.ValidateAsync
  validate endpoint Duende.IdentityServer.Validation.IExtensionGrantValidator.ValidateAsync
  validate beratoken "access_token" Microsoft.AspNetCore.Http.HttpRequest.ReadFormAsync

A resource is set of scope.
A scope is set of string variables.
A claim  is keyvalue pairs.
A principal is claim set. 
A client can has claim set.
A client can be accociated himself with scope set or resource set.
A result  that the  server produces is string variable what combines an information about the client the scopes, the recource.
This varable is named `access_token`.    
The cryptography algorithms RSA 256, Base64string  are used to do token.

The identity server  issues, verifies, decrypt, encrypt various type of tokens.


interaction of entyties you can seen in Duende.IdentityServer.Stores.InMemoryResourcesStore class
props `Duende.IdentityServer.Models.IdentityResource` and `Duende.IdentityServer.Models.ApiScope`
 has set of string variables named UserClaims.
 prop `Duende.IdentityServer.Models.ApiResource`  has several set of string variables named
UserClaims,string Scopes sr and also Secret class with value description and expiration.



// https://docs.duendesoftware.com/identityserver/v6/fundamentals/resources/api_scopes#authorization-based-on-scopes
