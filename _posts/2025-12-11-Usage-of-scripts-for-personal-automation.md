---
title: Usage of scripts for personal automation
date: 2025-12-11 14:55:8 +0100
categories: [automation]
tags: [automation, powershell]
---

If you search for a template for a Git command and ask "how to do this...," you'll get an answer describing a script command.
But you prefer to run operations in an IDE, such as the standalone Git Extensions app or a developer IDE. This is fairly obvious. This creates a disconnect between the familiarity of pressing a button to perform an action and the natural approach of using scripts.
Moreover, you're forced to use multiple IDEs. While this isn't too bad, perhaps it doesn't matter to you, I don't know. But if you track the time it takes to run a command, I'm sure it would be a bit longer if you only used one IDE. As the saying goes, "life is brief, time flies by unnoticed".
Recently, I discovered a different approach. I now run many operations using PowerShell scripts, although I don't insist on using PowerShell.
I added the directory containing the scripts to the `Path` environment variable. I understand this isn't always possible if you don't have sufficient administrative rights on your computer, but netherless for sure there is  another suite ways to invoke script.
I store various scripts there.

Names for git scripts can looks like 

```
a-git-merge-dry.ps1
a-git-reset-1.ps1  
a-git-commit-push.ps1
```


I add a prefix to the command just in case the script's name accidentally overlaps with other commands, because I first added the address of this folder to the Path environment variable.

I open the PowerShell console via the context menu and then enter the script's name without the extension.

Today, for example, I discovered that PowerShell has a command called 'ConvertFrom-Markdown',
so I created the following script:

```powershell
Param(
  [string][Alias('n')]$name,
  [switch][Alias('h')]$help
  )

function Get-Help() {
  Write-Host "Parameters:"
  Write-Host " -name(-n)   name of markdown file"
  Write-Host " -help(-h)   print help"
  Write-Host "  example:     '-n CV'  CV.md file located in the current directory will be compiled into CV.html"
exit 0
}

if ($help){
	Get-Help	
}
  
$o= ConvertFrom-Markdown -Path .\$name.md
Set-Content -Path ".\\$name.html" -Value $o.Html
Write-Host "Completed" -ForegroundColor Green
```

It suits me more than usage of explorer, links, taskbar and IDE. 
I've created scripts before but mostly for professional purposes.
It had never occurred to me before that scripts could be used in this way: even for opening a directory or file, etc.
A significant role was played by the fact that I started adding them to `Path`
In other words, I saw the light at the end of the tunnel.
