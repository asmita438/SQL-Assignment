
CREATE DATABASE ecommerce;

USE ecommerce;

select * from product

--Select all products with brand �Cacti Plus�
select * from product
	where brand='Cacti Plus'

--Count of total products with product category=�Skin Care�
select COUNT(*) from product
	where category='Skin Care'

--Count of total products with MRP more than 100
select COUNT(*) from product
	where mrp>100

--Count of total products with product category=�Skin Care� and MRP more than 100
select COUNT(*) from product
	where category='Skin Care' and mrp>100

--Brandwise product count
select brand, COUNT(*) from product
	group by brand

--Brandwise as well as Active/Inactive Status wise product count
select brand, active, COUNT(*) from product
	group by brand, active

--Display all columns with Product category in Skin Care or Hair Care
select * from product
	where category = 'Skin Care' or category= 'Hair Care'

--Display all columns with Product category in Skin Care or Hair Care, and MRP more than 100
select * from product
	where (category = 'Skin Care' or category= 'Hair Care') and  mrp>100

--Display   all   columns   with   Product   category=�Skin   Care� and Brand=�Pondy�, and MRP more than 100
select * from product
	where (category = 'Skin Care' and brand='Pondy') and  mrp>100

--Display   all   columns   with   Product   category   =�Skin   Care� or Brand=�Pondy�, and more than 100
select * from product
	where (category = 'Skin Care' or brand='Pondy') and  mrp>100

--Display all product names only with names starting from letter P
select product_name from product
	where product_name like 'P%'

--Display  all product  names only with names Having letters �Bar�  in Between
select product_name from product
	where product_name like '%Bar%'

select * from sales
	
--Sales of those products which have been sold in more than two quantity in a bill
select * from sales
	where qty>2

--Sales of those products which have been sold in more than two quantity throughout the bill
select product_id, SUM(qty) quantity from sales
group by product_id having SUM(qty)>2


--Create a new table with columns username and birthday, and dump data from dates file. Convert it to .csv format if required.
CREATE TABLE userBirthDate (
  username   varchar(20),
  birthday   date,
);

BULK INSERT dbo.userBirthDate
FROM 'C:\Users\asmit\Downloads\dates.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR ='\n'
)

select * from userBirthDate

--find no of people sharing Birth date
select COUNT(username) from userBirthDate
where birthday IN (
  select birthday FROM userBirthDate
  group by birthday
  having COUNT(birthday) > 1
)

--find no of people sharing Birth month
select birthday, MONTH(birthday) birthmonth from userBirthDate

--find no of people sharing Weekday
select COUNT(username), DATENAME(weekday, GETDATE()) as WEEKDAY from userBirthDate

--Find the current age of all people
select *, DATEDIFF(year, birthday, GETDATE()) Age from userBirthDate