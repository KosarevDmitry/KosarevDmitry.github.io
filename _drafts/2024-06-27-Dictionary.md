---
title: Dictionary
date: 2024-06-27 15:59:54 +0200
categories: [algorithm]
tags: []
---
Briefly about Dictionary
the code always creates a hash for quick comparison
if two different entities receive the same hash
then this is a collision, you need to compare all records with this hash and find the one that completely matches

## addition
if there are already records with this hash,
then the code goes through a chain of related records (Nodes) with the same hash
and saves it at the end. This makes it easier to find the entry.

## Search
When searching, it always compares hash and actual  entry identities using Object.ReferenceEquals
Object.Equals
If they are not identical, it searches the chain for all other records with the same hash.