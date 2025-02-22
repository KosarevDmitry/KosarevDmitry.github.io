---
title: Code sample
date: 2022-12-29 16:44:03 +0100
categories: [sql]
tags: [easy-to-understand]
---
If you have access to the repo and to the documentation in particular, it becomes possible
pull out the piece of information that is currently of interest in an easy-to-read form.
As a user, I am mostly interested in sql documentation, and like in any other documentation, in fact, only the code. If the code is not obvious, then you can already look for comments and look at the entire page. That is, first the code, the test, then the words, posts and so on.

You can extract sql blocks this way, for example

```csharp
    [Theory]
    [InlineData(@"D:\src\sql\sql-docs\docs\t-sql\functions", "", @"D:\temp\t-sql-functions.sql")]
    [InlineData(@"D:\src\sql\sql-docs\docs\t-sql\statements", "plan", @"D:\temp\statements.sql")]
    public void GetScripts(string src, string filter, string output)
    {
        var items = Directory.EnumerateFiles(src);
        if (!string.IsNullOrWhiteSpace(filter)){
            items = items.Where(x => Path.GetFileName(x).Contains(filter));
        }

        try{
            using (StreamWriter sw = new StreamWriter(output)){
                sw.AutoFlush = true;
                sw.WriteLine($"--  src: {src}");
                Parallel.ForEach(items, (q) => Parse(q, sw));
            }
        }
        catch (Exception ex){
            Assert.Fail(ex.Message);
        }
    }


    void Parse(string item, StreamWriter sw)
    {
        string line;
        bool flag = false;
        StringBuilder bld = new();
        int count = 0;

        using (StreamReader sr = new StreamReader(item)){
            while (sr.Peek() >= 0){
                count++;
                line = sr.ReadLine();
                if (line.TrimStart().StartsWith("```")){
                    if (flag == false){
                        bld.AppendLine("--" + Path.GetFileName(item) + " line: " + count);
                    }
                    else{
                        bld.AppendLine();
                    }

                    flag = !flag;
                    continue;
                }

                if (flag){
                    bld.AppendLine(line);
                }
            }
        }

        sw.WriteLine(bld.ToString());
    }
```
