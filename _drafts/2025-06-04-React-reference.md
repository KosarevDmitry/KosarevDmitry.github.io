---
title: React reference
date: 2025-06-04 18:06:32 +0200
categories: [React]
tags: []
---

src `react.dev\src\content\reference\react`  
Total files: 46

###  Common

- createElement.md
- Fragment.md 
- StrictMode.md

###  directives.md

- use-client.md
- use-server.md


### Helper

- useId.md  - generation of uniq id

### Memory optimization

- lazy.md   defer loading component’s code 

```jsx
const SomeComponent = lazy(load)
```

### Updation of a state value

- useState.md

- useReducer.md  (the idea is to  invoke a delegate to change the state )

```jsx
import { useReducer } from 'react';

function reducer(state, action) {
  if (action.type === 'incremented_age') {
    return {
      age: state.age + 1
    };
  }
  throw Error('Unknown action.');
}

export default function Counter() {
  const [state, dispatch] = useReducer(reducer, { age: 42 }); // initial state

  return (
    <>
      <button onClick={() => {
        dispatch({ type: 'incremented_age' }) //calls the reducer with action value
      }}>
        Increment age
      </button>
      <p>Hello! You are {state.age}.</p>
    </>
  );
}

```


### Promise handler

- use.md  -resolve Promise like await or Task.GetResult in C#

### Transferring a ref or a parameter

useRef.md

```jsx
function Form() {
  const ref = useRef(null);
  function handleClick() {  ref.current.focus();  }

  return (
    <form>
      <MyInput label="Enter your name:" ref={ref} />
      <button type="button" onClick={handleClick}>
        Edit
      </button>
    </form>
  );
}
```

- useImperativeHandle.md
- createContext.md  
- useContext.md

```jsx
import { createContext, useContext, useState } from 'react';

type Theme = "light" | "dark" | "system";
const ThemeContext = createContext<Theme>("system");
const GetTheme = () => useContext(ThemeContext); // does not need

// 3 ways to call  useContext
function Display() {
    const t = GetTheme(); 
    const  t1=useContext(ThemeContext);
    return (
        <div>
            <h1>Theme</h1>
            <p>Current theme: {t}</p>
            <p>Current theme: {t1}</p>
            <p>Current theme: {useContext(ThemeContext)}</p>

        </div>
    )
}

export default function ThemeSelector() {
    const [theme, setTheme] = useState<Theme>('light');

    return (
        <ThemeContext.Provider value={theme}>
            <Display />
        </ThemeContext.Provider>
    )
}

```

### Caching


- `usememo` skips rendering if any variables that  are dependcies defined in function are not changed

https://medium.com/geekculture/great-confusion-about-react-memoization-methods-react-memo-usememo-usecallback-a10ebdd3a316

- memo.md - Skipping re-rendering when props are unchanged

```jsx
const Greeting = memo(function Greeting({ name }) {
  return <h1>Hello, {name}!</h1>;
});
```

- useMemo.md (run on the client, Skipping re-rendering if dependencies are unchanged)

```jsx
import { useMemo } from 'react';

function TodoList({ todos, tab, theme }) {
  const visibleTodos = useMemo(() => filterTodos(todos, tab), [todos, tab]);
  // ...
}
```

- useCallback.md (in a scenario where a function itself is used as parameter (C# delegate)  useCallback helps to skip rendering)

```jsx
function ProductPage({ productId, referrer, theme }) {
  // Tell React to cache your function between re-renders...
  const handleSubmit = useCallback((orderDetails) => {
    post('/product/' + productId + '/buy', {
      referrer,
      orderDetails,
    });
  }, [productId, referrer]); // ...so as long as these dependencies don't change...

  return (
    <div className={theme}>
      {/* ...ShippingForm will receive the same props and can skip re-rendering */}
      <ShippingForm onSubmit={handleSubmit} />
    </div>
  );
}

```


- cache.md  (server components)

```jsx
import {cache} from 'react';
import calculateMetrics from 'lib/metrics';

const getMetrics = cache(calculateMetrics);

function Chart({data}) {
 // calls calculateMetrics and cache it
  let report = getMetrics(data); 
  // calls cache because the  parameter is the same
  let report1 = getMetrics(data);  
  // ...
}

```

### Fetch helper

- useEffect.md  call function when parameters will be changed

### CSS and layout

useInsertionEffect.md ,  css rule insertion,  run on the client 
useLayoutEffect.md calculation of rendering position, blocks the browser from painting, run on the client


### Rendering optimization

- Suspense.md (display image while loading data )
- useDeferredValue.md (keep stale data while loading of new data)
- useOptimistic.md  (gives the impression of speed and responsiveness)

- startTransition.md (keep the user interface updates responsive)
- useTransition.md

### Debugging

- Profiler.md measure rendering performance in development mode
- useDebugValue.md

### Other
useSyncExternalStore.md

### Overview

- index.md
- apis.md
- hooks.md
- legacy.md

### experemenal
- useEffectEvent.md
- taintObjectReference.md
- taintUniqueValue.md

 
### legacy

- Children.md
- Component.md
- PureComponent.md
- components.md
- cloneElement.md
- createRef.md
- forwardRef.md
- isValidElement.md
- createFactory.md


reference\react-dom\client\createRoot.md
reference\react-dom\client\hydrateRoot.md
reference\react-dom\components\common.md
reference\react-dom\components\form.md
reference\react-dom\components\index.md
reference\react-dom\components\input.md
reference\react-dom\components\option.md
reference\react-dom\components\progress.md
reference\react-dom\components\select.md
reference\react-dom\components\textarea.md
reference\react-dom\createPortal.md
reference\react-dom\findDOMNode.md
reference\react-dom\flushSync.md
reference\react-dom\hooks\useFormState.md
reference\react-dom\hooks\useFormStatus.md
reference\react-dom\hydrate.md
reference\react-dom\render.md
reference\react-dom\server\renderToNodeStream.md
reference\react-dom\server\renderToPipeableStream.md
reference\react-dom\server\renderToReadableStream.md
reference\react-dom\server\renderToStaticMarkup.md
reference\react-dom\server\renderToStaticNodeStream.md
reference\react-dom\server\renderToString.md
reference\react-dom\unmountComponentAtNode.md

