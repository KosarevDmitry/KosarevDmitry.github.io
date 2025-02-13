---
title: Briefly about SQL
date: 2025-01-10 08:52:26 +0100
categories: [sql]
tags: [t-sql]
---


-  There are no libriries  
	Base issues or merits, call it as you would like, in usual language  as C# are libraries. 
	Moreover, it is necessary to know the form and content, to track the creation of httpcontext, how it becomes overgrown with details and what good they do.
 	Everyone is trying to teach syntax, commands, figuratively speaking, 48 form Tai Chi - put your foot here, move your hand here, and you will be fine, something like that.	It's fascinating, probably inevitable, to get the hang of it, to get used to the local slang. Who can't do small things can't do big things.
	But in reality, ultimately, it is necessary to understand entire composition, if translated into the concepts of literature, then the programmer will have to read a lot of stories and novels. The form of study through reading copy-paste snippets, paragraphs from books, is depressing and you will not get far with it. Libraries are the most important thing.

	In SQL - the situation is simpler. Only scripts, one or two, maybe 3, well, 5 at most in a bundle and that's it.


-  There are no tests
	
	Without tests, it's like coding on the knee. But you can come up with something. You can do a test for each procedure, for example crete add Abc_test procedure fo "Abc" one. Though it looks redundant.
	I don't know if they do it this way or not.
	I also saw the link https://tsqlt.org/. I didn't figure it out. As deutsches say 'Morgen, morgen nur nicht heute'.


- You can write extensions, write code in C# and generate procedures that way.

- Open source  

	When the syntax and structures are clear, where to get resources, code for reading, for getting used to the language standards, what to practice on. The main thing is to understand the code written by others.
	1. You can decompile procedures and look at their implementation.
	2. `SharePoint` has a large `db`, a lot of code.
	3. For C,C++ programmer, who geeks it, Sqlite, Posgre DB source code is available.
	
-   There is no marker showing that the function is used somewhere.
	In a modern IDE for C#, a description is generated for each class member. If a method is not used at all, is not involved, does not twitch anywhere, then the kind IDE will highlight such a method in pale gray font.
	Or it will throw a warning, if configured. For methods called via reflection, the `Dynamic` attribute is added so that the compiler does not remove it from the assembly altogether as unnecessary.
	 
	In SSMS it is not visible whether the procedure is in demand or not, and the databases are growing very quickly, Maybe the procedure is no longer needed. Let's say there was a client. The client was reworked or has already ceased to exist, but the SQL code remains.
	The number of clients per base can be quite decently. Employee list  maybe  is needs for somebody ,  by `ODBC` in  `Excel` to be requested, why does't to give the access?  Someone else needs some other source, table,etc. This happens, maybe you agree. It's not always the paradigm: one application - one database.
	Everything will have to be taken into account, the office writes. It looks like the story of Tom Sawyer with painting the fence, who hasn't painted it. Teams come and go, but the data base is eternal. I felt this in the bank, having leafed through the general bank. Oracle.

	What to do with this? You can download all the procedures and functions and look for references to the function manually using a regularsearch. Or better yet, make a code parser and look for names that are mentioned only once when declared and that's it. But this is what concerns  internal consumption. As for external use, I have no ideas. It is not clear how to emulate `public`, `private`.

- Call for execution
	Everything is fine with this. I selected a piece of code, launched it, it's just luxury.
	
