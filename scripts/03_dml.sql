INSERT INTO dim_customer (
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    customer_country,
    customer_postal_code,
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed
)
SELECT DISTINCT
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    customer_country,
    customer_postal_code,
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed
FROM mock_data
WHERE customer_email IS NOT NULL
    ON CONFLICT (customer_email) DO NOTHING;

INSERT INTO dim_seller (
    seller_first_name,
    seller_last_name,
    seller_email,
    seller_country,
    seller_postal_code
)
SELECT DISTINCT
    seller_first_name,
    seller_last_name,
    seller_email,
    seller_country,
    seller_postal_code
FROM mock_data
WHERE seller_email IS NOT NULL
    ON CONFLICT (seller_email) DO NOTHING;

INSERT INTO dim_store (
    store_name,
    store_location,
    store_city,
    store_state,
    store_country,
    store_phone,
    store_email
)
SELECT DISTINCT
    store_name,
    store_location,
    store_city,
    store_state,
    store_country,
    store_phone,
    store_email
FROM mock_data
WHERE store_name IS NOT NULL
    ON CONFLICT (store_email) DO NOTHING;

INSERT INTO dim_supplier (
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
)
SELECT DISTINCT
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
FROM mock_data
WHERE supplier_name IS NOT NULL
    ON CONFLICT (supplier_email) DO NOTHING;

INSERT INTO dim_product (
    product_name,
    product_category,
    product_brand,
    product_color,
    product_size,
    product_material,
    product_weight,
    product_description,
    pet_category,
    product_rating,
    product_reviews,
    product_release_date,
    product_expiry_date
)
SELECT DISTINCT
    product_name,
    product_category,
    product_brand,
    product_color,
    product_size,
    product_material,
    product_weight,
    product_description,
    pet_category,
    product_rating,
    product_reviews,
    product_release_date,
    product_expiry_date
FROM mock_data
WHERE product_name IS NOT NULL;

INSERT INTO dim_date (
    full_date,
    year,
    month,
    day
)
SELECT DISTINCT
    sale_date,
    EXTRACT(YEAR FROM sale_date)::INT,
    EXTRACT(MONTH FROM sale_date)::INT,
    EXTRACT(DAY FROM sale_date)::INT
FROM mock_data
WHERE sale_date IS NOT NULL
    ON CONFLICT (full_date) DO NOTHING;

INSERT INTO fact_sales (
    customer_key,
    seller_key,
    product_key,
    store_key,
    supplier_key,
    date_key,
    sale_quantity,
    sale_total_price,
    product_price,
    product_quantity
)
SELECT
    dc.customer_key,
    ds.seller_key,
    dp.product_key,
    dst.store_key,
    dsup.supplier_key,
    dd.date_key,
    m.sale_quantity,
    m.sale_total_price,
    m.product_price,
    m.product_quantity
FROM mock_data m
         LEFT JOIN dim_customer dc ON m.customer_email = dc.customer_email
         LEFT JOIN dim_seller ds ON m.seller_email = ds.seller_email
         LEFT JOIN dim_store dst ON m.store_email = dst.store_email
         LEFT JOIN dim_supplier dsup ON m.supplier_email = dsup.supplier_email
         LEFT JOIN dim_product dp ON m.product_name = dp.product_name
    AND m.product_brand = dp.product_brand
         LEFT JOIN dim_date dd ON m.sale_date = dd.full_date
WHERE m.sale_quantity IS NOT NULL;