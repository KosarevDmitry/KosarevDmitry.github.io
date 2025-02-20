---
title: Once again about IEnumerable
date: 2025-02-18 14:49:15 +0100
categories: [dotnet]
tags: [features]
---

IEnumerable is such a nature that it is essentially a action and not an object. The only way to be sure of this is to look at what it is transformed by msbuild.

It's like the difference between the subject and the predicate from  point of view  of grammar and philology  - the object and the action. 
Both are parts of speech. Elements (aka object) from the point of view of philology and syntax, having their own properties and features.  
Psychologically, to think about IEnumerable  as action helps to perceive reality more easily.

`string[]` is a reference to an object. It already has a value.

`IEnumerable` is a reference to  an Enumerator (object of course), but being an action, before getting a value it must be executed.
 
Here the everything are  static. 

```csharp
int [] a;
int [] b;
int[] c  = [..a, ..b];
```

Here, everything is possible, including any side effect, just like when performing any function.

```csharp
IEnumarable<string>  a;
IEnumarable<string>  b;
var c = [..a, ..b];
```

Examples
- <https://github.com/dotnet/docs/blob/main/docs/csharp/language-reference/statements/snippets/yield/Program.cs>
	- especially  this one	<https://github.com/dotnet/docs/blob/d9cf6dbc0552f5763e4d20f41dff6891c0bb4684/docs/csharp/language-reference/statements/snippets/yield/Program.cs#L82>
- <https://github.com/dotnet/docs/blob/main/docs/csharp/snippets/iterators/Generators.cs>


- How it is commonly used.
 
	```csharp
	class Snippet
	{
		internal IEnumerable<int> @Yield()
		{
			yield return 1;
			yield return 2;
		}

      public IEnumerable<int> DoWhile()
      {
        int index = 0;
        while (index < 10)
            yield return index++;
     }
	
		internal IEnumerable<int> @Array => new[] { 1, 2, };

		internal IEnumerable<int> @For()
		{
			foreach (int i in Enumerable.Range(0,2))
			{
				Console.WriteLine(i);
				yield return i;
			}
		}

		internal IEnumerable<int> SeveralFor()
		{
			foreach (int i in Enumerable.Range(0, 2))
				yield return i;

			foreach (int i in Enumerable.Range(2, 2))
				yield return i;
			
		}
				
		internal void Enumerate()	
		{
		
			List<int> collection=	[4,5];
			IEnumerator<int> enumerator = collection.GetEnumerator();
			
			while (enumerator.MoveNext())
			{
				Console.WriteLine( enumerator.Current.ToString());
			}
		}
		
		internal IEnumerable<int[]> WithSideEffect(int i)
		{
			// These messages will only be in the first loop!
			Console.WriteLine(i);  
			if (i>0) Console.WriteLine(i);
			Console.WriteLine("first loop");
			yield return [1, 2];
			
			
			Console.WriteLine("second loop");
			yield return [3, 4];
		}
		
		internal IEnumerable<int> Wrapper
		{
			get
			{
				int CreateParameters(int i)
				{
					Console.WriteLine(i);
					return i;
				}
				yield return CreateParameters( 1);
				yield return CreateParameters( 2);
			}
		}
		// xunit MemberData  
		internal IEnumerable<object[]> MemberData
		{
			get
			{
				object[] CreateParameters(Action<int> call, int expected)
				{
				   return new object[] { call, expected };
				}

				yield return CreateParameters(Console.WriteLine, 1);
				yield return CreateParameters(Console.WriteLine, 2);
			}
		}
	}
	```
	

	