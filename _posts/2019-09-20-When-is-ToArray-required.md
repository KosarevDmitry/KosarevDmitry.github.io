---
title: When is ToArray required
date: 2019-09-20 18:19:30 +0200
categories: [dotnet]
tags: [linq]
---

Why is ToArray required in certain situations?


```csharp

public class LinqTests
{
    private static int _count1 = 0;
    private static int _count2 = 0;

    [Fact]
    public void DelegateCaller()
    {
        IEnumerable<A> list = new List<A>()
        {
            new A(1, 1),
            new A(1, 2),
            new A(1, 3),
            new A(2, 1),
            new A(2, 2),
            new A(2, 3)
        }.AsEnumerable();

        Func<A, bool> selector1 = (a) =>
        {
            _count1++;
            return a.a > 1;
        };
        Func<A, bool> selector2 = (a) =>
        {
            _count2++;
            return a.a > 1;
        };


        var ienumerable = list.Where(selector1);
        var array = list.Where(selector2).ToArray();

        var threshold = Enumerable.Range(0, 2);

        foreach (var item in threshold)
        {
            var choosed1 = ienumerable.Where(o => o.b > item);
            var choosed2 = array.Where(o => o.b > item);

            foreach (var rec in choosed1) { }

            foreach (var rec in choosed2) { }
        }

        int listCount = list.Count();
        Assert.True(_count1 == listCount * threshold.Count());
        Assert.True(_count2 == listCount);
    }


    record A(int a, int b);
}

```