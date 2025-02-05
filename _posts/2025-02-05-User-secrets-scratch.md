---
title: User-secrets scratch
date: 2025-02-05 12:12:52 +0100
categories: [dotnet]
tags: [user-secrets]
---

- source

	<https://learn.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-8.0&tabs=linux>

	../AspNetCore.Docs/aspnetcore/security/app-secrets/samples/6.x/UserSecrets

- storage path
	`~/.microsoft/usersecrets/<user_secrets_id>/secrets.json`

- commands

	```bash
	dotnet user-secrets init
	dotnet user-secrets set "Movies:ServiceApiKey" "12345"
	dotnet user-secrets set "Movies:ServiceApiKey" "12345" --project "C:\apps\WebApp1\src\WebApp1"
	cat ./input.json | dotnet user-secrets set
	dotnet user-secrets list
	dotnet user-secrets remove "Movies:ConnectionString"
	dotnet user-secrets clear
	cat ~/.microsoft/usersecrets/934ecfd0-bf73-4a27-92aa-bd6334cc944d/secrets.json
	```

- csproj `<UserSecretsId>179fda9c-92c3-424f-9a38-43c5ceba7363</UserSecretsId> `

- usage

```csharp
	builder.AddUserSecrets(Assembly.GetExutingAssembly(),true)
	var movieApiKey = builder.Configuration["Movies:ServiceApiKey"];
	var moviesApiKey = _config["Movies:ServiceApiKey"]; //DI  IConfiguration 
```
- create poco settings class

```csharp
  
  public class MovieSettings {
	   public string ConnectionString { get; set; }
	   public string ServiceApiKey { get; set; }
```

```csharp
	var moviesConfig = 
		Configuration.GetSection("Movies").Get<MovieSettings>();
	_moviesApiKey = moviesConfig.ServiceApiKey;
```

```csharp

	// SqlConnectionStringBuilder builder
	var conStrBuilder = new SqlConnectionStringBuilder(
			builder.Configuration.GetConnectionString("Movies"));
	conStrBuilder.Password = builder.Configuration["DbPassword"];
	var connection = conStrBuilder.ConnectionString;
```