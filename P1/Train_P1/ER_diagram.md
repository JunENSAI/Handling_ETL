## The Entity-Relationship (ER) Diagram

### What is it?
A visual map of your database. It shows boxes (Tables) and lines (Foreign Keys).

### Why use it? 
It is the fastest way to spot design errors.

### Circular Dependencies
Table A points to Table B, which points to Table A. This is a nightmare to update.

### Islands
A table that has no lines connecting it to anything else. If it's not connected, how can you join it in a report? 

## The Query Plan (EXPLAIN)

- The Reality: SQL is a declarative language. You tell the DB what you want, not how to get it. The Query Planner decides the "how."

- The Tool: EXPLAIN (ANALYZE)

- Sequential Scan (Seq Scan): The database reads every single row. Bad for big tables.

- Index Scan: The database uses the index to jump to the data. Good.

- Cost: A number (e.g., cost=0.00..12.50) representing the estimated work.