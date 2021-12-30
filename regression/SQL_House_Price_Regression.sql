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
select * from `regression_data_regression_data1-3`;

show variables like 'local_infile';
set global local_infile = 1;
-- Step 2
show variables like 'secure_file_priv'; -- this gives you the path you need to save the .csv to
-- Step 3
set sql_safe_updates = 0;
#set secure_file_priv= /Users/juliaeinhausen/Documents/Ironhack/labs/mid bootcamp project/regression/;

#select * from 

alter table `regression_data_regression_data1-3`
drop column date;
alter table ahouse_price_data
rename to house_price_data;
select * from house_price_data
limit 10;

select count(*) from house_price_data; 
#19519 rows in whole table

#   - What are the unique values in the column `bedrooms`?
select distinct bedrooms as unique_bedrooms from house_price_data
order by unique_bedrooms;

select * from house_price_data
where bedrooms= 33 or bedrooms=10 or bedrooms=11 or bedrooms=9;

#    - What are the unique values in the column `bathrooms`?
select distinct bathrooms unique_bathrooms from house_price_data
order by unique_bathrooms;
select * from house_price_data
where bathrooms > 4;
#    - What are the unique values in the column `floors`?

select distinct floors from house_price_data
order by floors;
#    - What are the unique values in the column `condition`?

select distinct `condition` from house_price_data
order by `condition`;
#    - What are the unique values in the column `grade`?
select distinct grade from house_price_data
order by grade;

#8.  Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses 
#in your data.

#select * from house_price_data 
select id from house_price_data
order by price desc
limit 10;

#9.  What is the average price of all the properties in your data?

select avg(price) from house_price_data;


#10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data

#    - What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and 
#      Average of the prices. Use an alias to change the name of the second column.
select bedrooms, avg(price) as AveragePriceDepOnBedrooms from house_price_data
group by bedrooms
order by bedrooms;


#    - What is the average `sqft_living` of the houses grouped by bedrooms? The returned result should have only two columns, 
#      bedrooms and Average of the `sqft_living`. Use an alias to change the name of the second column.
select bedrooms, avg(sqft_living) as AverageSqfLivingDepOnBedrooms from house_price_data
group by bedrooms
order by bedrooms;

#    - What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only 
#      two columns, waterfront and `Average` of the prices. Use an alias to change the name of the second column.

select waterfront, avg(price) as AveragePriceDepOnWaterfront from house_price_data
group by waterfront;
#    - Is there any correlation between the columns `condition` and `grade`? You can analyse this by grouping the data by one of the 
#     variables and then aggregating the results of the other column. Visually check if there is a positive correlation or 
#     negative correlation or no correlation between the variables.

select `condition`, avg(grade)as AverageGradeDepOnCondition  from house_price_data
group by `condition`
order by `condition`;
# there is not a strictly negative correlation between the two variables
select grade, avg(`condition`) as AverageConditionDepOnGrade  from house_price_data
group by grade
order by grade;

#        You might also have to check the number of houses in each category (ie number of houses for a given `condition`) 
#        to assess if that category is well represented in the dataset to include it in your analysis. For eg. If the category is 
#        under-represented as compared to other categories, ignore that category in this analysis

select bedrooms, count(*) as Number_Bedrooms from house_price_data
group by bedrooms
having Number_Bedrooms > 30
order by bedrooms;

# -> from bedrooms=7 or 8 on bedrooms values are underrepresentated
#bedroom=7 (count=29), bedrooms=8 (count=11), bedrooms=9 (count=4), bedrooms=10 (count=3), bedrooms=11 (count=1), bedrooms=33 (count=1)
#so erase those columns? or put them together in bedrooms>6
select bathrooms , count(*)from house_price_data
group by bathrooms
order by bathrooms; # put together bathroom<1(count=4+66), 1-2, 2-3, 3-4, 4-5 , >5


select sqft_living, count(*) from house_price_data
group by sqft_living
order by sqft_living; # continious data: put togther into groups: <800, 800-1200, 1200-1600, 1600-2000, 2000-2400, 2400-2800, 2800-3200
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
order by sqft_above; # because, this is rather continious data, don`t erase underrepresented values!? or drop the whole collumn!

select sqft_basement, count(*) from house_price_data
group by sqft_basement
order by sqft_basement; # sqft_basement=0 (count=11852) all theother valueshave low counts, also drop the collumn? Or is there a way to group the
# other sqft_basement >0 maybe in small medium and big sqft_basement category

select yr_built, count(*) from house_price_data
group by yr_built
order by yr_built; # maybe group it in decades

select yr_renovated, count(*) from house_price_data
group by yr_renovated
order by yr_renovated; # most (count=18760) have no renovation, group by no renovation , renovation long ago, and renovation in last 20 years

select zipcode, count(*) from house_price_data
group by zipcode
order by zipcode;

select zipcode, count(*) as Number_  from house_price_data
group by zipcode
having min(Number_); # doesn`t return values

select lat, count(*) from house_price_data
group by lat
order by lat; #probabely drop this column, because they have  all small counts and the location is allready representated by the zipcode

select `long`, count(*) from house_price_data
group by `long`
order by `long`; # the same argumentation as for lat above.

select sqft_living15, count(*) from house_price_data
group by sqft_living15
order by sqft_living15; # the values are continious and need to be put in groups by small small/medium medium medium/big and big size

select sqft_lot15, count(*) from house_price_data
group by sqft_lot15
order by sqft_lot15; # also put the continious values into groups 

select price, count(*) from house_price_data
group by price
order by price; #target values... continious

# Conclusion on droping data: drop columns long and lat and other alter, so they are configured as groups

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

select avg(price) from house_price_data
group by bedrooms
having bedrooms = 3 or bedrooms = 4;

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





