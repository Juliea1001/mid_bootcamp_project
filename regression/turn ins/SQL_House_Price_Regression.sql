#1. database house_price_regression has been imported with the tabla data import wizard
show variables like 'local_infile';
Set global local_infile=1;
use house_price_regression;
drop table if exists house_price_data;
CREATE TABLE house_price_data (
  `id` bigint UNIQUE NOT NULL, -- AS PRIMARY KEY
  `date` datetime ,
  `bedrooms` int DEFAULT NULL, 
  `bathrooms` decimal(10,5) DEFAULT NULL,
  `sqft_living` decimal (5,2) DEFAULT NULL,
  `sqft_lot` decimal (5,2) DEFAULT NULL,
  `floors` float DEFAULT NULL,
  `waterfront` int DEFAULT NULL,
  `view` int DEFAULT NULL,
  `condition` int DEFAULT NULL,
  `grade` int DEFAULT NULL,
  `sqft_above` int DEFAULT NULL,
  `sqft_basement` int DEFAULT NULL,
  `yr_built` int DEFAULT NULL,
  `yr_renovated` int DEFAULT NULL,
  `zipcode` int DEFAULT NULL,
  `lat` decimal (5,2) DEFAULT NULL,
  `long` decimal(10,5) DEFAULT NULL,
  `sqft_living15` int DEFAULT NULL,
  `sqft_lot15` int DEFAULT NULL,
  `price` bigint DEFAULT NULL,
  
  
  CONSTRAINT PRIMARY KEY (id)-- constraint keyword is optional but its a good practice
);

#4.
select * from `regression_data_regression_data1-3`;

show variables like 'local_infile';
set global local_infile = 1;
show variables like 'secure_file_priv'; -- this gives you the path you need to save the .csv to
set sql_safe_updates = 0;
#set secure_file_priv= /Users/juliaeinhausen/Documents/Ironhack/labs/mid bootcamp project/regression/;

#5.
alter table `regression_data_regression_data1-3`
drop column date;
alter table ahouse_price_data
rename to house_price_data;
select * from house_price_data
limit 10;

#6.
select count(*) from house_price_data; 
#19519 rows in whole table

# 7
# What are the unique values in the column `bedrooms`?
select distinct bedrooms as unique_bedrooms from house_price_data
order by unique_bedrooms;
#1,2,3,4,5,6,7,8,9,10,11,33

select * from house_price_data
where bedrooms= 33 or bedrooms=10 or bedrooms=11 or bedrooms=9;

#    - What are the unique values in the column `bathrooms`?
select distinct bathrooms unique_bathrooms from house_price_data
order by unique_bathrooms;
#'0,5''0,75''1''1,25''1,5''1,75''2''2,25''2,5''2,75''3''3,25''3,5''3,75''4''4,25''4,5''4,75''5''5,25''5,5'
#'5,75''6''6,25''6,5''6,75''7,5''7,75''8'
select * from house_price_data
where bathrooms > 4;

#    - What are the unique values in the column `floors`?

select distinct floors from house_price_data
order by floors;
#1,2,3

#    - What are the unique values in the column `condition`?

select distinct `condition` from house_price_data
order by `condition`;
#1,2,3,4,5

#    - What are the unique values in the column `grade`?
select distinct grade from house_price_data
order by grade;
#3,4,5,6,7,8,9,10,11,12,13

#8.  Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most 
#expensive houses in your data.

#select * from house_price_data 
select id from house_price_data
order by price desc
limit 10;

#9.  What is the average price of all the properties in your data?
select avg(price) from house_price_data;
#534034.1931


#10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data

#    - What is the average price of the houses grouped by bedrooms? The returned result should have only 
# two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.
select bedrooms, avg(price) as AveragePriceDepOnBedrooms from house_price_data
group by bedrooms
order by bedrooms;


# - What is the average `sqft_living` of the houses grouped by bedrooms? The returned result should have only two columns, 
#  bedrooms and Average of the `sqft_living`. Use an alias to change the name of the second column.
select bedrooms, avg(sqft_living) as AverageSqfLivingDepOnBedrooms from house_price_data
group by bedrooms
order by bedrooms;

# - What is the average price of the houses with a waterfront and without a waterfront? The returned result 
# should have only two columns, waterfront and `Average` of the prices. Use an alias to change the name of 
# the second column.

select waterfront, avg(price) as AveragePriceDepOnWaterfront from house_price_data
group by waterfront;
#Is there any correlation between the columns `condition` and `grade`? You can analyse this by grouping the 
# data by one of the variables and then aggregating the results of the other column. Visually check if there 
# is a positive correlation or negative correlation or no correlation between the variables.

select `condition`, avg(grade)as AverageGradeDepOnCondition  from house_price_data
group by `condition`
order by `condition`;
# there is neither  a strictly negative nor strictly positive correlation between the two variables.
select grade, avg(`condition`) as AverageConditionDepOnGrade  from house_price_data
group by grade
order by grade;
#rather a negative correlation, but not strictly.

# You might also have to check the number of houses in each category (ie number of houses for a given `condition`) 
# to assess if that category is well represented in the dataset to include it in your analysis. For eg. If the category is 
# under-represented as compared to other categories, ignore that category in this analysis

select bedrooms, count(*) as Number_Bedrooms from house_price_data
group by bedrooms
having Number_Bedrooms > 30
order by bedrooms;

# -> from bedrooms=7 or 8 on bedrooms values are underrepresentated
#bedroom=7 (count=29), bedrooms=8 (count=11), bedrooms=9 (count=4), bedrooms=10 (count=3), bedrooms=11 (count=1), bedrooms=33 (count=1)
#maybe put them together in 'bedrooms > 6'
select bathrooms , count(*)from house_price_data
group by bathrooms
order by bathrooms; 


select sqft_living, count(*) from house_price_data
group by sqft_living
order by sqft_living; # continious data: maybe put together into groups: <800, 800-1200, 1200-1600, 1600-2000, 
#2000-2400, 2400-2800, 2800-3200
# 3200- 3600, 3600-4000, >4000

select floors, count(*) from house_price_data
group by floors
order by floors;

select waterfront, count(*) from house_price_data
group by waterfront
order by waterfront;

select view, count(*) from house_price_data
group by view
order by view;

select `condition`, count(*) from house_price_data
group by `condition`
order by `condition`;

select grade, count(*) from house_price_data
group by grade
order by grade;

#grade= 3 (count=1), grade=4 (count=25), grade=12 (count=86), grade=13 (count=10)

select sqft_above, count(*) from house_price_data
group by sqft_above
order by sqft_above; # because, this is rather continious data, don`t erase underrepresented values!

select sqft_basement, count(*) from house_price_data
group by sqft_basement
order by sqft_basement; # sqft_basement=0 (count=11852) all the other values have low counts. Maybe group
# other sqft_basement >0 maybe in 'small', 'medium' and 'big sqft_basement' category

select yr_built, count(*) from house_price_data
group by yr_built
order by yr_built; # maybe group it in decades

select yr_renovated, count(*) from house_price_data
group by yr_renovated
order by yr_renovated; # most (count=18760) have no renovation, group by 'no renovation' , 'renovation long ago', 
# and 'renovation in last 20 years'.

select zipcode, count(*) from house_price_data
group by zipcode
order by zipcode;

select zipcode, count(*) as Number_  from house_price_data
group by zipcode
having min(Number_); # doesn`t return values

select lat, count(*) from house_price_data
group by lat
order by lat; #continious data 

select `long`, count(*) from house_price_data
group by `long`
order by `long`; # continious data

select sqft_living15, count(*) from house_price_data
group by sqft_living15
order by sqft_living15; 

select sqft_lot15, count(*) from house_price_data
group by sqft_lot15
order by sqft_lot15; 

select price, count(*) from house_price_data
group by price
order by price; #target values... continious


#11. One of the customers is only interested in the following houses:

 #   - Number of bedrooms either 3 or 4
 #   - Bathrooms more than 3
 #   - One Floor
 #   - No waterfront
 #   - Condition should be 3 at least
 #   - Grade should be 5 at least
 #   - Price less than 300000

 #   For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?
select * from house_price_data
where bedrooms in(3,4)
and bathrooms>3
and floors=1 and waterfront=0
and `condition` >2 and grade >4
and price <300000;
#there is no house fullfilling all in one the demands of the customers.

#12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties 
#in the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.

select * from house_price_data 
where price >= 2*(select avg(price) from house_price_data);

#13. Since this is something that the senior management is regularly interested in, create a view called 
#`Houses_with_higher_than_double_average_price` of the same query.
create view  Houses_with_higher_than_double_average_price as
select * from house_price_data 
where price >= 2*(select avg(price) from house_price_data);

#14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of 
#the properties with three and four bedrooms? In this case you can simply use a group by to check the prices for those 
#particular houses

select bedrooms, avg(price) from house_price_data
group by bedrooms
having bedrooms = 3 or bedrooms = 4;
#'3','459385.5755'
#'4','635435.7457'


#15. What are the different locations where properties are available in your database? (distinct zip codes)

select distinct zipcode from house_price_data;

#16. Show the list of all the properties that were renovated.

select * from house_price_data
where yr_renovated >0;


#17. Provide the details of the property that is the 11th most expensive property in your database.
select * from
(select * from house_price_data
order by price desc
limit 11) sub1
order by price asc
limit 1;





