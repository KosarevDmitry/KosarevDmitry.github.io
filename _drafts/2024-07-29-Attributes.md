---
title: Attributes
date: 2024-07-29 12:57:23 +0200
categories: []
tags: []
---

- [Obsolete("Called by the de-serializer; should only be called by deriving classes for de-serialization purposes")] 

- [XunitTestCaseDiscoverer("RetryFactExample.RetryFactDiscoverer", "RetryFactExample")] sample.xunit.
: <https://github.com/xunit/samples.xunit/blob/01a3052741b1119ff3ce51a5390892d844d1d797/v2/RetryFactExample/RetryFactAttribute.cs#L9>

[DebuggerDisplay("{Microsoft.EntityFrameworkCore.Query.ExpressionPrinter.Print(QueryExpression), nq}")]

-[DebuggerDisplay("{DebuggerDisplay(),nq}")]
: <https://github.com/dotnet/efcore/blob/5c670bba0e4a3922de243924e923ef9fdc0a9f3f/src/EFCore/Metadata/Conventions/RelationshipDiscoveryConvention.cs#L1413>
 <https://learn.microsoft.com/en-us/dotnet/framework/debug-trace-profile/enhancing-debugging-with-the-debugger-display-attributes>
 
- [DebuggerStepThrough]

// UsedImplicitly для resharper, так как он непосредственно не вызывается, а используется только reflection, для resharper это не очевидно.
    // Чтобы подавить предупреждение от него, этот аттрибут используется.
    [UsedImplicitly]
	
	
<https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/attributes/nullable-analysis>
	
public class Test
{
    [Fact]
    private void Run()
    {
        var s = new StaticAnalisisAttr();
        s.ScreenName =
            null; // without [AllowNull] get Warning CS8625 : Cannot convert null literal to non-nullable reference type.
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