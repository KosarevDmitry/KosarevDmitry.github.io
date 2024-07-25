---
title: Useful_lib
date: 2024-04-09 17:35:44 +0200
categories: [C#]
tags: [coding]
---

- Bogus  -	 generate records for tests

- Shouldly  Version="4.2.1"  
```
Test(arr, 0, 0).ShouldBe(expected);
```

- FluentAssertions Version="5.9.0"  
```
  response.StatusCode.Should().BeEquivalentTo(StatusCodes.Status201Created); 
```

- Polly - run 
- Benchmark - check speed execution  
- RestSharp - httpclient wrapper  
- Masstransit  

- Microsoft.Azure.WebJobs.Extensions.Storage Version="4.0.2" 
- Microsoft.NET.Sdk.Functions Version="3.0.7" 

- SixLabors.ImageSharp Version="1.0.1" - Image resize 
   
- Proxi https://github.com/castleproject/Core/blob/master/docs/dynamicproxy-introduction.md
   
- Respawn - очистка/восстановление базы MSSQL Postgres для тестирования
   https://github.com/jbogard/Respawn/tree/master
 
 
- AngleSharp - поиск и считывание  содержания html тегов в С# 
	- [https://github.com/AngleSharp/AngleSharp]
	пример использования
[D:\src\aspnetcore\src\Security\test\AuthSamples.FunctionalTests\TestAssert.cs]

```
 public static async Task<IHtmlDocument> IsHtmlDocumentAsync(HttpResponseMessage response)
    {
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        Assert.Equal("text/html", response.Content.Headers.ContentType.MediaType);
        var content = await response.Content.ReadAsStringAsync();
        var document = await BrowsingContext.New()
            .OpenAsync(ResponseFactory, CancellationToken.None);
        return Assert.IsAssignableFrom<IHtmlDocument>(document);

        void ResponseFactory(VirtualResponse htmlResponse)
        {
            htmlResponse
                .Address(response.RequestMessage.RequestUri)
                .Status(response.StatusCode);

            MapHeaders(response.Headers);
            MapHeaders(response.Content.Headers);

            htmlResponse.Content(content);

            void MapHeaders(HttpHeaders headers)
            {
                foreach (var header in headers)
                {
                    foreach (var value in header.Value)
                    {
                        htmlResponse.Header(header.Key, value);
                    }
                }
            }
        }
    }
```


- Microsoft.AspNetCore.Http.Abstractions
   PathString - кодирование/ декодирование строки, убрать лишние '/' при конектикации
   ["D:\src\aspnetcore\src\Http\Http.Abstractions\test\PathStringTests.cs"]
   
   

 - Microsoft.Extensions.Options
```
public class Baz
{
    public string Name { get; set; }
}

public class Foo
{
    public int Year { get; set; }
}
  
[Fact]
public void OptionTest()
{
   IOptions<Baz> o= Options.Create(new Baz());
   IOptions<Foo> o1= Options.Create(new Foo());
   _ = o1.Value.Year;
   _ = o.Value.Name;
}
```