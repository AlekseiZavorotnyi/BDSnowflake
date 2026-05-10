CREATE TABLE dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_first_name TEXT,
    customer_last_name TEXT,
    customer_age INT,
    customer_email TEXT UNIQUE,
    customer_country TEXT,
    customer_postal_code TEXT,
    customer_pet_type TEXT,
    customer_pet_name TEXT,
    customer_pet_breed TEXT
);

CREATE TABLE dim_seller (
    seller_key SERIAL PRIMARY KEY,
    seller_first_name TEXT,
    seller_last_name TEXT,
    seller_email TEXT NOT NULL UNIQUE,
    seller_country TEXT,
    seller_postal_code TEXT
);

CREATE TABLE dim_store (
    store_key SERIAL PRIMARY KEY,
    store_name TEXT,
    store_location TEXT,
    store_city TEXT,
    store_state TEXT,
    store_country TEXT,
    store_phone TEXT,
    store_email TEXT NOT NULL UNIQUE
);

CREATE TABLE dim_supplier (
    supplier_key SERIAL PRIMARY KEY,
    supplier_name TEXT,
    supplier_contact TEXT,
    supplier_email TEXT NOT NULL UNIQUE,
    supplier_phone TEXT,
    supplier_address TEXT,
    supplier_city TEXT,
    supplier_country TEXT
);

CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_name TEXT,
    product_category TEXT,
    product_brand TEXT,
    product_color TEXT,
    product_size TEXT,
    product_material TEXT,
    product_weight NUMERIC(10,2),
    product_description TEXT,
    pet_category TEXT,
    product_rating NUMERIC(3,1),
    product_reviews INT,
    product_release_date DATE,
    product_expiry_date DATE
);

CREATE TABLE dim_date (
    date_key SERIAL PRIMARY KEY,
    full_date DATE UNIQUE,
    year INT,
    month INT,
    day INT
);


CREATE TABLE fact_sales (
    sale_key SERIAL PRIMARY KEY,
    customer_key INTEGER REFERENCES dim_customer(customer_key),
    seller_key INTEGER REFERENCES dim_seller(seller_key),
    product_key INTEGER REFERENCES dim_product(product_key),
    store_key INTEGER REFERENCES dim_store(store_key),
    supplier_key INTEGER REFERENCES dim_supplier(supplier_key),
    date_key INTEGER REFERENCES dim_date(date_key),
    sale_quantity INT,
    sale_total_price NUMERIC(10,2),
    product_price NUMERIC(10,2),
    product_quantity INT
);