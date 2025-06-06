---
title: How to suppress piece of code?
date: 2024-08-15 17:52:06 +0200
categories: [dotnet]
tags: [suppress]
---


- For class and  members  

```csharp
 [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
 ```
 
-  inside a method 

```csharp
 #pragma warning disable CS0618 // Type or member is obsolete
 //code
 #pragma warning restore CS0618 // Type or member is obsolete
 ```
 
 
-  Using props and parameter
 
<https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/attributes/nullable-analysis>

```csharp
public class Test
{
    [Fact]
    private void Run()
    {
        var s = new StaticAnalisisAttr();
        s.ScreenName =
            null; // without [AllowNull] over `ScreenName` get `Warning CS8625 : Cannot convert null literal to non-nullable reference type.`
    }
}

internal class StaticAnalisisAttr
{
    [AllowNull]
    public string ScreenName
    {
        get => _screenName;
        set => _screenName = value ?? "temp";
    }

    private string _screenName = "temp";
}
 ```
 