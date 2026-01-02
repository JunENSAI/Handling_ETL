## Data Types Matter

Choosing the wrong data type is a "technical debt" that you pay for forever.

### TIMESTAMPTZ vs TIMESTAMP:

- It's preferable to use TIMESTAMPTZ (Timestamp with Time Zone).

- **Why?**

    If you store 2023-01-01 10:00 without a timezone, and your server is in France but your user is in New York, your reports will be wrong by 6 hours. `TIMESTAMPTZ`converts everything to UTC automatically. 

### NUMERIC vs FLOAT:

- Use `NUMERIC` (or `DECIMAL`) for Money.

- `FLOAT is "approximate.`" 0.1 + 0.2 in floating point math often equals 0.30000000000000004. This is unacceptable for financial audits.

- Use FLOAT only for scientific data (like temperature or physics). 

### TEXT vs VARCHAR(n):

In modern PostgreSQL, there is no performance penalty for using TEXT. 

Generally, use TEXT unless you have a strict business rule (e.g., "Zip codes must be 5 chars").

## Constraints

Constraints prevent bad data from entering your warehouse.

- `Primary Key:` Unique ID for the table.

- `Foreign Key:` Ensures the link exists (e.g., you can't insert a Fact for a Video ID that doesn't exist in dim_video). 

- `Not Null:` Essential for dimensions. A dimension column should almost never be null (use "Unknown" instead).

---