---
title: Cheat-sheets
date: 2024-01-25 09:12:53 +0100
categories: [C#]
tags: []
---

<D:\src\runtime\src\libraries\System.Private.CoreLib\src\System\Math.cs>  
<D:\src\runtime\src\libraries\System.Runtime\System.Runtime.sln>
<D:\src\runtime\src\libraries\System.Runtime\tests\System.Runtime.Extensions.Tests>
ABS
: absolute 

 ```C# 
  if (value < 0) 
   {
	value = -value;
   }
```
   
BIGMUL
: multiply int to ulong

`((ulong)a) * b;`

Reverse
: 

```
int[] Reverse()
{
var arr = Enumerable.Range(1, 12).ToArray();
int leftIndex = 3;
int rightIndex = 7;

        while (leftIndex < rightIndex){
            int tmp = arr[leftIndex];
            arr[leftIndex] = arr[rightIndex];
            arr[rightIndex] = tmp;

            leftIndex++;
            rightIndex--;
        }
        

        return arr;
    }
```
