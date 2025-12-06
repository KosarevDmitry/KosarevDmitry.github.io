---
title: Task base syntax
date: 2025-12-06 14:21:02 +0100
categories: [C#]
tags: []
---

```csharp

/*
 LOCK
As a basic rule, you need to lock around accessing any writable shared field. Even in the simplest case—an assignment
operation on a single field—you must consider synchronization. In the following class, neither the Increment nor the
    Assign method is thread-safe:

*/
class ThreadUnsafe
{
static int _x;
static void Increment() { _x++; }
static void Assign() { _x = 123; }
}

public class TaskSyntax
{
    public Task Return_task()=> Task.CompletedTask;
    public async Task Return_task_async() =>   await Task.Yield();
    public Task<int> Return_value()=> Task.FromResult(1);
    
  public async Task<int> Return_value_async()
    {
		// needs at least single method with await
        await Task.Yield();   
        return 1;
    }
    
    public async Task Do_waitAll()
    {
        Task t = new Task(()=> Console.WriteLine(1));
        Task t1 = new Task(()=> Console.WriteLine(1));
        Task.WaitAll(t,t1);
        await Task.Yield();
     
    }

    
    public  void Loop_with_var_capture()
    {
        List<Task> list = new List<Task>();
        for (int i = 0; i < 10; i++)
        {
            int j = i;  // capture is nessesary
            list.Add(Task.Factory.StartNew(()=> Console.WriteLine(j)));
        }
        
        // overwise process in main  will be finished before the console prints lines 
        Task.WaitAll(list.ToArray(),100);
    }

    public void TaskCreationOptions_usage()
    {
       
        Task t1 = new Task(()=> Console.WriteLine(1), TaskCreationOptions.RunContinuationsAsynchronously);
        Task t2 = new Task(()=> Console.WriteLine(1), TaskCreationOptions.AttachedToParent);
        Task t3 = new Task(()=> Console.WriteLine(1), TaskCreationOptions.DenyChildAttach);
        //https://devblogs.microsoft.com/pfxteam/taskcreationoptions-preferfairness/
        Task t4 = new Task(()=> Console.WriteLine(1), TaskCreationOptions.PreferFairness);
        Task t5 = new Task(()=> Console.WriteLine(1), TaskCreationOptions.HideScheduler);
        
    // Example of TaskCreationOptions.LongRunning usage
    /*     
     protected internal override void QueueTask(Task task)
     {
         if ((task.Options & TaskCreationOptions.LongRunning) != 0)
         {
             // Run LongRunning tasks on their own dedicated thread.
             Thread thread = new Thread(s_longRunningThreadWork);
             thread.IsBackground = true; // Keep this thread from blocking process shutdown
             thread.Start(task);
         }
         else
        {
             // Normal handling for non-LongRunning tasks.
             bool forceToGlobalQueue = (task.Options & TaskCreationOptions.PreferFairness) != 0;
             ThreadPool.UnsafeQueueCustomWorkItem(task, forceToGlobalQueue);
         }
    }
    */  
    Task t = new Task(() => Console.WriteLine(1), TaskCreationOptions.LongRunning);
        
    }

public async Task Run_async()
{
    Task task = Task.Run(async () =>
    {
        while (true)
        {
            
            await Task.Delay(TimeSpan.FromSeconds(10));
        }
    });
    await task;
}

    public async Task Run1_async()
{
    var task = Task.Run(async () =>
    {
           
            await Task.Delay(1);
            return 1;
    });

    var task1 = Task.Run(async () =>
    {
            await Task.Delay(1);
            return 2;
    });

    int[] r=  await Task.WhenAll<int>(task, task1);
    Debug.Assert(3== r.Sum());
    
}



public async Task WhenEach_async()
{
    using HttpClient http = new();

    Task<string> dotnet = http.GetStringAsync("http://dot.net");
    Task<string> bing = http.GetStringAsync("http://www.bing.com");
    Task<string> ms = http.GetStringAsync("http://microsoft.com");

    await foreach (Task<string> t in Task.WhenEach(bing, dotnet, ms))
    {
        Console.WriteLine(t.Result);
    }

}

public void Status()
{
  /*  
public enum TaskStatus
{
    /// <summary>The task has been initialized but has not yet been scheduled.</summary>
    Created,
    /// <summary>The task is waiting to be activated and scheduled internally by the .NET infrastructure.</summary>
    WaitingForActivation,
    /// <summary>The task has been scheduled for execution but has not yet begun executing.</summary>
    WaitingToRun,
    /// <summary>The task is running but has not yet completed.</summary>
    Running,
    /// <summary>The task has finished executing and is implicitly waiting for attached child tasks to complete.</summary>
    WaitingForChildrenToComplete,
    /// <summary>The task completed execution successfully.</summary>
    RanToCompletion,
    /// <summary>The task acknowledged cancellation by throwing an OperationCanceledException with its own CancellationToken while the token was in signaled state, or the task's CancellationToken was already signaled before the task started executing. For more information, see Task Cancellation.</summary>
    Canceled,
    /// <summary>The task completed due to an unhandled exception.</summary>
    Faulted,
}
*/
    Task tsk = Task.Run(() => { });
   var status=  tsk.Status.ToString();
}

public void Delay()
{
 Task tsk1= Task.Delay(100);
 Task tsk2= Task.Delay(100);
 _ = Task.CurrentId;
 Task t =  Task.WhenAll(tsk1, tsk2);
 Task t1=  Task.WhenAny(tsk1, tsk2);
}

public void ContinueWith(Task r)
{
   int  Foo(Task r)
    {
        r.ConfigureAwait(false);
        return 1;
    }
    int i=  r.ContinueWith(Foo).Result;
    Debug.Assert(i==1);
}

public void From()
{
 _ =   Task.FromCanceled(new CancellationToken(true));
 _ =   Task.FromException(new Exception());
}

public void Task_To()
{
    Task.CompletedTask.RunSynchronously();
}

public void TaskCompletionSource()
{
    var tcs = new TaskCompletionSource<object>();
    tcs.SetResult(this);
    tcs.SetCanceled();
    
}

}
```