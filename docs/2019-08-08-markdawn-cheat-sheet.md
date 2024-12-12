---
title: Markdawn cheat sheet
date: 2024-01-03 22:49:27 +0100
categories: [blog]
tags: [style]
---
# Markdown Cheat Sheet

<!--- comment -->

[comment]: comment

[//]:  comment

{% comment %} 
    These commments will not include inside the source.
{% endcomment %}

{::comment}
ignored by kramdown
{:/comment}


relative link
@github/ reference


[!NOTE]
[!TIP] fggf  
> [!IMPORTANT]
> [!WARNING]
> [!CAUTION]


# H1 `#H1` 
## H2 `#H2` 
### H3 `#H3`
### H4 `#H4`
### H5 `#H5`
### H6 `#H6`

 **bold text** `**bold text**`  
*italicized text* `*italicized text*`
> blockquote  `> blockquote`

1. First item
2. Second item


```markdawn
1. First item
2. Second item
```

- First item   
* Second item 
+ Third item 


```
- First item   
* Second item 
+ Third item 
```

`code`  \`code\`  


--- 
`---`


[Markdown Guide](https://www.markdownguide.org)  

```markdawn
[Markdown Guide](https://www.markdownguide.org)  
```


![alt text](https://www.markdownguide.org/assets/images/tux.png)  
```markdawn
![alt text](https://www.markdownguide.org/assets/images/tux.png)
```


| Syntax | Description |
| - | -|
|Header | Title 
|Paragraph | Text 

```markdown
| Syntax | Description |
| - | -|
|Header | Title 
|Paragraph | Text 
```


Code block <https://github.com/github-linguist/linguist/blob/master/lib/linguist/languages.yml>


{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}

```
{  
  "firstName": "John",  
  "lastName": "Smith",  
  "age": 25  
}  
```


Sentence with a footnote. [^1]

[^1]: This is the footnote.  `[^1]: This is the footnote.`


term  
: definition

```
term
: definition
```


~~The world is flat.~~  `~~The world is flat.~~`


- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media
  + [x] two space
	
	
```
- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media
  + [x] two space

```

### Emoji

 :joy:   
 `:joy: ` (See also [Copying and Pasting Emoji](https://www.markdownguide.org/extended-syntax/#copying-and-pasting-emoji))



[mylink]

```
[mylink]
```


ссылки на md файлы в nodejs repo
[`process.stderr`][]

внизу страницы обозначаю ссылки
[`console.error()`]: #consoleerrordata-args
[`process.stderr`]: process.md#processstderr
[falsy]: https://developer.mozilla.org/en-US/docs/Glossary/Falsy
[inspector]: debugger.md
[truthy]: https://developer.mozilla.org/en-US/docs/Glossary/Truthy


[link to repo dir](repolink) 

## Details

<details>
  <summary>Click to expand/close details</summary>
  &nbsp;

1. Item1 
2. Item2

</details>


<details><summary> a </summary><blockquote>

<details><summary> b </summary>
text
text 

</details>
</blockquote></details>


```markdown
<details>
  <summary>Click to expand/close details</summary>
  &nbsp;

- Dark / Light Theme Mode
- Localized UI language
</details>
```

[mylink]:https://github.com/KosarevDmitry/topics/edit/main/markdown


clickable image  
[![deploy](https://github.com/alshedivat/al-folio/actions/workflows/deploy.yml/badge.svg)](https://github.com/alshedivat/al-folio/actions/workflows/deploy.yml)

`[![deploy](https://github.com/alshedivat/al-folio/actions/workflows/deploy.yml/badge.svg)](https://github.com/alshedivat/al-folio/actions/workflows/deploy.yml)`

H<sub>2</sub>O  `H<sub>2</sub>O`

H<sup>2</sup>O  `H<sup>2</sup>O`

<https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/writing-mathematical-expressions>