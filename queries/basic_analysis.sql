-- Solving for the basic analysis
-- 1. Which products have less than 20 items in stock? Sort the results by stock quantity in ascending order.
SELECT 
	*
FROM 
	products
WHERE stock_quantity < 20
ORDER BY stock_quantity;

-- 2. What products are currently out of stock (stock_quantity = 0)?
SELECT 
	*
FROM 
	products
WHERE stock_quantity = 0;

-- 3. Calculate the profit margin percentage for each product. Which products have the highest profit margins?
SELECT
	*,
	(price - cost) / price * 100 percentage_profit_margin
FROM 
	products
ORDER BY
	percentage_profit_margin DESC;

-- 4. Find all products that have no assigned category or supplier.
SELECT 
	*
FROM 
	products
WHERE category_id IS NULL OR supplier_id IS NULL;

-- 5. List all products along with their category name and supplier name. Include products 
-- that don't have a category or supplier assigned.
SELECT 
	p.*,
	category_name,
	supplier_name
FROM 
	products p
LEFT JOIN categories c
ON p.category_id = c.category_id
LEFT JOIN suppliers s
ON p.supplier_id = s.supplier_id;
