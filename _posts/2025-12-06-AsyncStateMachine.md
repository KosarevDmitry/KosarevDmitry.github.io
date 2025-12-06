---
title: AsyncStateMachine
date: 2025-12-06 14:16:58 +0100
categories: [C#]
tags: []
---

```csharp

public class Dummy
    {
      
        [AsyncStateMachine(typeof (Machine))]
        [DebuggerStepThrough]
        private Task Do()
        {
            Machine stateMachine = new Machine();
            stateMachine._builder = AsyncTaskMethodBuilder.Create();
            stateMachine._this = this;
            stateMachine._state = -1;
            stateMachine._builder.Start<Machine>(ref stateMachine);
            return stateMachine._builder.Task;
        }

        public Dummy()
        {
      
        }

        [CompilerGenerated]
        private sealed class Machine : IAsyncStateMachine
        {
            public int _state;
            public AsyncTaskMethodBuilder _builder;
            public Dummy _this;
            private TaskAwaiter _u;

            public Machine()
            {
        
            }

            void IAsyncStateMachine.MoveNext()
            {
                int num1 = _state;
                try
                {
                    TaskAwaiter awaiter;
                    int num2;
                    if (num1 != 0)
                    {
                        awaiter = Task.Delay(1).GetAwaiter();
                        if (!awaiter.IsCompleted)
                        {
                            _state = num2 = 0;
                            _u = awaiter;
                            Machine stateMachine = this;
                            _builder.AwaitUnsafeOnCompleted<TaskAwaiter, Machine>(ref awaiter, ref stateMachine);
                            return;
                        }
                    }
                    else
                    {
                        awaiter = _u;
                        _u = new TaskAwaiter();
                        _state = num2 = -1;
                    }
                    awaiter.GetResult();
                }
                catch (Exception ex)
                {
                    _state = -2;
                    _builder.SetException(ex);
                    return;
                }
                _state = -2;
                _builder.SetResult();
            }

            [DebuggerHidden]
            void IAsyncStateMachine.SetStateMachine([Nullable(1)] IAsyncStateMachine stateMachine)
            {
            }
        }
    }


```