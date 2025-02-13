---
title: T-SQL glossary
date: 2025-01-09 18:39:34 +0100
categories: [sql]
tags: [t-sql]
---

As I write this post, there is a good chance that  T-SQL will not required for me in the near future. Almost. I have aspire and opentelemetry on my agenda. But now I have to deal with T-SQL, such are the circumstances.

I had enough vocabulary and practice for a few years, then I was preparing for the `assessment`, but gradually my active source transformed into passive. If you don't use it for a long time, it can disappear almost completely. I needs to restore my ability. 
 
This reminded me of comments by Kato Lomba, who knew a bunch of languages. The analogy is apt.

**Excerpt from the book "How I Learn languages"**
> Question one: is it possible to know sixteen languages?  
	Answer: no, you can't. At least you can't know them at the same level. I have only one native language - Hungarian. But five languages ​​live in me at the same time: Russian, English, French, German and Hungarian. Working with these languages, I translate from one to another in any combination and "switch on" to translation instantly. Before starting work related to the use of Italian, Spanish, Japanese,
	Chinese or Polish, I usually spend half a day looking through my notes to refresh my knowledge. With the other six languages, I work only as a translator of fiction and specialized literature, that is, I have only passive practice here.

I mean that time will be needed to "refresh the knowledge". A couple of days.
The question is how these "own records" should look, for T-SQL in this case.


- Usually we start with a dictionary. We make or look for a dictionary. There is reserved keyword list. You can look through them and make comments.
	<https://learn.microsoft.com/en-us/sql/t-sql/language-elements/reserved-keywords-transact-sql?view=sql-server-ver16> 

	I did it this way, but I didn't like the result. The list of keywords is not complete. For example, from my point of view `login` is a keyword in the expression `EXECUTE AS LOGIN`. However, there is no such keyword in the list.

	I'm interested in functions, metadata, not just keywords, there are words that relate to topics that I would like to exclude from consideration. And a lot of time is spent on selecting examples.
	

- Where to store the glossary.
	I thougt to create database - a table with reserved keywords and descriptions and a table with expamples related to them. It is not difficult. And Rider, which I like, is great at working with databases. But using a database makes the processes more complex, an extra dependency appears. You want something light, a draft, why bother.

Choices 

1. You can read the own code, old db, educational databases. As glossary, this approach does'n suitable, too many dublication, repetition the same functions, procedures. And  becouse there is focus on `DDD`, development theme, and not on features of language. 

2. You can read book, listing to them espesially, as `Exam Ref 70-761. Querying Data with Transact-SQL Ben-Gan.` 

	The disadvantage is that no book is an encyclopedia, and the material it contains gradually becomes outdated.
	Books can be useful as an addition to the basic structure of knowledge, but not as a foundation. The matrix must be comprehensive, the cells will be filled after that.
	
3. Read the reference from A to Z.

	It is possible, but there are too much text and the codes are distributed across several fragments. Often I immediately copy the fragment into the IDE, run and save the example and as a result I get a set of scripts, but there is no sense of universality. And the `copy-paste` procedure is often tedious.

4. You can see functions in SSMS object tree and recall its point.
 I have made this way too, but in this case you must write  tests yourself, ad parameter to run procedure and so on. It turns out to be long. "Let the iron saw work".

	It is also necessary to consider that the directories in SSMS and the reference may not match. For `graph` and `logic` in SSMS 2019 there are no directories at all. `OpenQuery` in reference is included in the `Relation operators` group, and it is considered `Rowset functions` in SSMS. Although these are, in general, trifles.


General conclusion.
 I would like to have the whole range of sql examples in one or several text files, listing, essentialy, but it should to be a complete and up-to-date reference.
 Here I came up with the idea of trying to download snippets from markdown. I'm used to looking at the repo. It turned out well.

Result:  [language-elements.sql](/assets/language-elements.sql)

By this script I received the code that ready for execution. All that remains is to open the file in SSMS.

<script src="https://gist.github.com/KosarevDmitry/b64f73a4824b280db2d80652463361e9.js"></script>

I view and execute the code without copy-paste operation, you just need `select and execute`, if comments are needed, I look the source `html` or `md`. The each block has a link `--string-split-transact-sql.md line: 143`, where the file name without the extension matches the page name in the `url` `https://learn.microsoft.com/en-us/sql/t-sql/` plus the `language-elements/` section and the title.

Perhaps after viewing the code, you will want to add a short comment. It is difficult to advise something here, brevity is the sister of talent and the stepmother of a royalties, so the comment may be useless, I often fail, that is, to write briefly enough, but so that it conveys the essence, and clings to me. Usually I want to somehow express the idea. I added comments starting with `--!`. The highlighting in the code works, you can view it in a text editor as `notepad++`.

There may be display errors when the entire code turns red. Because of unclosed quotes, for example, in the surname D'Hers of French origin. Of course, there were obvious things e that are not interesting me. Therefore, I left comments on what interests me and then  I will find the record marked with my comments,  by search in the `IDE` or `Notepad++`.

After viewing the listing, I will already know the material quite well. In my opinion, it turned out very well. I would like to have in my "RAM" information about what options exist in principle. In a semi-finished version, in the state of "I've already seen this". When you don't know about the existence of an option, it is more problematic to write "good" code. Therefore, a complete and up-to-date reference book is needed, the only question is the presentation format and so that the use of the “copy-paste” operation is not required.