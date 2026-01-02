### 1. Constraint Logic:

In the `fact_video_plays` table above, I added CHECK (duration_seconds >= 0). Why is this "Check Constraint" better than just handling negative numbers in my Python script later? 

=> It's better because you specify directly on the database that you don't accept negative values. So when we try to insert those negative values, error must be appeared on the sql console.

### 2.Data Type Selection:

Your boss asks you to add a column for subscription_price to the dim_user table. Would you use FLOAT or NUMERIC? Explain exactly what risk you run if you choose the wrong one. 

=> `NUMERIC` because if we use FLOAT the subscription_price must not be the correct one but an approximation.

### 3. The "Unknown" Row:

Look at the `INSERT INTO dim_device ... VALUES (-1, ...)` line. If our source data has a NULL device, we will transform it to -1 before loading. Why is this better than just letting the Foreign Key be NULL in the Fact table?

=> It's better because when we want to make join we don't have to handle NULL values (that can be a problem).

### 4. Timezones:

You are extracting data from a server in London (UTC+0) and loading it into a server in Tokyo (UTC+9). If you use TIMESTAMP (without TZ), and the data says "08:00", what time does the Tokyo server think it is? What confusion does this cause for a global report? 

=> When the Tokyo server reads "08:00", it thinks "It is 08:00 in Tokyo." The event happened at 08:00 London time, which is actually 17:00 Tokyo time. So, the database is now `9 hours off`.

### 5. DDL Literacy:

What is the difference between `DROP TABLE` and `TRUNCATE TABLE`? 

=> "Drop" in SQL refers to the removal of a table or database from a server. "Truncate" is a SQL command that removes all rows from a table but keeps the table's structure intact.