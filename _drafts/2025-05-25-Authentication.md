---
title: Authentication
date: 2025-05-25 22:02:56 +0200
categories: [C#]
tags: []
---

authentification
выполняется как и все в несколько приемов

В startup разработчиком добавляются схемы 
имя стринговая переменная c привязкой к  handler class у которого есть согласованный метод для этой задачи. определенный как обычно контрактом интерфейсом


во вторых нужно добавить  в цепочку вызовов  какой нибудь middleware стандартный вариант добавляет  AuthenticationMiddleware
хотя это не обязательно, подойдет любой middleware или feature  которым можно перехватить контекст
в тестах так и делается поищите в репо `private static async Task<TestServer> CreateServer`
и вызвать  context.AuthenticateAsync. Это и есть начало аутентификации.

все миддлеваре вызываются автоматически в той очередности которой они добавлены.
следовательно чем раньше вы добавите аутентификацию все последующие смогут им воспоользоваться


что делает AuthenticationMiddleware
Когда очередь дойдет до него в нем  перебором вызываются
обработчики всех зарегестрированных схем
handler.HandleRequestAsync()
если одна из них завершается успешно нет смысла дальше продолжать потому что юзер идентифицирован, клеймы добавлены и на этом процесс заканчивается.
если ни один из них не завершился успешно вызывается  default вариант

result =  await context.AuthenticateAsync(DefaultAuthenticateScheme.Name);

результат оборачивается в  AuthenticationFeatures и добавляется в FeatureСollection.
 var authFeatures = new AuthenticationFeatures(result); 
 context.Features.Set<IHttpAuthenticationFeature>(authFeatures);
 context.Features.Set<IAuthenticateResultFeature>(authFeatures);

теперь на всем жизненном цикле запроса можно выдергивать эти интерефейсы по необходимости.
Feature кстати один из замечательных паттернов. 

  
context.AuthenticateAsync(mystringvar);
сам процесс обработки происходит условно в 2 приема: 
сначала значение перехватывается extension .AddPolicyScheme если  названия не совпадают ищется
название схемы но сначала у по названию PolicyScheme
и переправляется на нужную схему, логика в PolicyScheme может быть любая
если querystring key == `boo` then go to  scheme1
если Datetime.Now> 12 then go to scheme2
посмотрите PolicyTest.cs

более того  policy может миксировать то есть вызывать обработчики из разных схем
 ...
 p.ForwardDefault = "auth1";
 p.ForwardChallenge = "auth2";
 p.ForwardSignIn = "auth2";
...
результат процесса  authentification
вызов 