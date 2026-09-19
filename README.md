# E-Commerce Sales Analysis | PostgreSQL

## Project Overview

This project analyzes customer and order data using PostgreSQL. The goal is to turn raw e-commerce transaction data into useful business insights such as total sales, customer spending, category performance, monthly trends, and customer rankings by city.

The project contains **35 solved SQL analysis questions** and demonstrates practical SQL skills used in data analyst roles.

## Objectives

- Analyze customer and order activity
- Calculate sales and order KPIs
- Identify high-value customers
- Compare sales across cities and product categories
- Analyze monthly sales trends
- Practice SQL JOINs, CTEs, subqueries, and window functions
- Build a final customer performance report

## Database

**PostgreSQL**

### Tables

#### `customers`

| Column | Description |
|---|---|
| customer_id | Unique customer identifier |
| customer_name | Customer name |
| email | Customer email |
| city | Customer city |
| state | Customer state |
| signup_date | Customer registration date |

#### `orders`

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| customer_id | Customer reference |
| order_date | Date of order |
| order_status | Current order status |
| payment_method | Payment method |
| product_category | Product category |
| quantity | Number of units |
| unit_price | Price per unit |
| discount_rate | Discount percentage |
| order_amount | Order value |

## SQL Concepts Covered

1. SELECT
2. WHERE
3. ORDER BY
4. LIMIT
5. COUNT
6. SUM
7. AVG
8. MIN / MAX
9. GROUP BY
10. HAVING
11. INNER JOIN
12. LEFT JOIN
13. CASE
14. DATE_TRUNC
15. EXTRACT
16. CTEs
17. Subqueries
18. DENSE_RANK()
19. LAG()
20. SUM() OVER()
21. NULL handling with COALESCE
22. Business-oriented KPI calculations

## 35 Questions Covered

### Basic SQL
1. Display all customers
2. Display all orders
3. Select customer details
4. Filter customers by city
5. Filter high-value orders
6. Filter orders by year
7. Sort orders by amount
8. Find top 10 orders

### Aggregations
9. Count customers
10. Count orders
11. Calculate total sales
12. Calculate average order value
13. Find minimum and maximum order
14. Sales by category
15. Orders by payment method
16. Quantity sold by category

### JOINs and Customer Analysis
17. Customers with more than 3 orders
18. Orders with customer details
19. Total spending by customer
20. Top 10 customers
21. Sales by city
22. Customers without orders
23. Completed orders with customer details

### Business Analysis
24. Discounted order value
25. Order value classification
26. Monthly sales
27. Monthly order count
28. Highest-selling category using a CTE
29. Customers above average spending

### Advanced SQL
30. Rank customers by spending within each city
31. Top 3 customers from each city
32. Previous order amount using LAG()
33. Running sales total
34. Customer contribution to total sales
35. Final customer performance report

## Project Structure

```text
ecommerce-sales-analysis/
│
├── sql/
│   └── ecommerce_sales_analysis_35_questions.sql
│
├── README.md
│
├── linkedin/
│   └── linkedin_post.md
│
├── docs/
│   └── github_upload_guide.md
│
└── .gitignore
```

## How to Run

### 1. Install PostgreSQL

Install PostgreSQL and open pgAdmin or connect through `psql`.

### 2. Create a database

```sql
CREATE DATABASE ecommerce_sales_analysis;
```

Connect to the database.

### 3. Open the SQL file

Run:

```text
sql/ecommerce_sales_analysis_35_questions.sql
```

The file creates the required tables and contains all 35 solved queries.

### 4. Add your dataset

If you already have `customers` and `orders` CSV files, import the data into the matching tables. If your column names differ, update the table definitions or import mapping before running the analysis queries.

## Key Portfolio Skills Demonstrated

- Relational data analysis
- SQL data aggregation
- Customer segmentation
- Sales analysis
- Date-based analysis
- JOIN-based reporting
- CTE-based analysis
- Window functions
- Business KPI reporting

## Example Advanced Query

The project ranks customers within their city:

```sql
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
ORDER BY city, spending_rank;
```

## Author

**Yash Gawli**

SQL / Data Analytics Portfolio Project

## License

This project is intended for learning, portfolio, and demonstration purposes.
