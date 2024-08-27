# string function
#1. Length
select length("helly");

select first_name, length(first_name) as letters from employeement_demographic;

#2.Upper and lower
select upper('sky'); #convert it into upper case
select lower('HELLY'); 	# convert it into lower case

#trim
select trim("             helly             ") as name; # remove spaces from left and right
select ltrim("           helly               "); #remove spaces from left side
select rtrim("          helly           "); # remove spaces from right side

# left and right use
select first_name,left(first_name,4),right(first_name,4)
 from employeement_demographic; # here left(first_name,4) means it will start from left then will take 4 cgaracter of first_name
 # here right means it will take 4 chharacter start from tye right side
 
 # Substring the most used string function
 
select first_name, birth_date,substring(birth_date,6,2) as birth_month from employeement_demographic;
# here substring(birth_date,6,2) means it will start from 6 position and then take two character 

# we can concat multiple row values into single value separated by comma
 GROUP_CONCAT
 GROUP_CONCAT(col1 separator ',')

# REPLACE 
select first_name, replace(first_name,'a','z')from employeement_demographic;
# it will replace first_name where small a is there it will replace it into z

#Locate
select locate('l','helly');
# it is showing l is in 3 position

select first_name,locate('an',first_name) from employeement_demographic;

# concat = it is used to join the strings
select first_name,last_name,concat(first_name,' ',last_name) as full_name from employeement_demographic;
