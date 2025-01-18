---
title: How learn dotnet
date: 2025-01-15 09:16:54 +0100
categories: []
tags: []
---

Если использовать страницы как первичный источник информации, танцуем от  откуда танцевать я должен внимательно копировать данные , собрать в сгенерированный project запустить и убедится что это работает. Так как все просмотреть не возможно в обозримом периоде когда моя личная оперативная память удерживает информацию откуда я что взял, какие разделы
просмотрел, что просмотрел/изучил полностью  где остановился. то возникает фрустрация
я перманенто пребываю в состоянии что много не знаю у меня нет "базы" полна. Вы работали с этим то, да работал. Помню

Прежде чем добраться до кода, я вынужден просматривать слова различной степени абстракции, вступления, очевидные пояснения и поэтому не нужные или наоборот не очевидные пояснения пока я не попробую код в работе. 
Редко бывает чтобы у меня не оставалось вопросов.В  конце концов если бы это было так то не тусовалось бы огромное число народу в stackoveflow. Что они там все делают, они мануал читали?

Пример вступления

In this article, you'll learn how to use the IHttpClientFactory interface to create HttpClient types with various .NET fundamentals, such as dependency injection (DI), logging, and configuration. The HttpClient type was introduced in .NET Framework 4.5, which was released in 2012. In other words, it's been around for a while. HttpClient is used for making HTTP requests and handling HTTP responses from web resources identified by a Uri. The HTTP protocol makes up the vast majority of all internet traffic.

Я думаю что из этих слов 
"with various .NET fundamentals", "vast majority of all internet traffic", "it's been around for a while" etc.
через неделю -две, даже завтра, останется  в моем сознании.
И что мне с этим делать если в repo 13 871 md документов с похожими вступлениями. 
Зачем тебе знать все это? Пользуйся как справочником и не забивай себе голову. Нет, так не пойдет. Я еще раз повторяю я это делаю давным давно. И ощущение ущербности такого подхода не оставляет меня. Чтобы понять, где я нахожусь, какие опции существуют, мне следует  познакомиться с тематикой полностью.

другой вариант смотреть listing `Exam Ref 70-483 Programming in C#` by Rob Miles or LinqPad by Joseph Albahari
честно говоря но у меня такое чувство что оно не покрывает все, это понятно, прблема что она находится параллельно. В конечном счете, выбрать из rutime  тестов видоизменить их
и превратить их в книгу, могут многие. Над docs ведется работа постоянно, если бы они стали частью общего тогда да. 
Поэтому docs приритетней.  

base = https://learn.microsoft.com/en-us/dotnet/ 
I am sorting out with  project "D:\src\sharp_docs\docs\core\diagnostics\snippets\OTel-Prometheus-Grafana-Jaeger\csharp\OTel-Prometheus-Grafana-Jaeger.csproj"
Using `dtsearch` I look for  keyword `OTel-Prometheus-Grafana-Jaeger` in  indexed *.md files of a repo  `D:\src\sharp_docs\`
and get  path `D:\src\sharp_docs\docs\core\diagnostics\observability-prgrja-example.md`
It means path to page will  be  `base + /core/diagnostics/observability-prgrja-example`

что то я вынесу в отдельный блок как незначимое что то здесь уже можно писать собсвенные комментарии и т.д.

После того как я собрал список сгруппировал его  просмотрел, прикинул, легко заметить что в приложениях есть повторы, большинство примеров содержит много однотипного кода.
Главное- нескольких ключевых понятий и команд  методов.
Можно сжать еще. 

docs это еще не все 
Я напиcал комментарий к DiagnosticSource.csproj  
https://github.com/dotnet/docs/blob/main/docs/core/diagnostics/snippets/diagnosticsource/csharp/Program.cs
Через какое время понадобилось посмотреть, понял что ошибся в описании, смутило название "System.Net.Http", заменил на "Boo". Так лучше для меня лично, но не для всех, поэтому предлагать в repo я не собираюсь.
В DiagnosticSource.csproj   нет описания  метода isEnable 
Чтобы выяснить как он рабоает, нужно смотреть тесты в  `runtime`  
1. пользуясь `dtsearch` нашел library `System.Diagnostics.DiagnosticSource`
2. можно открыть в IDE  `build. -vs System.Diagnostics.DiagnosticSource` , но так как я уже немного помню эту библиотеку, нашел подходящий по названию
файл `DiagnosticSourceTests`, открыл в `notepad++`
и нашел тест для IsEnable
https://github.com/dotnet/runtime/blob/b7bdcc20a030558f83fad6b0c2f7e43e3d0d2e61/src/libraries/System.Diagnostics.DiagnosticSource/tests/DiagnosticSourceTests.cs#L137


> Без индексатора не обойтись, так как примеры c использованием одного понятия, объекта, например EventSource, не ограничивается только  разделом Diagnostic, где логически можно предположить что
он должен быть, EventSource используется в примерах  из networking раздела тоже.
Нужен идекс *.cs файлов. 




