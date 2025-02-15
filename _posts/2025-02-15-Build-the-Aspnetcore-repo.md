---
title: Build the Aspnetcore repo
date: 2025-02-15 19:07:20 +0100
categories: [aspnetcore]
tags: [tools]
---

Usually the assembly goes well.

I  build by `.\eng\build.cmd -all -pack -arch x64` though  if to check `build.ps1` appears that `x64` is the default option.
More often  I  use `build.cmd` instances that are located in "\src". I add comments or tests for myself so I do it regularly.

You can always to clear `\artifacts` and will try to build again.
The order of compilation to `artifacts` due to the implementation of 
ArcadeSdk (https://github.com/dotnet/arcade/blob/main/Documentation/ArcadeSdk.md)

Recently I received a error. 

```console
D:\src\aspnetcore\eng\targets\Java.Common.targets(54,5): error MSB3073:   
The command "../gradlew  compileJava" exited with code 1.  
[D:\src\aspnetcore\src\SignalR\clients\java\signalr\core\signalr.client.java.core.javaproj]  
```

After careful viewing of `\docs\BuildFromSource.md` I noticed  `.\eng\scripts\InstallJdk.ps1`.    
After executing `InstallJdk.ps1`,  `D:\src\aspnetcore\src\SignalR\build.cmd` worked successfuly.
  
I decided to check `global.json` version by  `git log -p global.json > temp.txt`

It turned out that the `jdk` version has not been updated, it is the same since 2019 year. 
Valid version is "jdk": "11.0.3".
So the reason is not a change in the version used during assembly.
Looked further.

The script checks if "D:\src\aspnetcore\.tools\jdk\win-x64\bin\javac.exe" exists.
If file does not exist, so script will download  "https://netcorenativeassets.blob.core.windows.net/resource-packages/external/windows/java/jdk-${JdkVersion}_windows-x64_bin.zip" "$tempDir/jdk.zip"
and unzip the archive  to  D:\src\aspnetcore\.tools\jdk\win-x64\bin

`\.tools` is included  in `.gitignore`. 
I didn't understand why I was getting this error because I didn't seem to delete the `\.tools` content.
 
When the build failed, I got a message.

```console
PS D:\src\aspnetcore\src\SignalR> .\build.cmd
Detected JDK in C:\Program Files\Java\jdk-21 (via JAVA_HOME)
 ```
That's correct.

```console
PS D:\src\aspnetcore> echo $env:JAVA_HOME
C:\Program Files\Java\jdk-21
 ```

From the script logic it is clear that the message  is a sign  that `.\tools` jdk is not installed
but despite this the build will continue with version from `program files`. 

I have updated  `Java` a couple of months ago. 
So it means that previous version was compatible with 11.0.3,  v21.0.1 is not.

