### 1. Visual Debugging:

You generate an ER Diagram and notice that dim_user is floating all alone on the screen, with no line connecting it to fact_video_plays. What specific part of the CREATE TABLE DDL statement did you likely forget? 

=> I think you make mistake because in DDL statement I saw REFERENCES so the act_video_plays is connected with dim_user normally.

### 2. The "Cost" of Indexes:

You run EXPLAIN on a query for a table with only 10 rows. The planner chooses a Seq Scan (reading all rows) instead of using your nice Index. Is the database broken? Why would a planner prefer a full scan over an index for tiny tables?

=> No, data is not broken. Index is more useful when we have an amount of data not likely here that we have only 10 rows. For tiny tables, it takes more effort to open the index book than to just read the 10 rows.

### 3. Circular Logic:

Why is a "Circular Dependency" (Table A references B, B references A) dangerous for an ETL pipeline?

=> A "Circular Dependency" is dangerous for an ETL pipeline due to : To delete Table A, you must first delete Table B (because A depends on B). But to delete Table B, you must first delete Table A (because B depends on A). You are stuck.

### 4. Fact Table hygiene:

In your ER diagram, you see that `fact_video_plays` links to dim_user via user_key. Would it be acceptable for `fact_video_plays` to also contain the column user_email directly? Why or why not? (Hint: Think about the "Single Source of Truth").

=> If `fact_video_plays` contains **user_email** I think we talk about redudancy because the dim_user table has already user_email. So, it wouldn't be acceptable because when you modify user_email on `fact_video_plays` you need also to modify the information in dim_user.

### P1 Retrospective:

In one sentence, summarize the main goal of P1 (Days 1-8). Why did we spend 8 days here before writing a single line of Python?

=> It's very important to understand how the database works (some theory that you needed to know before talking about python connection). When we have the basics we can easily follow how python works.