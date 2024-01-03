# Markdown Cheat Sheet
<div align="center">
align
  [The Markdown Guide](https://www.markdownguide.org)!
</div>
This Markdown cheat sheet.

[comment]: <> (This is a comment, it will not be included)
[comment]: <> (in  the output file unless you use it in)
[comment]: <> (a reference style link.)

[//]: <> (This is also a comment.)
[//]: # (This is also a comment.)

<!---
your comment goes here
and here
-->

{% comment %} 
    These commments will not include inside the source.
{% endcomment %}

{::comment}
This text is completely ignored by kramdown - a comment in the text.
{:/comment}

[](
Your comments go here however you cannot leave
// a blank line so fill blank lines with
//

Something
)


# H1 `#H1`
## H2 `#H2`
### H3 `#H3`

 **bold text** `**bold text**`
*italicized text* `*italicized text*`
> blockquote  `> blockquote`

1. First item
2. Second item
3. Third item

```markdown
1. First item
2. Second item
3. Third item
```

```markdown
- First item
- Second item
- Third item
```

`code`  \`code\`  

### Horizontal Rule
`---`
--- 

### Link
\[Markdown Guide\](`https://www.markdownguide.org`)  
[Markdown Guide](https://www.markdownguide.org)

### Image

`![alt text](https://www.markdownguide.org/assets/images/tux.png)`
![alt text](https://www.markdownguide.org/assets/images/tux.png)


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

```
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
```

### Footnote

Here's a sentence with a footnote. [^1]

[^1]: This is the footnote.

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

:joy:  `:joy:  
`

(See also [Copying and Pasting Emoji](https://www.markdownguide.org/extended-syntax/#copying-and-pasting-emoji))

### Highlight

I need to highlight these ==very important words==.

### Subscript

H~2~O

### Superscript

X^2^


[mylink]

## Details

<details>
  <summary>Click to expand/close details</summary>
  &nbsp;

- Dark / Light Theme Mode
- Localized UI language
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

H<sub>2</sub>O

H<sup>2</sup>O
