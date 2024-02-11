---
title: Bash script for Chirpy Jekill post template
date: 2024-02-11 11:42:47 +0100
categories: [bash]
tags: [Jekyll]
---


There is a principle of shifting work to others " __Let someone else do the hard part__" but faithful adherence to this principle creates new dependencies.  
There is a ruby gem to generate post template.  
But I prefer to do it myself, although this often doesn’t justify it.  
if the script had been written in `powershell` or `nodejs` it would have been clearer, but I wanted to write it in `bash`.  

```bash
#!/usr/bin/env bash
title=${1^} # $1 - title has to start with uppercase
F=$(date +"%F|%T|%z")
d=$(echo $F | cut -d'|' -f 1) # date
t=$(echo $F | cut -d'|' -f 2) # time
z=$(echo $F | cut -d'|' -f 3) # timezone
name=$d-${title// /-}.md #  replaces whitespace with underscore in title

md='../_posts/'$name
if [[ ${PWD##*/} = "KosarevDmitry.github.io" ]]; then
md='./_drafts/'$name
fi 

cat >$md <<EOF
---
title: ${1^}
date: $d $t $z
categories: [${2}]
tags: [${3}]
---
EOF

notepad $md

#use ./post.sh mytitle categorie1,categorie2 mytag

# Legend
# tags: [authorisation] # tags names should always be lowercase
# categories: [Csharp, microservise] are designed to contain up to two elements

```