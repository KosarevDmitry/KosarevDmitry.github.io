Add code to Nodejs template post

add to lib/package.json
```
{
 "type": "commonjs",
  "main": "index.js"
}
```
add ./test.js
```
import o from "./lib/index.js";
var f  = o;
f.default();
debugger
```