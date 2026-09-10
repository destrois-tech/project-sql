--- Sales Analysis
-- Aggregation Analysis

-- 6. What is the total sales amount for each store? Show the store name, region, and total sales.
SELECT
	SUM(total_amount) total_sales,
	store_name,
	region
FROM sales
JOIN stores ON sales.store_id = stores.store_id
GROUP BY store_name, region;

-- 7. Calculate the total sales amount for each month of 2023, along with the count of
-- transactions for that month.
SELECT 
	COUNT(*) transaction_count,
	SUM(total_amount) total_sales,
	EXTRACT(MONTH FROM sale_date) AS month
FROM
	sales
WHERE
	EXTRACT(YEAR FROM sale_date) = 2023
GROUP BY
	EXTRACT(MONTH FROM sale_date)
ORDER BY
	month;

-- 8. Which product categories generate the most revenue? Rank categories by total sales amount.
SELECT
	SUM(quantity * price_sold) revenue,
	category_name
FROM 
	sale_items
JOIN products ON sale_items.product_id = products.product_id
JOIN categories ON products.category_id = categories.category_id
GROUP BY category_name
ORDER BY revenue DESC;

-- 9. Identify the top 5 most frequently purchased products along with their total quantity sold.
SELECT
	products.product_id,
	products.product_name,
	SUM(sale_items.quantity) quantity_sold
FROM 
	sale_items
JOIN products ON sale_items.product_id = products.product_id
GROUP BY products.product_id, products.product_name
ORDER BY quantity_sold DESC
LIMIT 5;

-- 10. For each customer, list their name, email, number of purchases, and the date of their
-- most recent purchase.
SELECT 
	customers.first_name || ' ' || last_name customer_name,
	customers.email,
	COUNT(sale_id) number_of_purchase,
	MAX(sale_date) recent_purchase
FROM
	customers
LEFT JOIN sales ON customers.customer_id = sales.customer_id
GROUP BY customers.email, customer_name
ORDER BY recent_purchase DESC