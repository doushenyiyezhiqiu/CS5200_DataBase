
use ap;
-- function exercises
-- Q1
-- write a query that returns vendor sorted by vdendor_id alphabetically 
select * from vendors order by vendor_id asc;


-- Q2 
-- write a select statement to return 3 columns from the invoices table
-- the invoice total
-- ROUND the invoice_total to 1 decimal place
-- round to the nearest whole number (no decimal place)
-- round to nearest INTEGER using a different function

select round(invoice_total, 1), round(invoice_total), truncate(invoice_total, -1) from invoices;
-- Q3
-- WRITE A QUERY TO RETURN THE FOLLOWING COLUMNS FROM THE VENDORS TABLE
-- VENDOR NAME COL
-- VENDOR NAME COLUMN IN CAPITAL LETTERS
-- VENDOR PHONE NUMBER
-- COLUMN THAT DISPLAYS THE LAST FOUR DIGITS OF THE PHONE NUMBER
-- COLUMN THAT DISPLAY THE PHONE NUMBER WITH PERIODS BETWEEN THE 3 SECTIONS OF THE PHONE NUMBER 

select vendor_name, upper(vendor_name), vendor_phone, substring(vendor_phone, 11),replace(vendor_phone, ) from vendors;

-- Q4
-- RETURN THE CURRENT DATE, CURRENT TIME AND THE CURRENT DATE AND TIME 
select current_timestamp(),current_date(),current_time();

-- Q5
-- extract the year, month and day as well as the day of the week from the invoice_date

select invoice_date, month(invoice_date), year(invoice_date), 

-- Q6
-- ADD A COLUMN TO q5 that has 2 values "Weekday" or "weekend"  if the day of the week is Saturday or Sunday 
-- the value should be "weekend" or else it is set to "Weekday" -- also add the day of the week as a string
select if()

-- Q7
-- return the payment_date from invoices and a column with the value = "No payment" if no payment received
-- or else the column is set to the payment_date

select payment_date, ifnull(payment, "No payment") from invoices;

-- Q8 
-- add a rank value  to each row from the invoices table that is determined by the invoice_total 
--
select rank() over (order by invoice_total desc) as row_value,  from invoices;
