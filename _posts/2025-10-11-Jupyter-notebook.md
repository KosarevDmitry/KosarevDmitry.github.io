---
title: Jupyter-notebook
date: 2025-10-11 15:26:06 +0200
categories: [py]
tags: []
---

- jupyter-notebook `.ipynb` file is json with  fields `code`, `comment` and field  to memorize the execution result of `code` field content.

The workflow (pseudocode) looks like as following:

```py
json=ReadFileAsJson(ipynb)
renderAsHtml(json)
 
# User clicks `div` with cells[1].source content

obj=json.cells[1]
								
if obj.cell_type == "code":
  result = (py obj.source)
  obj.metadata.ExecuteTime = result.executeTime
  obj.metadata.outputs = result.output
  obj.execution_count++

update(obj, json)
renderAsHtml(json)
```