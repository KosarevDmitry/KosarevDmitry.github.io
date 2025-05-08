---
title: Tailwindcss
date: 2025-05-08 21:36:11 +0200
categories: [nodejs]
tags: []
---

The tailwindcss repo is  a `rust project` becouse the repo contains `toml` file in  the root folder.  
Cargo aka config  directs  to `members = ["crates/*"]`.  

- Crates
  *  `node` dir contains napi-template. `napi` compiles a nodejs addon from `rust` src.
  * `node` crate has dependency `oxide` crate.
  * `oxide` depends from `ignore` crate and `classification-macros`  crate.

A compilation produces npm package with addon, the name depends from OS. 

If to look at `https://github.com/napi-rs/napi-rs?tab=readme-ov-file` you will see that the `.\crates\node` has similar properties.

`https://github.com/napi-rs/package-template` is a template for addon creation. To check, try creating a project as described in `Readme.md`.

After `clone` and `yarn install` run `npx napi rename --help`. You will see that the command add the following :
  - package name
  - addon name
  - repo url 
  - descrpiption 

`.\npm` contains npm package configs for several OS.
 
Before building you need to run `yarn add @napi-rs/package-template`, then run `yarn build` and `yarn test` just in case. `myaddonwin32-x64-msvc.node` will appear in the root directory. It is your addon.  

When I install `tailwindcss` package, yarn/npm  installes the package type that fits my OS. `tailwindcss-oxide.win32-x64-msvc.node` in my case.  

I have node project  with tailwind package.  

The `.\node_modules\@tailwindcss\oxide\index.js`  loads addon `./tailwindcss-oxide.win32-x64-msvc.node`  

 ```js
 if (process.arch === 'x64') {
      try {
        return require('./tailwindcss-oxide.win32-x64-msvc.node')
      } catch (e) {
        loadErrors.push(e)
      }
      try {
        return require('@tailwindcss/oxide-win32-x64-msvc')
      } catch (e) {
        loadErrors.push(e)
      }

    }
```
and exports Scanner `module.exports.Scanner = nativeBinding.Scanner`
