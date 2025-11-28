---
title: Typescript
date: 2025-11-26 21:35:54 +0100
categories: [Nodejs]
tags: []
---

For a more stable understanding, first It is better how look like compiled js file. Reading the code is not very difficult, but to understand it more closely, one should still do so, to understand what we are talking about in general, what kind of things there can be.

All you need    

1. To check that `tsc` CLI is installed
2. Run `tsc --help` just in case. It is an usual approach.
3. Download  https://github.com/microsoft/TypeScript-Website.git, open `.\packages\documentation\copy\en\referene` and	read  markdown files. 
	In my opinion, the HTML presentation is great, but too dynamic to be easily read.
	It makes it difficult to concentrate on the meaning. So, I usually download any repo and read it in Notepad++ with minimal syntax highlighting. 
	This approach allow to write comment and whole reading process  become more productive.
4. Create project `mkdir test && cd test && tsc --init && echo. > test.ts`
3. Insert any snippet from reference to  file.
4  Run `tsc` . New js file will be created. 

This way  you understand code deeply than just reading.   
 
Pecular recommendations about appropriate  config settings I can not give.  Problems are resolved as they arise.
At least `target`, `module` are  certainly important.