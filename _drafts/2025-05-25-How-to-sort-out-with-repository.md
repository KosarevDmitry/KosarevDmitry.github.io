---
title: How to sort out with repository
date: 2025-05-25 18:14:05 +0200
categories: [C#]
tags: []
---

легких не бывает.
1. репо очистить от doc comments 
2. убрать editor settings которые слишком щепетильны в вопросах стиля. Например две пустые строки уже ошибка. 
Понизить уровень  error to warning or none.
читать  rfc например для Security в aspnetcore rfc for oauth2, 
сделать draft diagram,  puml кажеться сильнее, mermaid похуже.

Потом читать код, по папкам или в IDE,  если не понятно искать код по непонятному слову в  sample and test dir 
например what means ForwardDefaultSelector
делать свои тест там же в repo все что в голову придет. 
лучше не заводить свой класс а добавлять в уже имеющиеся вряд ли не будет тематического класса.
а обвязки настройки уже в нем есть
если мне что то не понятно в тест методе, я его копирую с названием Kosarevtest и уже кручу верчу его как мне захочется. 
Делать комментарии
Добавить свой лог с автоматическим логированием точки вызова класс: метод: строка
и запускать на samle или тестах