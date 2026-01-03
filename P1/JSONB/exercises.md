### 1. Operator Logic:

If I have a JSON object {"user": {"id": 101}}, and I write data->'user', what is the data type of the result? If I write data->>'user', what is the data type?

=> For the first `data->'user'` the data type of the result is a **JSON object**. For the second `data->>'user'` is **TEXT*.*

### 2. Performance Check:

You decide to filter your table: WHERE api_response->>'coin' = 'bitcoin'. This table has 10 million rows. Why will this query be slow by default, and what specific index type should you add to the api_response column to fix it? 

=> This query will be slow by default because the search will be on every row until it founds the right match. We should add a `GIN` idex to the api_response column to fix it.

### 3. ELT vs ETL:

You are scraping a website that changes its layout every week. Why is the ELT strategy (dump raw HTML/JSON to DB, then parse) safer than ETL (parse in Python, then load) for this specific scenario? 

=> Due to the format it's safer to make ELT strategy (Extract the information from website >> Load the information to the server (like postgres) >> Transform or arrange the structure).

### 4. Type Casting:

In the practice code, I used (api_response->...->>'price')::NUMERIC. Why is the ::NUMERIC part necessary? What happens if I try to run SUM(price) without it?

=> If we don't specify the NUMERIC type casting price will referred as TEXT so when we try to run SUM(price) it doesn't work.

### 5. Array Access:

In Python, we access a list by list[0]. Based on the SQL example, how do you access the first element of a JSON array in PostgreSQL?

=> In PostegreSQL, we access the first element of a JSON array by : `api_response -> 0 `