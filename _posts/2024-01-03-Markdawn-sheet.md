---
title: Markdawn cheat sheet
date: 2024-01-03 22:49:27 +0100
categories: [blog]
tags: [style]
---
# Markdown Cheat Sheet

[comment]: <> (This is a comment, it will not be included)
[comment]: <> (in  the output file unless you use it in)
[comment]: <> (a reference style link.)

[//]: <> (This is also a comment.)
[//]: # (This is also a comment.)

<!---
your comment goes here
and here
-->
```
<!---your comment goes here and here -->
```



relative link
@github/ reference


[!NOTE]
> [!TIP]
> [!IMPORTANT]
> [!WARNING]
> [!CAUTION]

{% comment %} 
    These commments will not include inside the source.
{% endcomment %}

```
{% comment %}
    These commments will not include inside the source.
{% endcomment %}
```

{::comment}
This text is completely ignored by kramdown - a comment in the text.
{:/comment}

```
{::comment}
This text is completely ignored by kramdown - a comment in the text.
{:/comment}
```



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


```
1. First item
2. Second item
```

- First item
- Second item


```
- First item
- Second item
```

`code`  \`code\`  

### Horizontal Rule

--- 
`---`
### Link

[Markdown Guide](https://www.markdownguide.org)  
\[Markdown Guide\](`https://www.markdownguide.org`)  

### Image

![alt text](https://www.markdownguide.org/assets/images/tux.png)  
`![alt text](https://www.markdownguide.org/assets/images/tux.png)`

### Table

| Syntax | Description |
| ----------- | ----------- |
| Header | Title |
| Paragraph | Text |

```markdown
| Syntax | Description |
| ----------- | ----------- |
| Header | Title |
| Paragraph | Text |

```
### Fenced Code Block
https://github.com/github-linguist/linguist/blob/master/lib/linguist/languages.yml

```
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
```

```markdawn
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}

``` ```

### Footnote

Here's a sentence with a footnote. [^1]

[^1]: This is the footnote.  `[^1]: This is the footnote.`

```markdown
term
: definition
```

term
: definition

### Strikethrough

~~The world is flat.~~  `~~The world is flat.~~`

### Task List

- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media

```markdown

- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media
```
### Emoji

:joy:  `:joy: ` (See also [Copying and Pasting Emoji](https://www.markdownguide.org/extended-syntax/#copying-and-pasting-emoji))

### Highlight  

I need to highlight these ==very important words==.


[mylink]

## Details

<details>
  <summary>Click to expand/close details</summary>
  &nbsp;

1. Item1 
2. Item2

</details>

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