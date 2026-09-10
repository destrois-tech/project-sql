-- advanced analysis

-- 16. Calculate the total sales amount and number of transactions for each employee. Who
-- are the top-performing sales associates?
SELECT
	employees.first_name || ' ' || employees.last_name employees_name,
	employees.employee_id,
	SUM(total_amount) total_sales_amount,
	COUNT(*) number_of_transactions
FROM sales
JOIN employees ON sales.employee_id = employees.employee_id
GROUP BY employees.employee_id, employees.first_name, employees.last_name
ORDER BY total_sales_amount DESC;

-- 17. Find the average transaction value for each employee. Who generates the highest
-- average sale amount?
SELECT
	employees.first_name || ' ' || employees.last_name employees_name,
	employees.employee_id,
	AVG(total_amount) avg_transaction_value
FROM sales
JOIN employees ON sales.employee_id = employees.employee_id
GROUP BY employees.employee_id, employees.first_name, employees.last_name
ORDER BY avg_transaction_value DESC;

-- 18. Create a report showing each store's name, manager's name, number of employees,
-- and total sales amount.
SELECT
	stores.store_name,
	MAX(CASE WHEN employees.position = 'Store Manager'
		THEN employees.first_name || ' ' || employees.last_name END) manager_name,
	COUNT(DISTINCT(employees.employee_id)) employee_count,
	SUM(total_amount) total_sales_amount
FROM stores
LEFT JOIN employees ON stores.store_id = employees.store_id
LEFT JOIN sales ON sales.store_id = stores.store_id
GROUP BY stores.store_id, stores.store_name
ORDER BY total_sales_amount DESC;

-- 19. Identify stores where the average employee salary is higher than the company-wide average
SELECT
	stores.store_name,
	AVG(employees.salary) avg_store_salary
FROM stores
JOIN employees ON employees.store_id = stores.store_id
GROUP BY stores.store_id, stores.store_name
HAVING AVG(employees.salary) > (SELECT AVG(salary) FROM employees);

-- 20. Create a product performance matrix that categorizes products into four groups
-- based on their sales volume and profit margin:
-- ○ Stars: High sales, high margin
-- ○ Volume Drivers: High sales, low margin
-- ○ Opportunities: Low sales, high margin
-- ○ Problems: Low sales, low margin
WITH product_stats AS(
SELECT
	products.product_id,
	products.product_name,
	SUM(sale_items.quantity) total_volume,
	ROUND((products.price - products.cost) / products.price * 100, 2) profit_margin
FROM products
LEFT JOIN sale_items ON sale_items.product_id = products.product_id
GROUP BY products.product_id, products.product_name, products.price, products.cost
), 
averages AS(
SELECT
	AVG(total_volume) avg_volume,
	AVG(profit_margin) avg_margin
FROM product_stats
)
SELECT
	product_stats.product_name,
	product_stats.total_volume,
	product_stats.profit_margin,
	CASE
		WHEN total_volume >= avg_volume AND profit_margin >= avg_margin THEN 'star'
		WHEN total_volume >= avg_volume THEN 'Volume Driver'
		WHEN profit_margin >= avg_margin THEN 'Opportunity'
		ELSE 'Problem'
	END AS performance_category
FROM product_stats, averages
ORDER BY total_volume DESC;