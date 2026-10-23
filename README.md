# SQL Business Reports (SAMPLE WORK)
Portfolio sample: 5 reporting queries (CTEs, window functions, joins) over a synthetic sales database (60 customers, 600 orders).
- `schema.sql`, `seed.sql`: build the database (or use the included `demo.db`)
- `reports.sql`: monthly revenue + MoM growth, top 10 customers by LTV, regional revenue share, refund rate, churn-risk list
- `sample-output.txt`: actual results
Run: `sqlite3 -header -column demo.db < reports.sql`
