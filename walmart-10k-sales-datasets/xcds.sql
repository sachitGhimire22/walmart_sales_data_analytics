-- How many distinct payment type there are?
select payment_method,
count(*)
from walmart_shopping
group by payment_method;

-- How many diferent stores are there?

select 
count(distinct branch)
from walmart_shopping

-- whats the maximum quantity
select max(quantity) from walmart_shopping

-- Business Problems 
-- Q1 Find different payment method and number of transactions ,number of quantity sold


select payment_method,count(*) as number_of_transaction,sum(quantity) as quantity_sold
from walmart_shopping
group by payment_method;

-- Q2 Identify the highest rated category in each branch, displaying the branch, category, avg rating

select * from walmart_shopping

select 
	branch,
	category,
	avg(rating) as avg_rating
from walmart_shopping
group by branch,category
order by 1,3 desc


SELECT branch, category, avg_rating
FROM (
    SELECT 
        branch,
        category,
        AVG(rating) AS avg_rating,
        ROW_NUMBER() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rn
    FROM walmart_shopping
    GROUP BY branch, category
) ranked
WHERE rn = 1;

















