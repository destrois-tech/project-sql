-- Relationship Analysis
-- 11. Calculate the total amount spent by each customer. Sort by total spend in descending order.
SELECT 
	customers.first_name || ' ' || last_name customer_name,
	customers.email,
	MAX(sales.total_amount) total_spent
FROM
	customers
JOIN sales ON customers.customer_id = sales.customer_id
GROUP BY customers.email, customer_name
ORDER BY total_spent DESC

-- 12. Find the average rating given by customers in each loyalty tier. Does loyalty tier
-- correlate with how customers rate products?
SELECT 
	AVG(product_reviews.rating) average_rating,
	customers.loyalty_tier
FROM 
	product_reviews
JOIN customers ON  product_reviews.customer_id = customers.customer_id
GROUP BY customers.loyalty_tier
ORDER BY customers.loyalty_tier
-- From the result shown, loyalty tier has no correlation with how customers rate products

-- 13. Identify customers who have made purchases but have never left a product review.
SELECT
	DISTINCT 
	customers.customer_id,
	customers.first_name,
	customers.last_name
FROM 
	customers
JOIN sales ON customers.customer_id = sales.customer_id
LEFT JOIN product_reviews ON customers.customer_id = product_reviews.customer_id
WHERE product_reviews.review_id IS NULL;

-- 14. Which customers have increased their spending in the second quarter of 2023
-- compared to the first quarter?
SELECT
	first_name,
	last_name,
	SUM(CASE WHEN EXTRACT(QUARTER FROM sale_date) = 1 THEN total_amount ELSE 0 END) Q1_total,
	SUM(CASE WHEN EXTRACT(QUARTER FROM sale_date) = 2 THEN total_amount ELSE 0 END) Q2_total,
	CASE 
		WHEN
			SUM(CASE WHEN EXTRACT(QUARTER FROM sale_date) = 1 THEN total_amount ELSE 0 END) 
		>	SUM(CASE WHEN EXTRACT(QUARTER FROM sale_date) = 2 THEN total_amount ELSE 0 END)
		THEN TRUE
		ELSE FALSE
	END AS spending_increased
FROM customers
JOIN sales ON customers.customer_id = sales.customer_id
WHERE EXTRACT(YEAR FROM sale_date) = 2023
GROUP BY first_name, last_name
HAVING 
	SUM(CASE WHEN EXTRACT(QUARTER FROM sale_date) = 1 THEN total_amount ELSE 0 END) > 
	SUM(CASE WHEN EXTRACT(QUARTER FROM sale_date) = 2 THEN total_amount ELSE 0 END)
ORDER BY spending_increased DESC;

-- 15. What are the favorite product categories for Gold tier customers based on their purchase history?
SELECT
	categories.category_id,
	categories.category_name,
	SUM(sale_items.quantity) number_of_items_bought
FROM customers
JOIN sales ON sales.customer_id = customers.customer_id
LEFT JOIN sale_items ON sale_items.sale_id = sales.sale_id
LEFT JOIN products ON products.product_id = sale_items.product_id
LEFT JOIN categories ON categories.category_id = products.category_id
WHERE customers.loyalty_tier = 'Gold'
GROUP BY categories.category_id, categories.category_name
ORDER BY number_of_items_bought DESC;