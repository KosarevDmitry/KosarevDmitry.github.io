---
title: Template to test Reactjs
date: 2025-02-14 16:45:16 +0100
categories: [node]
tags: [react]
---

It would be easier for me if the reactjs  explained from the very beginning how to figure it out myself, but usually it doesn't happen that way. That's how the world of programmers works.
They probably assume that everyone already knows nodejs, webpack, babel. All I don't know is react.js.

Maybe I'm exaggerating but before dealing with react.js , you need to look at the nodejs documentation, and  even better the repo, it will be clearer, then the webpack and babel documentation.
`Node_modules` is huge, first a lot of code is executed before it gets to `React` - first auxiliary packages, then babel, webpack.
in addition, the file is not compiled into a file, but into memory. And the webpack packed   bunch of files  into one.

Аutomation is good when you more or less understand everything.

And this script will add a project for you with which you can already experiment with converting from `jsx` to `js`. You can test `js`  without going deep into `node_modules`, by added  brakepoints to
`\distr\react.development.js.`
 
Every time you run `npx babel` you will get new `js`.

> Maybe there is no point in looking at `jsx` transformation because everyone uses `typescript`, including developers of `react.dev`. All components are `tsx`: <https://github.com/reactjs/react.dev/tree/main/src/components>

<script src="https://gist.github.com/KosarevDmitry/304c0dc65000d262764db4899f6762c1.js"></script>