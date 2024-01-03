#!/usr/bin/env bash

F=$(date +"%F|%T|%z")
d=$(echo $F | cut -d'|' -f 1) # date
t=$(echo $F | cut -d'|' -f 2) # time
z=$(echo $F | cut -d'|' -f 3) # timezone
name=$d-${1// /-}.md # $1 -first arg replace whitespace tp '-'

# tags: [authorisation]     # TAG names should always be lowercase
# categories: [Csharp, microservise] are designed to contain up to two elements
# img_path: /img/path/
# 1200 x 630
# image:
#  path: /path/to/image
#  alt: image alternative text
# or
# image: /path/to/image

md='../_posts/'$name
if [[ ${PWD##*/} = "KosarevDmitry.github.io" ]]; then
md='./_posts/'$name
fi 

cat >$md <<EOF
---
title: $1
date: $d $t $z
categories: [${2}]
tags: [${3}]
---
EOF

notepad $md