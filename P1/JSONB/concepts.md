
Modern data doesn't always fit into neat rows and columns. APIs return complex, nested JSON objects. In the old days, you had to write complex Python scripts to "flatten" this data before loading it.

**The Modern Approach (ELT)**: Load the raw, messy JSON directly into PostgreSQL first, then use SQL to clean it up.

## JSONB (Binary JSON)

* **What is it?** => A special data type in PostgreSQL that stores JSON in a decomposed, binary format.

* **Why not just TEXT?** => If you store JSON as TEXT, the database sees it as a dumb string. If you store it as JSONB, the database understands the structure. It supports indexing (GIN) and efficient querying. 

### The Operators (-> vs ->>)

* `-> (The Arrow)`: Returns the field as a JSON object.

Use this if you want to keep drilling down deeper (e.g., data->'user'->'address').

* `->> (The Double Arrow)`: Returns the field as Text.

Use this when you are at the end of the chain and want the actual value (e.g., data->'user'->>'name'). 

### The ELT Pattern

- **Extract:** Pull raw JSON from API.

- **Load:** Dump the whole blob into a raw_data JSONB column in Postgres.

- **Transform:** Create a SQL View that parses the JSON into columns.

-** Benefit:** If the API changes its structure (e.g., renames "userId" to "u_id"), you don't need to re-download the data. You just update your SQL View.