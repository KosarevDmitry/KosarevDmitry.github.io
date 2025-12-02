---
title: How to keep notes of node packages
date: 2025-11-30 15:57:56 +0100
categories: [learning]
tags: []
---

Let's say you're struggling with the number of libraries (because learning anything in a short time becomes a challenge).

What can you do to improve the process: understand - remember - apply?

Let's say you have a flagship industry repo, and you're curious about how it works. What do all its dependencies mean?

Let's say you don't understand enough the description in the readme.md and still have questions after superficial reading of code and running src in debug mode.

When reading code, I like to comment on the code or to add extra file with node.assert expression and want to keep this instance of the package, as it stores what I consider important notes.

You can:
1. Add an exception to .gitignore that allows you to keep individual packages, even though they're in node_packages. Commit them to Git.

The downside of this approach: maintaining all repositories is counterproductive, as they will eventually become too large.
It may be enough to save only files with your comments or individual parts of the code. 
Perhaps, despite the current availability of valuable "smart" AI assistants, custom snippets can still be useful.
You can store only individual code fragments, marking them like this:
`// <snippet> // </snippet>`
Perhaps even simpler, by adding `//`\`\`` at the beginning and the end of code and processing all files for searching and subsequent extraction using StreamReader and StreamWriter.

However, storing only snippets is often insufficient, as understanding the code requires a broader context.
I think it's better to use `git diff > my_changes.patch` and store the patch.

Besides in some cases, a short description of each library is even sufficient. That's why I make brief notes for each library. Such files can be stored in a separate repository or in a repository dedicated exclusively to snippets.


My template `lib.ps1` currently looks like this :

```powershell
Set-Content -Path ".\scratch.md" -Value @"
git:
used by:
idea:
"@
```

So, if you maintain a directory with brief library descriptions,
source code with comments preserved by git patch,
plus additional test cases, then that's just the ticket.


I have to switch between different languages, so it's important for me to leave notes if I can. Otherwise, I might forget what I was doing, the name of the package I need, or any other useful information.