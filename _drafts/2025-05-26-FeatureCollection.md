---
title: FeatureCollection
date: 2025-05-26 07:20:52 +0200
categories: [C#]
tags: []
---
FeatureCollection Это node структура

если запись key не находится в текущем ноде проверяется подчиненный  _defaults
Перебор проходит по всем узлам в коллекции
public class FeatureCollection : IFeatureCollection
private readonly IFeatureCollection? _defaults;