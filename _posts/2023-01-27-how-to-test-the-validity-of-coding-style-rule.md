---
title: How to test the validity of a Coding Style rule
date: 2023-12-28 16:32:27
categories: [Csharp]
tags: [code style]
---

Is it possible to refute the statement by citing the code in [runtime], which is probably **fine** from Microsoft’s point of view?
I think it's acceptable, I don't know other criteria. I have a feeling that reading recommendations is useless, just as in a language you need to listen to live speech, read books, and not short topics.
For example, there is a statement: it is desirable that there is only one exit `return statement` from a function.
Such statements are involuntarily remembered because they are categorical and simple.  
Maybe I'm wrong, so just in case, I typed keywords into Google **function only one return statement**
The number of references is enough to confirm that such a statement exists.

Probably, it would be possible to compile a list of statements of this kind and then refute them,
prove that in general they mean nothing.

Look at the code [HashHelpers.cs].

```csharp
  public static bool IsPrime(int candidate) 
    { 
        if ((candidate & 1) != 0) 
        { 
            int limit = (int)Math.Sqrt(candidate); 
            for (int divisor = 3; divisor <= limit; divisor += 2) 
            { 
                if ((candidate % divisor) == 0) 
                    return false; 
            } 
            return true; 
        } 
        return candidate == 2; 
    } 
```

An alternative approach could probably be like this:

```csharp
    public static bool IsPrime(int candidate) 
    { 
        bool result = true;
        if ((candidate & 1) != 0) 
        { 
            int limit = (int)Math.Sqrt(candidate); 
            for (int divisor = 3; divisor <= limit; divisor += 2) 
            { 
                if ((candidate % divisor) == 0) 
                    result=false; 
                    break;
            } 
        }
        else{ 
          result = candidate == 2; 
        }
        return result;
    } 
```
	
[runtime]:https://github.com/dotnet/runtime/
[HashHelpers.cs]:https://github.com/dotnet/runtime/blob/main/src/libraries/System.Private.CoreLib/src/System/Collections/HashHelpers.cs
