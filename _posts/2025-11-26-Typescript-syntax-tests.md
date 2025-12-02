---
title: Typescript syntax tests
date: 2025-11-26 21:35:54 +0100
categories: [Nodejs]
tags: []
---

When you start to sort out with some library, CLI or sotmething similar, it initially seems  enormous, but gradually it becomes user-friendly maybe even comfortable and cozy and its imaganary size  shrink and shrink. There is only single issue how to get this state quickly.  
Despite of existence of highly interactive, complex and attractive websites created specially for learning libraries,you alway need  to find the compiler and  invoke it with `--help` parameter.  
I like a simple approach. Try the same with Typescript.


All you need    

1. To check that `tsc` CLI is installed
2. Run `tsc --help` just in case. It is an usual approach.
3. Download  <https://github.com/microsoft/TypeScript-Website.git>, open `.\packages\documentation\copy\en\referene` and	read  markdown files. 
	In my opinion, the HTML presentation is great, but too dynamic to be easily read.
	It makes it difficult to concentrate on the meaning. So, I usually download any repo and read it in Notepad++ with minimal syntax highlighting. 
	This approach allow to write comment and whole reading process  become more productive.
4. Create project `mkdir test && cd test && tsc --init && echo "" > test.ts`
5. Copy any snippet from  the reference to your source file.
6. Run `tsc` . The new js file will be created. 

This way you understand code deeply than just reading.   
 
Pecular recommendations about appropriate config settings I can not give.  Problems are resolved as they arise.
At least `target`, `module` are  certainly important.