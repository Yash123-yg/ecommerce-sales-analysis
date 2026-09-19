-- ============================================================
-- PROJECT: E-Commerce Sales Analysis
-- DATABASE: PostgreSQL
-- FILE: ecommerce_sales_analysis_35_questions.sql
-- ============================================================
-- This project contains 35 solved SQL analysis questions covering:
-- SELECT, WHERE, ORDER BY, GROUP BY, HAVING, JOINs, aggregates,
-- CASE, date functions, CTEs, subqueries, and window functions.
--
-- Expected tables:
--   customers(customer_id, customer_name, email, city, state, signup_date)
--   orders(order_id, customer_id, order_date, order_status,
--          payment_method, product_category, quantity, unit_price,
--          discount_rate, order_amount)
--
-- Run the schema/data section first if you are using your own data.
-- ============================================================

-- =========================
-- 0. TABLES
-- =========================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(100),
    signup_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    order_status VARCHAR(30),
    payment_method VARCHAR(30),
    product_category VARCHAR(80),
    quantity INT,
    unit_price NUMERIC(12,2),
    discount_rate NUMERIC(5,2),
    order_amount NUMERIC(14,2)
);

-- ============================================================
-- 35 SQL QUESTIONS + SOLUTIONS
-- ============================================================

-- 1. Display all customers.
SELECT *
FROM customers;

-- 2. Display all orders.
SELECT *
FROM orders;

-- 3. Display customer name, city and state.
SELECT customer_name, city, state
FROM customers;

-- 4. Find customers from a specific city.
SELECT *
FROM customers
WHERE city = 'Mumbai';

-- 5. Find orders with amount greater than 10,000.
SELECT *
FROM orders
WHERE order_amount > 10000;

-- 6. Find orders placed in 2026.
SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2026;

-- 7. Display orders from highest to lowest order amount.
SELECT *
FROM orders
ORDER BY order_amount DESC;

-- 8. Find the 10 highest-value orders.
SELECT *
FROM orders
ORDER BY order_amount DESC
LIMIT 10;

-- 9. Count the total number of customers.
SELECT COUNT(*) AS total_customers
FROM customers;

-- 10. Count the total number of orders.
SELECT COUNT(*) AS total_orders
FROM orders;

-- 11. Find total sales.
SELECT SUM(order_amount) AS total_sales
FROM orders;

-- 12. Find average order value.
SELECT ROUND(AVG(order_amount), 2) AS average_order_value
FROM orders;

-- 13. Find minimum and maximum order amount.
SELECT
    MIN(order_amount) AS minimum_order,
    MAX(order_amount) AS maximum_order
FROM orders;

-- 14. Find total sales by product category.
SELECT
    product_category,
    SUM(order_amount) AS total_sales
FROM orders
GROUP BY product_category
ORDER BY total_sales DESC;

-- 15. Find number of orders by payment method.
SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- 16. Find total quantity sold by product category.
SELECT
    product_category,
    SUM(quantity) AS total_quantity
FROM orders
GROUP BY product_category
ORDER BY total_quantity DESC;

-- 17. Find customers with more than 3 orders.
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 3
ORDER BY total_orders DESC;

-- 18. Show each order with customer name and city.
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.city,
    o.order_amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_date;

-- 19. Find total spending of each customer.
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.order_amount) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC;

-- 20. Find the top 10 customers by total spending.
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.order_amount) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC
LIMIT 10;

-- 21. Find total sales by city.
SELECT
    c.city,
    SUM(o.order_amount) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_sales DESC;

-- 22. Find customers who have never placed an order.
SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 23. Find completed orders and their customer details.
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.city,
    o.order_amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'Completed'
ORDER BY o.order_date DESC;

-- 24. Calculate the discounted value of each order.
SELECT
    order_id,
    order_amount,
    discount_rate,
    ROUND(
        order_amount - (order_amount * discount_rate / 100),
        2
    ) AS discounted_value
FROM orders;

-- 25. Categorize orders by value.
SELECT
    order_id,
    order_amount,
    CASE
        WHEN order_amount >= 20000 THEN 'High Value'
        WHEN order_amount >= 10000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_value_category
FROM orders
ORDER BY order_amount DESC;

-- 26. Find monthly sales.
SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    SUM(order_amount) AS total_sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;

-- 27. Find the number of orders placed each month.
SELECT
    DATE_TRUNC('month', order_date)::DATE AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY order_month;

-- 28. Find the highest-selling product category using a CTE.
WITH category_sales AS (
    SELECT
        product_category,
        SUM(order_amount) AS total_sales
    FROM orders
    GROUP BY product_category
)
SELECT
    product_category,
    total_sales
FROM category_sales
ORDER BY total_sales DESC
LIMIT 1;

-- 29. Find customers whose spending is above the average customer spending.
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(o.order_amount) AS total_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spending
FROM customer_spending
WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM customer_spending
)
ORDER BY total_spending DESC;

-- 30. Rank customers by total spending within each city.
WITH rankedcustomers AS (
    SELECT
        c.city,
        c.customer_id,
        c.customer_name,
        SUM(o.order_amount) AS total_spending,
        DENSE_RANK() OVER (
            PARTITION BY c.city
            ORDER BY SUM(o.order_amount) DESC
        ) AS spending_rank
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.city, c.customer_id, c.customer_name
)
SELECT *
FROM rankedcustomers
ORDER BY city, spending_rank, customer_id;

-- 31. Return the top 3 customers from each city.
WITH rankedcustomers AS (
    SELECT
        c.city,
        c.customer_id,
        c.customer_name,
        SUM(o.order_amount) AS total_spending,
        DENSE_RANK() OVER (
            PARTITION BY c.city
            ORDER BY SUM(o.order_amount) DESC
        ) AS spending_rank
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.city, c.customer_id, c.customer_name
)
SELECT *
FROM rankedcustomers
WHERE spending_rank <= 3
ORDER BY city, spending_rank, customer_id;

-- 32. Show each order and the previous order amount for that customer.
SELECT
    customer_id,
    order_id,
    order_date,
    order_amount,
    LAG(order_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS previous_order_amount
FROM orders
ORDER BY customer_id, order_date, order_id;

-- 33. Calculate running sales total by order date.
SELECT
    order_date,
    order_id,
    order_amount,
    SUM(order_amount) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_sales
FROM orders
ORDER BY order_date, order_id;

-- 34. Calculate each customer's percentage contribution to total sales.
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(o.order_amount) AS total_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spending,
    ROUND(
        100.0 * total_spending / SUM(total_spending) OVER (),
        2
    ) AS sales_contribution_pct
FROM customer_sales
ORDER BY sales_contribution_pct DESC;

-- 35. Build a final customer performance report.
WITH customer_metrics AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.city,
        COUNT(o.order_id) AS total_orders,
        SUM(o.order_amount) AS total_spending,
        ROUND(AVG(o.order_amount), 2) AS avg_order_value,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name, c.city
),
ranked AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY city
            ORDER BY total_spending DESC NULLS LAST
        ) AS city_rank
    FROM customer_metrics
)
SELECT
    customer_id,
    customer_name,
    city,
    COALESCE(total_orders, 0) AS total_orders,
    COALESCE(total_spending, 0) AS total_spending,
    COALESCE(avg_order_value, 0) AS avg_order_value,
    last_order_date,
    city_rank
FROM ranked
ORDER BY city, city_rank, customer_id;

-- ============================================================
-- END OF PROJECT
-- ============================================================
