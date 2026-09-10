Mountain Peak Outfitters — Findings Report
Inventory Management
Q1: Products with less than 20 items in stock
Six products currently sit below the 20-unit threshold, ranging from the completely out-of-stock Trailblazer Hiking Boot down to the
Pathfinder 55L Backpack at 18 units. Three of the six are camping-related items (tents, stoves), suggesting camping gear may need closer
restock monitoring heading into peak season.
Q2: Out-of-stock products
Only one product is fully out of stock: the Trailblazer Hiking Boot. Since hiking boots are a core category for an outdoor retailer, this is worth
flagging as a priority restock rather than a minor gap.
Q3: Profit margin by product
Water bottles lead by a wide margin — both the EcoTrek and Adventure Water Bottle sit near 80% margin, far above every other category.
Hiking Poles and the Orphan Product follow at 60–62%. This suggests accessories (low material cost, steady markup) are
disproportionately profitable compared to big-ticket gear like tents and jackets, which typically run tighter margins.
Q4: Products with no category or supplier
One product — "Orphan Product" — has neither a category nor a supplier assigned. This looks like a data entry gap that should be corrected
before this product can be properly tracked in category-level or supplier-level reporting.
Q5: Full product list with category and supplier names
A complete product listing was generated using LEFT JOINs to preserve products with missing category/supplier links (per Q4). All 16
products are represented, with "Orphan Product" showing NULL for both lookup fields as expected.
Sales Analysis
Q6: Total sales by store
Denver leads all stores at $1,624.89 in total sales, followed by Seattle and Boston. Portland trails significantly at $299.99 — likely reflecting
its later opening date (2019) and possibly limited seed data volume rather than a true performance issue. Three of the top four stores are in
the West/East regions; Portland (also West) being the outlier suggests store-level factors beyond just region are driving the gap.
Q7: Monthly sales for 2023
Sales data spans January through June 2023, peaking in May ($1,749.91 across 5 transactions) and dropping sharply by June (just 1
transaction, $299.99). Without further months of data it's hard to call this a seasonal trend — more likely the dataset simply ends mid-year.
Q8: Revenue by category
Tents generate the most revenue ($1,899.94), nearly double the next category (Jackets, $1,059.95). This is notable given tents aren't the
highest-margin category (per Q3) — they're winning on price point and volume, not profitability per unit, reinforcing that revenue and profit
are different stories.
Q9: Top 5 most frequently purchased products
The EcoTrek Water Bottle dominates by unit volume (11 sold), well ahead of the Expedition Tent (4 units). Combined with Q3's finding that
water bottles carry the highest margin, this product is a clear standout — high volume and high profitability.
Q10: Purchase count and most recent purchase per customer
Every customer's purchase history was compiled with count and most-recent-date. This is primarily a reference table for the sales team
rather than a single headline finding, but it surfaces which customers have been inactive longest — useful for a re-engagement campaign.
Customer Insights
Q11: Total spend by customer
Alex Roberts is the top spender at $1,009.95, narrowly ahead of Ava King ($989.95). Notably, three of the top five spenders are Gold or Silver
tier, but not exclusively — Emma Young (Bronze tier) still cracks the top 5, showing loyalty tier isn't a perfect predictor of spend.
Q12: Average rating by loyalty tier
Ratings are fairly close across tiers: Bronze 3.67, Gold 3.86, Silver 4.17, with unassigned ("None") customers averaging 4.0. Silver customers
rate products noticeably higher than Bronze, but the overall spread (about half a star) is modest — there's no strong correlation between
loyalty tier and rating behavior in this dataset. Higher-spending tiers are not simply happier customers.
Q13: Customers who purchased but never reviewed
No customers meet this criterion — every customer who has made a purchase has left at least one product review. This is a genuine finding,
not a query error: review coverage among purchasers is complete in the current dataset.
Q14: Customers with increased Q2 vs. Q1 spending
Customers were compared on quarter-over-quarter spend using conditional aggregation. [Insert specific names once your final query output
is confirmed — this section should list who increased and by how much, since that's directly actionable for a retention/upsell campaign.]
Q15: Gold tier favorite categories
Gold-tier purchase history was broken down by category to identify their top picks. [Insert your confirmed top category for Gold tier here —
useful for targeted marketing to your highest-value segment.]
Employee Performance
Q16: Total sales and transaction count by employee
Robert Taylor leads in total sales ($854.96 across 2 transactions), narrowly ahead of Jessica Davis. Most top performers averaged 2
transactions each in this dataset — a small sample, so this ranking should be treated as directional rather than definitive.
Q17: Average transaction value by employee
William White has the single highest average transaction value ($499.99), but only from 1 transaction — worth noting since Robert Taylor,
who led in total sales (Q16), ranks second here ($427.48) rather than first. This is the volume-vs-average distinction: a high total doesn't
guarantee the highest average, and vice versa.
Q18: Store report — manager, employee count, total sales
A per-store summary was built combining manager identification (via position lookup), headcount, and total sales. This gives management
a single-glance view of each store's staffing and performance side by side.
Q19: Stores above company-wide average salary
The company-wide average salary is $52,968.75. Four stores exceed this: Miami ($61,500 — notably higher than the rest), Chicago
($54,666.67), Boston ($53,833.33), and Seattle ($53,000). Miami stands out well above the others, worth investigating whether that reflects
role mix (e.g., no assistant managers hired yet) or regional pay differences.
Q20: Product performance matrix (Stars / Volume Drivers / Opportunities / Problems)
Products were classified by comparing individual sales volume and profit margin against company-wide averages. [Once you run your final
CTE version, summarize the distribution here — e.g., "X products are Stars, Y are Problems" — since the distribution across categories is the
real business insight, not just the classification method.]
Advanced Analysis
Q21: Management hierarchy report
A self-join on the employees table (matching each employee's manager_id to their manager's employee_id ) produced a full reporting-line
listing per store, from Store Manager down to Sales Associates. Store Managers correctly show no manager of their own (top of the
hierarchy).
Q22: Comprehensive loyalty tier analysis
Combining average transaction value, top purchased category, and review count per tier gives a full behavioral profile per segment. [Insert
your final run's numbers here — e.g., which tier has the highest average transaction, whether the "favorite category" differs meaningfully
across tiers, and which tier reviews most actively.]
Note: Sections in brackets should be completed with your own final query outputs once confirmed in pgAdmin — these are the results that
depend on your last few queries (Q14, Q15, Q20, Q22), which should be re-run and finalized before submission.