---
title: Is operator
date: 2024-02-11 15:17:58 +0100
categories: [C#]
tags: [syntax]
---

I haven't seen this use case for __is operator__ before and it doesn't seem to be mentioned in the manual. The idea comes down to the fact that you can add checks based on the type and value of properties.  

<https://github.com/dotnet/dotnet/blob/a0bfad9e77c2eeeeb094533850ae69eebb295f7f/src/command-line-api/src/System.CommandLine/Parsing/StringExtensions.cs#L417>

```csharp
using FluentAssertions;

namespace Tests;

public class Istests
{
    
    private const string Earth = nameof(Earth);
    private const string Sky = nameof(Sky);

    [Fact]
    private void Test()
    {
        var b1 = new B1();
     
        b1.Directives.Add(new CliDirective());
        b1.Directives.Add(new CliDirective());

        Parse(b1).Should().Be(Response.AisB1withDirectivesList);
        
        b1.Sphere = Earth;
        Parse(b1).Should().Be(Response.AisB1withEarh);
        
        b1.Sphere = Sky;
        Parse(b1).Should().Be(Response.AisB1withSky);

        b1.Directives = new CliDirective[0];
        Parse(b1).Should().Be(Response.AisB1withDirectivesArray);

        var b = new B();
        Parse(b).Should().Be(Response.AisB);
    }


    enum Response
    {
        AisB,
        AisB1withDirectivesList,
        AisB1withSky,
        AisB1withEarh,
        AisB1withDirectivesArray
    }

    Response? Parse(A a)
    {
        if (a is B { Commands: IList<CliDirective> commands })
        {
            return Response.AisB;
        }

        if (a is B1 { Directives: CliDirective[] directives1 })
        {
            return Response.AisB1withDirectivesArray;
        }

        if (a is B1 { Directives: List<CliDirective> directives })
        {
            _ = directives.Count;


            if (a is B1 { Sphere: Sky } b1)
            {
                _ = b1.Directives.Count;
                return Response.AisB1withSky;
            }

            if (a is B1 { Sphere: Earth } b2)
            {
                _ = b2.Sphere;
                return Response.AisB1withEarh;
            }

            return Response.AisB1withDirectivesList;
        }

        return default;
    }


    class A
    {
    }

    class B1 : A
    {
        public IList<CliDirective> Directives = new List<CliDirective>();
        public string Sphere = String.Empty;
    }

    class B : A
    {
        public IList<CliDirective> Commands = new List<CliDirective>();
    }
    class CliDirective
    {
    }

}

```