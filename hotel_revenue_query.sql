SELECT *
FROM dbo.['2018$'] ;

SELECT *
FROM dbo.['2019$'] ;

SELECT * 
FROM dbo.['2020$'] ;

-- Unite all the table into one 

SELECT *
FROM dbo.['2018$']
UNION
SELECT *
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'];

-- EXploratory Data Analysis (EDA)

-- Problem statement 1 : 
		-- IS hotel revenue is growing ?

-- create a new table
with hotels as 
	( SELECT *
	FROM dbo.['2018$']
	UNION
	SELECT *
	FROM dbo.['2019$']
	UNION
	SELECT *
	FROM dbo.['2020$'] )
SELECT *
FROM hotels ;




-- Create new column by adding stays_in_weekend_nights and stays_in_week_nights 
-- and multiply with adr (daily rate of hotel)
with hotels as 
	( SELECT *
	FROM dbo.['2018$']
	UNION
	SELECT *
	FROM dbo.['2019$']
	UNION
	SELECT *
	FROM dbo.['2020$'] )
SELECT 
	(stays_in_week_nights + stays_in_weekend_nights )* adr as revenue
FROM
	hotels ;

-- Create a new table with arrival_date_year for identifying the hotel revenue
with hotels as 
	( SELECT *
	FROM dbo.['2018$']
	UNION
	SELECT *
	FROM dbo.['2019$']
	UNION
	SELECT *
	FROM dbo.['2020$'] )

SELECT 
	arrival_date_year ,
	(stays_in_week_nights + stays_in_weekend_nights )* adr as revenue
FROM
	hotels ;

-- Group by sum of arrival year for trend patterns

with hotels as 
	( SELECT *
	FROM dbo.['2018$']
	UNION
	SELECT *
	FROM dbo.['2019$']
	UNION
	SELECT *
	FROM dbo.['2020$'] )

SELECT 
	arrival_date_year ,
	SUM ((stays_in_week_nights + stays_in_weekend_nights )* adr) as revenue
FROM
	hotels 
GROUP BY arrival_date_year ;

-- Revenue  by hotel types


with hotels as 
	( SELECT *
	FROM dbo.['2018$']
	UNION
	SELECT *
	FROM dbo.['2019$']
	UNION
	SELECT *
	FROM dbo.['2020$'] )

SELECT 
	arrival_date_year ,
	hotel,
	ROUND(SUM ((stays_in_week_nights + stays_in_weekend_nights )* adr),2) as revenue
FROM
	hotels 
GROUP BY arrival_date_year , hotel ;

-- Discount regarding market_segment

SELECT *
FROM dbo.market_segment$ ;

-- Join the column by using market_segment

with hotels as 
	( SELECT *
	FROM dbo.['2018$']
	UNION
	SELECT *
	FROM dbo.['2019$']
	UNION
	SELECT *
	FROM dbo.['2020$'] )

SELECT *
FROM hotels 
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment ;

-- Meals cost
SELECT *
FROM meal_cost$ ;

-- join the meals table column

with hotels as 
	( SELECT *
	FROM dbo.['2018$']
	UNION
	SELECT *
	FROM dbo.['2019$']
	UNION
	SELECT *
	FROM dbo.['2020$'] )

SELECT *
FROM hotels 
	left join dbo.market_segment$
	on hotels.market_segment = market_segment$.market_segment 
	left join dbo.meal_cost$ 
	on meal_cost$.meal = hotels.meal ;
