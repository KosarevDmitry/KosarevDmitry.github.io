var builder1 = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
        .AddEnvironmentVariables();

    var config = builder1.Build();

    if (config.GetValue<bool>("UseVault", false))
    {
        var a = config["Vault:TenantId"];
        var b = config["Vault:ClientId"];
        var c = config["Vault:ClientSecret"];

    }

    builder1.Build();
