-- advanced analysis

-- 21. Generate a management hierarchy report showing the structure from store managers
-- down to sales associates for each store.
SELECT 
	stores.store_name,
	manager.first_name || ' ' || manager.last_name manager_name,
	employee.first_name || ' ' || employee.last_name employee_name,
	employee.position
FROM employees employee
LEFT JOIN employees manager ON employee.manager_id = manager.employee_id
JOIN stores ON employee.store_id = stores.store_id
ORDER BY stores.store_name, manager_name, employee.position;

-- 22. Create a comprehensive customer analysis that shows the purchasing patterns of
-- customers in different loyalty tiers, including average transaction value, most
-- purchased categories, and number of products reviewed.
WITH avg_transaction AS (
    SELECT
        customers.loyalty_tier,
        AVG(sales.total_amount) AS avg_transaction_value
    FROM customers
    JOIN sales ON sales.customer_id = customers.customer_id
    GROUP BY customers.loyalty_tier
),

category_totals AS (
    SELECT
        customers.loyalty_tier,
        categories.category_name,
        SUM(sale_items.quantity) AS quantity_bought
    FROM customers
    JOIN sales ON sales.customer_id = customers.customer_id
    JOIN sale_items ON sale_items.sale_id = sales.sale_id
    JOIN products ON products.product_id = sale_items.product_id
    JOIN categories ON categories.category_id = products.category_id
    GROUP BY customers.loyalty_tier, categories.category_name
),

top_category AS (
    SELECT DISTINCT ON (loyalty_tier)
        loyalty_tier,
        category_name AS favorite_category,
        quantity_bought
    FROM category_totals
    ORDER BY loyalty_tier, quantity_bought DESC
),

review_counts AS (
    SELECT
        customers.loyalty_tier,
        COUNT(product_reviews.review_id) AS products_reviewed
    FROM customers
    LEFT JOIN product_reviews ON product_reviews.customer_id = customers.customer_id
    GROUP BY customers.loyalty_tier
)

SELECT
    avg_transaction.loyalty_tier,
    ROUND(avg_transaction.avg_transaction_value, 2) AS avg_transaction_value,
    top_category.favorite_category,
    review_counts.products_reviewed
FROM avg_transaction
JOIN top_category ON top_category.loyalty_tier = avg_transaction.loyalty_tier
JOIN review_counts ON review_counts.loyalty_tier = avg_transaction.loyalty_tier
ORDER BY avg_transaction.loyalty_tier;