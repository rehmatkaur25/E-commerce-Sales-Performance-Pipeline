-- =============================================================
-- E-commerce Sales Performance Pipeline — MySQL Schema
-- Database: ecommerce_project
-- =============================================================

CREATE DATABASE ecommerce_project;
USE ecommerce_project;

-- -------------------------------------------------------------
-- Table: customers
-- -------------------------------------------------------------
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    segment VARCHAR(20),
    signup_channel VARCHAR(30),
    signup_date DATE,
    email VARCHAR(100),
    phone VARCHAR(30),
    has_email BOOLEAN,
    has_phone BOOLEAN
);

-- -------------------------------------------------------------
-- Table: products
-- -------------------------------------------------------------
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    unit_cost DECIMAL(10,2),
    stock_qty INT,
    price_was_imputed BOOLEAN
);

-- -------------------------------------------------------------
-- Table: orders
-- -------------------------------------------------------------
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    order_date DATE,
    status VARCHAR(20),
    payment_method VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- -------------------------------------------------------------
-- Table: order_items
-- -------------------------------------------------------------
CREATE TABLE order_items (
    order_item_id VARCHAR(12) PRIMARY KEY,
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,
    discount_pct DECIMAL(4,2),
    quantity_was_imputed BOOLEAN,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- =============================================================
-- Data Loading (run from mysql client with --local-infile=1)
-- Paths below assume the cleaned CSVs sit in the same folder
-- as this script — adjust paths as needed.
-- =============================================================

LOAD DATA LOCAL INFILE 'customers_clean.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, customer_name, city, segment, signup_channel, signup_date, email, phone, @has_email, @has_phone)
SET has_email = IF(@has_email = 'True', 1, 0),
    has_phone = IF(@has_phone = 'True', 1, 0);

LOAD DATA LOCAL INFILE 'products_clean.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id, product_name, category, unit_price, unit_cost, stock_qty, @price_was_imputed)
SET price_was_imputed = IF(@price_was_imputed = 'True', 1, 0);

LOAD DATA LOCAL INFILE 'orders_clean.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'order_items_clean.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_item_id, order_id, product_id, quantity, discount_pct, @quantity_was_imputed)
SET quantity_was_imputed = IF(@quantity_was_imputed = 'True', 1, 0);


-- =============================================================
-- Analysis Queries
-- =============================================================

-- 1. Top 5 customers by total spend
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount_pct)), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- 2. Revenue by category
SELECT
    p.category,
    ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount_pct)), 2) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- 3. Monthly order counts
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- 4. Order status breakdown with % of total (funnel health)
SELECT
    status,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS pct_of_total
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- 5. Average order value by payment method
SELECT
    o.payment_method,
    COUNT(DISTINCT o.order_id) AS num_orders,
    ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount_pct)) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.payment_method
ORDER BY avg_order_value DESC;
