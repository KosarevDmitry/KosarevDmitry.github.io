---
title: Tailwindcss
date: 2025-05-08 21:36:11 +0200
categories: [nodejs]
tags: []
---

The tailwindcss repo is  a `rust project` because the repo contains `toml` file in  the root folder.  
Cargo aka config  directs  to `members = ["crates/*"]`.  

**Crates**  
  *  `./node` contains napi-template. `napi` compiles a nodejs addon from `rust` src.
  * `node` crate  has dependency to `oxide` crate. 
  * `oxide` depends on `ignore` and `classification-macros`  crates.

So `oxide` obviously is main crate. 

`yarn build` produces npm package with addon whose name depends on OS. 

If to look at [https://github.com/napi-rs](<https://github.com/napi-rs/napi-rs?tab=readme-ov-file>) you will see that the `.\crates\node` has similar properties.
napi has [napi-rs package-template](<https://github.com/napi-rs/package-template>) for addon creation. To check, try creating a project as described in `readme.md`.

After `clone` and `yarn install` run `npx napi rename --help`. You will see that the command add the following :
  - package name
  - addon name
  - repo url 
  - descrpiption 

`.\npm` contains npm package configs for several OS.
 
Before building you need to add package `yarn add @napi-rs/package-template`, then  to execute `yarn build`. A file with  extension `.node`
,for instance `myaddonwin32-x64-msvc.node`, will appear in the root directory. It is your addon.  
Run `yarn test` just in case.

I have node project with tailwind package.  
When I install `tailwindcss` package, yarn/npm installes the package type that fits my OS. `tailwindcss-oxide.win32-x64-msvc.node` in my case.  
The `.\node_modules\@tailwindcss\oxide\index.js` loads addon `./tailwindcss-oxide.win32-x64-msvc.node`  

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

**Conclusion**  
To understand properly how tailwindcss works you need to understand Rust code.