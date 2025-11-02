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
select * from walmart_shopping

select payment_method,count(*) as number_of_transaction,sum(quantity) as quantity_sold
from walmart_shopping
group by payment_method;

-- Q2 Identify the highest rated category in each branch, displaying

select * 
from 
(
select 
	branch,
	category,
	avg(rating) as avg_rating,
	rank() over(partition by branch order by avg(rating) desc) as rank
from walmart_shopping
group by 1,2
)
where rank = 1;

-- Q3 Identify the busiest day for each branch based on the nuumber if transactions
select * from(
select 
	branch,
	to_char(to_date(date, 'DD/MM/YY'),'Day') as day_name,
	count(*) as no_transactions,
	rank() over(partition by branch order by count(*) desc) as rank
from walmart_shopping
group by 1,2
order by 1,3 desc
)
where rank = 1

-- Q4 Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.

select 
	payment_method,
	count(*) as no_payments,
	sum(quantity) as no_qty_sold
from walmart_shopping
group by payment_method

-- Q5 Determine the average, minimum and maximum rating of category for each city
-- list the city, average_rating, min_rating, and max_rating

select 
	city,
	category,
	min(rating) as min_rating,
	max(rating) as max_rating,
	avg(rating) as avg_rating
from walmart_shopping
group by 1,2

-- Q6 calculate the total profit for each category by considering total_profit as
-- unit_price * quantity * profit_margin
-- list category and totall_profit, ordered from highest to lowest profit

select 
	category,
	sum(total * profit_margin) as profit
from walmart_shopping
group by 1


-- Q7 Determine the common payment method for each branch
-- Display branch and the preferred_payment_method


with cte
as
(select 
		branch,
		payment_method,
		count(*) total_trans,
		rank() over(partition by branch order by count(*) desc) as rank
from walmart_shopping
group by 1,2
)
select *
from cte
where rank = 1


-- Q8 categorize sales into 3 groups MORNING,AFTERNOON,EVENING
-- Find out of the shift and number of invoices
select branch,
case 
	when extract(hour from(time::time)) < 12 then 'Morning'
	when extract(hour from(time::time)) between 12 and 17 then 'Afternoon'
	else 'Evening'
	end day_time,
	count(*)
from walmart_shopping
group by 1, 2
order by 1, 3 desc
	







