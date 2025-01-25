---
title: Principles, including `SOLID`
date: 2024-01-02 08:04:04 +0100
categories: [codingStyle]
tags: [principles]
---

- No news is good news.  
- Do one thing well  
- Let someone else do the hard part  
- Principles are an expensive thing, and not everyone can afford them.  
- To understand the abstraction layer, you need to understand the reason for its occurrence, go down to the layer below.
- Programmers work for themselves
- A programmer involuntarily wants to be asked for help, so he complicates the presentation of the service he provides.
- Any dependency leads to problems. `IDE`  is dependency also,  to know  `СLI` commands of  `IDE` buttons is  almost nessesary. There are must be  `make` file, config, etc somewhere.
- The more wrappers, the more difficult it is to test.
- The world model is more important than its details.
- Comparison is the most important tool for learning.
- The only way to learn a language is to read source code, and then to coding.
- Good programmers do code once, bad ones do the same thing several times.



All `SOLID` principles are partly interconnected.

1. `Single responsibilty` of classes about not inflating a class.

	The smaller the class, the greater the possibility of reuse.

	Probably so.

	Disadvantage - since instead of one class, we have several, therefore, several memory allocation operations will be required, which reduces performance.
	In `dotnet` it is possible to create a partial class and they are used. So there is a reason.

	Advantages - if there are several classes, therefore, the lifetime of each of them is shorter, the object becomes available for deletion from memory earlier.

2. I would add `Single responsibilty of method`

	The same idea - the smaller the method, the greater the probability of reusing a block of code. Small procedures are easier to manipulate, replace.

	Although usually, naturally, they first write in a single method, then deal with permutations. Reminds me of writing texts, references, where the sequence of information presentation is important, roughly speaking, the sequence of paragraphs.

	Methods in `runtime`, as a rule, are small in size, they are removed from the stack faster.

	But at the same time, to improve performance, the `inlining` attribute is used, which leads to the implementation of the code of the called method into the code of the calling method.
	Time is saved on the call. A dilemma arises - to do it yourself, or assign it to someone. Control and distribution functions require resources.


	In `dotnet`, the ability has recently appeared (I don’t know how long ago, in general it has not always been there) to describe a method inside another method, I often come across such code.

	```csharp
	internal  A() {
	private  B()
	private C()
	 } 
	```

	If one internal calls several private methods, nothing changes for testability.
	If they were all internal, then each one could be tested.

3. `open/close` the same logic only in relation to libraries, the functionality should not be bloated.

	The smaller the library, the greater the opportunity for reuse.
	Using internal methods allows them to be tested from an external unittest project, at the same time they are closed from clients.

	The less code is subject to changes, the better.

4. `Liskov` about continuity, stability of new implementations. I would move it to the end of SOIDL.


5. `Interfacе` about the same, if a class implements several interfaces, it can be assumed that the object has different responsibilities.

	```csharp
	A :IB, IC
	IB b = A;
	IC c = A;
	```

	Links are created to a limited number of members of class A. 


6. `Abstraction`

	Using Interface allows: 

	- testing, replacing mock objects
	- changing the library version without having to make changes to the client code.

	What reasons might there be for changing the code:

	1. Shortcomings are discovered.
	2. There will be an opportunity for improvement - another logging code, caching, inclusion of any other side effects.
	3. Changing constructions, syntax, using classes with higher performance, proposed by new versions of the language, runtime.
	For example, instead of or along with `String` or `Array`, use `StringSegment`, `StringValues`, `Segment`, `Pathstring`, `ArrayBuilderSegment<T>`, `record`, `Arraybuilder`.
	4. Inventing a new algorithm. For runtime - this is normal, I have seen such comments to the code with a link to `github`, for applied programming it is unlikely.
