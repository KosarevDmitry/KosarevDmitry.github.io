---
title: What is programming?
date: 2024-01-07 11:02:19 +0100
categories: [programming]
tags: [reasoning]
---


Так случилось что новый samsung телевизор не понимает avi файлов страрый в Москве понимал, а местный лучше более плоский и прочее отказывается кино крутить. Это кстати тоже про программирование
что можно сделать? Перепрошить, "затолкнуть" в телевизор программу. Не хочется это опять маета искать в интернете как это делать и затаив дыхание жать на кнопки прилаживать какой-то неизвестный софт. Не хочу даже пытаться.
Лучше конвертировать. Первая реакция - скачать программу. Делал уже но очень давно.
Попробовал VLC сначала, что-то долго получается, медленно конвертирует. Поискал. Лицензионный софт плати, ломаный ставить не хочется.  Вы скажете да их же полно.  А время то идет. 
Определился использую ffmpeg.exe. Есть подозрение что половина программ работает на этом "движке".
Все, запускается отлично. Погонял. 
то что мне нужно 

```bash
f="Murder She Wrote 1x10 Capitol Offense.avi"
ffmpeg -i "$f" -c:v copy -c:a copy "${f}.mp4" 
```

Но мне нужно несколько сезонов сериала переформатировать,
и cледовательно лучше запустить в цикле.

```bash
#!/bin/bash

for f in *; do

 ffmpeg -i "$f" -c:v copy -c:a copy "${f}.mp4" 

done
```

лучше чтобы итоговый файл назывался не bar.avi.mp4 а bar.mp4 
и в цикле отбирать только файлы которые с `.avi` extension. Что то в этом роде.
```
#!/bin/bash

for f in *; do

# if [  "$f" ]; then
 ffmpeg -i "$f" -c:v copy -c:a copy "${f}.mp4" 
 fi
 done
``` 
Опций манипуляций со строкой не помню. Следовательно нужно искать в интернете либо "родной" мануал bash смотреть.  
Дай, думаю, запущу C#  Proccess 

```csharp
[Fact]
    private void Test()
    {
        var dir = @"D:\Videos\Murder, She Wrote\MSW_Season_1";
        var files = Directory.EnumerateFiles(dir).Where(x => x.EndsWith(".avi")).Select(x => Path.GetFileName(x));
        var f1 = files.FirstOrDefault(); // побровать на одном
        var f = f1.Substring(0, f1.LastIndexOf('.'));
        try{
            ProcessStartInfo info = new();
            info.UseShellExecute = true;
            info.WorkingDirectory = @"D:\Videos\Murder, She Wrote\MSW_Season_1";
            info.FileName = "ffmpeg.exe";
            info.Arguments = $"-i '{f1}' -c:v copy -c:a copy '{f}.mp4'";
            info.CreateNoWindow = false;
            Process.Start(info);
        }
        catch (Exception e){
            Console.WriteLine(e);
            throw;
        }
}
```

Запускаю в debugger результата нет - тишина. И ошибки тоже нет - в `catch` не заходит.
10 лет назад у меня была бы реакция, что то не так с машиной, VS не тот,  dotnet не той версии. И вообще руки кривые. 
Раньше  все заканчивалось вычитыванием reference и поиском примеров и советов "бывалых".
Теперь у нас есть возможность посмотреть код runtime: опция "Debug external source" в Rider  и соответсвующая опция в VS.

После разных проверок на null код добирается до "исполнителя" 

```csharp
 internal static class Shell32
  {
    [LibraryImport("shell32.dll", SetLastError = true)]
    [GeneratedCode("Microsoft.Interop.LibraryImportGenerator", "8.0.9.3103")]
    [return: MarshalAs(UnmanagedType.Bool)]
    internal static unsafe bool ShellExecuteExW(Interop.Shell32.SHELLEXECUTEINFO* pExecInfo)
    {
      Marshal.SetLastSystemError(0);
      int num = __PInvoke(pExecInfo);
      int lastSystemError = Marshal.GetLastSystemError();
      bool flag = num != 0;
      Marshal.SetLastPInvokeError(lastSystemError);
      return flag; 

      [DllImport("shell32.dll", EntryPoint = "ShellExecuteExW")]
      static extern unsafe int __PInvoke(
        Interop.Shell32.SHELLEXECUTEINFO* __pExecInfo_native);
    }
```
 
В принципе можно разобраться поверхностно, почитав reference .  Именно поверхностно, потому что чтобы эта функция wrapper  стала естественной мне нужно ее оттестировать разных сторон, иметь опыт обращения из С. 
 Да и дело не в этом,  главное что он не работает для моего кейса. 
В Visual Basic я это то же делал вызов из модулей библиотек без особого понимания. 

а если их нет то остается только гонять Linq stringbuilder List и рассуждать о том что timecomplexity  of hashset лучше чем что либо другое.


 


