---
title: OptionsMonitor
date: 2025-05-25 17:33:37 +0200
categories: [C#]
tags: []
---
options idea is settings, parameters set, necessary  aid kit, point url,  set of descriptions of obects. Look at GoogleOptions for oauth2 implementation.
"D:\src\aspnetcore\src\Security\Authentication\Google\src\GoogleOptions.cs"

src D:\src\runtime_libraries\runtime_libraries\_options\Microsoft.Extensions.Options\src\D-src-runtime_libraries-runtime_libraries-_options-Microsoft.Extensions.Options-src-.--.cs$-content.cs_

participants 

-OptionsBuilder adds named action for option 
-OptionsFactory aplly action collection to оptions
-ValidateOptionsResultBuilder collects errors received in validation. if they exist then  it output them if does not exist return success
-OptionsCache  idea  is to keep a Lasy of Option in ConcurrentDictionary.
-OptionsManager add option to cache.
-UnnamedOptionsManager calls `factory. create` that invoke actions with option.
-OptionsMonitor get option from cache.
-Options return OptionWrapper
-OptionWrapper is  generic pattern to return different objects in the equal manner
-ValidateOptions keep Func and Name, and Validate(string? name, TOptions options) method that check if  Name == null || name == Name
then Func will be invoked
StartupValidator  ?
