CREATE TABLE customers(id INTEGER PRIMARY KEY, name TEXT, region TEXT, signup_date DATE);
CREATE TABLE orders(id INTEGER PRIMARY KEY, customer_id INT REFERENCES customers(id), order_date DATE, amount REAL, status TEXT);
