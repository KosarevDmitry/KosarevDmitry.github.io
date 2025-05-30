---
title: How to change and test isolation levels
date: 2024-09-12 20:52:06 +0200
categories: [sql]
tags: [t-sql]
---

Operation levels prevent and regulate the ability to perform certain operations in parallel on one data array.
For example, if a certain isolation level is set, until a transaction is completed by one thread, another thread can perform `Select`, but not `Update`.  
That's the idea.
Suppose I needed to change the settings.  
The question arises how to test the statements and explanation from the reference source.  
How to clearly demonstrate this to yourself and use it with confidence.  

The idea is to start two sessions and open a transaction and stop the thread `WAITFOR DELAY '00:00:15';`,  15 sec is enough.  
Then launch the second session while the first session is hanging and check the reaction.

Execution of commands `select`, `update`, `delete`, `insert` can behave differently:    

- wait ending of blocked transaction - the execution will hang with message  `executing query`;  
- throw error;  
- executes before the blocking transaction ends;

Therefore, it is better to check them separately.

So you need open in `SQL Server Management Studio` the two sessions.

1. First create a procedure to show  `isolation level` in current session just for convenience.

```sql
CREATE PROCEDURE [dbo].[DisplayIsolationLevel]

AS
BEGIN
SET NOCOUNT ON;

DECLARE @res Varchar(100)
Declare @T table (Options varchar(100),Value varchar(100))
Insert Into @T
Exec('DBCC USEROPTIONS')

SELECT @res=Value From @T  Where Options ='isolation level'
Select @res;

END
```

2. Change the ISOLATION LEVEL each of sessions  at your own discretion

	```sql
	use test -- any db for testing

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED

	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

	SET TRANSACTION ISOLATION LEVEL SNAPSHOT

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

	--check
	Exec  dbo.Displayisolationlevel
	```
 
 I use db `Test` with table `dbo.name`

2. Run in the first session tab

	```sql
	begin try
		Begin tran A
			BEGIN  
			-- Update dbo.name Set name = 'active' where id=1;  
			Select * from  dbo.name
			WAITFOR DELAY '00:00:15';   --15 sec
			--   Update dbo.name Set name = 'active1' where id=1;  
			END;
		commit tran A
	end try

	begin catch
		select
			ERROR_NUMBER() AS ErrorNumber,  
			ERROR_SEVERITY() AS ErrorSeverity,  
			ERROR_STATE() AS ErrorState,  
			ERROR_PROCEDURE() AS ErrorProcedure,  
			ERROR_LINE() AS ErrorLine,  
			ERROR_MESSAGE() AS ErrorMessage;

	end catch
	```

3. Run in the second session tab
 
	```sql
	begin try
	  Begin tran B
	-- command examples
	-- Select name from  dbo.name where id=1
	-- Update dbo.name Set name = 'passiive' where id=1;
	-- Insert into dbo.name values ('bobo1')

	   commit tran B
	end try
	begin catch
	 select
	   ERROR_NUMBER() AS ErrorNumber,  
	   ERROR_SEVERITY() AS ErrorSeverity,  
	   ERROR_STATE() AS ErrorState,  
	   ERROR_PROCEDURE() AS ErrorProcedure,  
	   ERROR_LINE() AS ErrorLine,  
	   ERROR_MESSAGE() AS ErrorMessage;

	end catch
	```

This way, you will clearly see the result, how the operations will be carried out and whether you actually need it.


- This is a list of isolation level commands that I used

	- `READ UNCOMMITTED`

		```sql
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		exec [dbo].[DisplayIsolationLevel]
		```

	- `read committed`

		```sql
		ALTER DATABASE test
		SET READ_COMMITTED_SNAPSHOT OFF;
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED  
		exec [dbo].[DisplayIsolationLevel]
	```

	- `read committed snapshot`  

		```sql
		 ALTER DATABASE test                             
		 SET READ_COMMITTED_SNAPSHOT ON; 
		 SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		 exec [dbo].[DisplayIsolationLevel]
		```

	- `REPEATABLE READ`

		```sql
		SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
		exec [dbo].[DisplayIsolationLevel]
	```

	- `snapshot`

		```sql
		SET TRANSACTION ISOLATION LEVEL SNAPSHOT
		exec [dbo].[DisplayIsolationLevel]
		 ```

	- `serializable`
	 
		```sql
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		exec [dbo].[DisplayIsolationLevel]
		```