---
title: C# vs Typescript
date: 2025-12-06 10:36:07 +0100
categories: [typescript]
tags: [typescript]
---


```csharp
int? prop;
```

```ts
prop?:int|undefined
```
---

```csharp
interface IB: IA{
}
```

```ts
interface IB extends IA{
}
```

---

```csharp
class boo{}
class baz{}
boo  Foo(baz a)
```

```ts
Foo(a:baz):boo
```

---

```csharp
class HttpClient{
 HttpClient(){}
}
```

```ts
class HttpClient{
   constructor(){}
}
```

---

```csharp
  
	dynamic data = new ExpandoObject();
    data.rid = "Alice";
    data.age = 30;
    data.uid = 30;
    Console.WriteLine(data.rid);

```

```csharp
var data = (rid:"Alice",uid:123 );
Console.WriteLine(data.rid);
```

```ts
 let data:object=  { "rid": this.rid,   "age": this.sid,  "uid": this.uid};
```
---

```ts
enum direction{
left,
right
}

direction: "left" | "right"
let s = "right";
direction= s;  //error
let s1= "left" | "right"
direction= s1; //ok
```

---

```csharp 
interface IHasName {
string name {get;set;}
}
interface IHasAge {
int age {get;set;}
 }

class Person () :  IHasName,  IHasAge
{ 
    public int age {get; set;}
   public string name {get;set;}  
	
	Person (string name, int age){
	  this.age=age;
	  this.name=name;
	  }
}

Person person = new(John",30);
```

```ts
type HasName = { name: string };
type HasAge = { age: number };

type Person = HasName & HasAge;

const person: Person = {
    name: "John",
    age: 30
}; // Valid
``` 

---

```csharp
  var impl= new Impl();
var i= impl.Parse((o) =>
{
    o.Inference = "INSERT STATE HERE";
});

Console.ReadKey();

interface IDammy {
string? Inference { get; set; }
}

class Dammy:IDammy {
  
    public string? Inference { get; set; }
}


delegate Idammy Run<Idammy>(Action<Idammy> arg);

class Impl {

  public Run<IDammy> Parse; 
    public Impl() {
        if (DateTime.Now.Hour < 12)
        {
             Parse = Baz;
        }
        else 
        { 
             Parse = Foo;
        }
    }

    
 private Dammy Baz(Action<Dammy> action)
    {
        Dammy dummy = new();
        action.Invoke(dummy);
        dummy.Inference += " 1";
        return dummy;
        
    }

   
 private Dammy Foo(Action<Dammy> action)
    {
        Dammy dummy = new();
        action.Invoke(dummy);
        dummy.Inference += " 2";
        return dummy;
        
    }
    
}

```

```ts
declare function run<T>(thunk: (t: T) => void): T;
let i: { inference: string } = run((o) => {
  o.inference = "INSERT STATE HERE";
});
```

---

```ts
Record<string, string>[]
```

```csharp
KeyValuePair<string, string>[]
```


---

```ts
export function generateImageMetadata({
  params,
}: {
  params: { slug: string }
}) {
  // ...
}
```

```csharp
interface Params{
string slug{ get;set;}
}
class A {
public generateImageMetadata(Params params){
} 
```
