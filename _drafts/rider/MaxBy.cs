var str1= "aaa dd frg rrrr cchh";
var result1 = str.AsEnumerable().GroupBy(x=>x).Select(x=>(x.Key,x.Count())).ToArray();