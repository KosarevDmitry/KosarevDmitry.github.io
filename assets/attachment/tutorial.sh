# https://jekyllrb.com/docs/step-by-step/01-setup/
#inside the site root folder

# Gemfile is a equivalent of package.json for Ruby

bundle init # to create Gemfile
echo gem \"jekyll\" >> Gemfile   # add Jekyll package

# Bundler is a gem that installs all gems in your Gemfile.
# https://bundler.io/v2.4/man/bundle-install.1.html

bundle install   #   to fetch. Gemfile.lock file will be created in current src dir.

bundle info jekyll # check version and  path installation just in case


mkdir _layouts # && cd "$_"
# about syntax {{page.title}} see https://shopify.github.io/liquid/basics/introduction/

cat > $_/default.html << EOF
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>{{page.title}}</title>
   <link rel="stylesheet" href="/assets/css/styles.css">
  </head>
  <body>
    {% include navigation.html %}
    {{ content }}
  </body>
</html>

EOF


#   {{ content }} is replaced with the page content
cat >index.html<< EOF
---
layout: default
title: Home
---
<h1>{{ "Hello World!" | downcase }}</h1>

EOF


cat >about.html<< EOF
---
layout: default
title: About
---
# About page  
This page tells you a little bit about me.

EOF


mkdir _data
cat> $_/navigation.yml << EOF
- name: Home
  link: /
- name: About
  link: /about.html

EOF



# site.data.navigation is collection of sections in  _data/navigation.yml   nav section in target page
mkdir _includes 
cat> $_/navigation.html << EOF
<nav>
  {% for item in site.data.navigation %}
    <a href="{{ item.link }}" {% if page.url == item.link %}class="current"{% endif %}>
      {{ item.name }}
    </a>
  {% endfor %}
</nav>

EOF


# 'bundle exec' to make sure you use the jekyll version defined in your Gemfile.
#  The following folders will be created: /.jekyll-cache and /_site
bundle exec jekyll serve --livereload --open-url http://localhost:4000/


# to add styles
mkdir _sass
cat >$_/main.scss << EOF
.current {
  color: green;
}
EOF


# to import _sass/main.scss
mkdir -p assets/css/ && touch $_/styles.scss && 
cat> $_ << EOF
---
---
@import "main";
EOF

# --- to make posts--------
# path  2018/08/20/bananas.html
mkdir _posts 
cat> $_/2018-08-20-bananas.md  << EOF
---
layout: post
author: jill
---
A banana is an edible fruit – botanically a berry – produced by several
kinds of large herbaceous flowering plants in the genus Musa.
EOF


cat> _layouts/post.html << EOF
---
layout: default
---
<h1>{{ page.title }}</h1>
<p>{{ page.date | date_to_string }} - {{ page.author }}</p>

{{ content }}
EOF


# post listing
# site.posts  is collection of  page from `_post` folder  
# post.excerpt displays markdawn first paragraph 
cat> ./blog.html << EOF
---
layout: default
title: Blog
---
<h1>Latest Posts</h1>

<ul>
  {% for post in site.posts %}
    <li>
      <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>
EOF

# to add link to blog
echo -e "- name: Blog \n  link: /blog.html" >> _data/navigation.yml


cat>./_posts/2018-08-21-apples.md <<EOF
---
layout: post
author: jill
---
About apple
EOF

cat> ./_posts/2018-08-22-kiwifruit.md <<EOF
---
layout: post
author: ted
---
About  kiwifruit
EOF

# dir _authors will be available as  {{site.authors}}
# url /authors/jill.html
mkdir _authors 
cat> _authors/jill.md << EOF
---
short_name: jill
name: Jill Smith
position: Chief Editor
---
Jill is an avid fruit grower based in the south of France.
EOF

 # authors/ted.html
cat> _authors/ted.md << EOF
---
short_name: ted
name: Ted Doe
position: Writer
---
Ted has been eating fruit since he was baby.
EOF

# for any folders beside `_post` is required explicit setting to display them.
cat> _config.yml<<EOF
collections:
  authors:
   output: true
EOF

# for operaiton with  _config, the restart is required
# any time you update _config.yml you’ll need to restart Jekyll for the changes to take effect.
# to terminate session `Ctrl+c`


# need markdownify command
cat> staff.html <<EOF
---
layout: default
title: Staff
---
<h1>Staff</h1>

<ul>
  {% for author in site.authors %}
    <li>
      <h2><a href="{{ author.url }}">{{ author.name }}</a></h2>
      <h3>{{ author.position }}</h3>
      <p>{{ author.content | markdownify }}</p>
    </li>
  {% endfor %}
</ul>
EOF


echo -e "- name: Staff \n  link: /staff.html" >> _data/navigation.yml


cat> _layouts/author.html <<EOF
     layout: default
     ---
     <h1>{{ page.name }}</h1>
     <h2>{{ page.position }}</h2>

     {{ content }}
EOF

#Add defaults layouts for target directories
cat>>_config.yml <<EOF
defaults:
  - scope:
      path: ""
      type: "authors"
    values:
      layout: "author"
  - scope:
      path: ""
      type: "posts"
    values:
      layout: "post"
  - scope:
      path: ""
    values:
      layout: "default"

EOF
# https://shopify.github.io/liquid/tags/variable/
# https://shopify.github.io/liquid/filters/where/
cat> _layouts/author.html <<EOF
---
layout: default
---
<h1>{{ page.name }}</h1>
<h2>{{ page.position }}</h2>

{{ content }}

<h2>Posts</h2>
<ul>
  {% assign filtered_posts = site.posts | where: 'author', page.short_name %}
  {% for post in filtered_posts %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
EOF

# update
cat> _layouts/post.html << EOF
---
layout: default
---
<h1>{{ page.title }}</h1>

<p>
  {{ page.date | date_to_string }}
  {% assign author = site.authors | where: 'short_name', page.author | first %}
  {% if author %}
    - <a href="{{ author.url }}">{{ author.name }}</a>
  {% endif %}
</p>

{{ content }}
EOF

bundle exec jekyll serve --livereload --open-url http://localhost:4000/
