/* the syntax for the SELECT command
SELECT field_list
FROM table
WHERE condition_true  ORDER BY order_field_list  LIMIT num_tuples;

*/
use ap;

/* let's walk through some commands that we have 
   Covering Chapter 3, 4, 6 in Murach's MySQL

*/


-- simple SELECT to extract a subset of the columns 
-- invoice_id, invoice_date and invoice_total from the invoices

select invoice_id, invoice_date, invoice_total from invoices;

-- we can do computations on the fields returned to change the value returned
-- let's return the invoice_id, the payment date, the invoice_due_date and the difference
-- between the 2 dates. 

-- the name of that column is a bit ugly - we can use the AS keyword
-- to give it a better name

   -- we can alias or use AS for any field 
   
   
   -- LET's order the invoices by due date
   
   select * from invoices order by invoice_date desc;
   
   -- defaults to ASC or ascending order
   select * from invoices order by invoice_date asc;

     
-- YOU CAN ORDER BY MORE THAN 1 FIELD

select * from invoices order by invoice_date asc, payment_total desc;

-- Let's look at the LIMIT CLAUSE
-- we can use it determine the max # of tuples to be returned
select * from invoices order by invoice_date asc, payment_total desc limit 5,100;


 
 -- WHERE TO START;
 
 -- LET'S SAY I WANT ALL OF THE VENDOR IDS FROM THE INVOICES TABLE
 select vendor_id from invoices;
 
 
 -- is the result of this a relation?
 
 -- now let's limit results by values in the tuples
 -- we use the WHERE clause to do this
 -- return information for vendor_id 7
 select * from vendors where vendor_id=7;
 
 -- WRITE A QUERY THAT RETURNS ALL VENDORS FROM THE VENDOR TABLE 
 -- WHERE THE VENDOR_ID IS BETWEEN 7 AND 20
 
 select * from vendors where vendor_id>=7 and vendor_id<=20;
 
 -- AND KEYWORD is SQL STANDARD  '&&' is MySQL specific they are equivalent 
 -- we can rewrite this query using the BETWEEEN keyword
 select * from vendors where vendor_id between 7 and 20;


-- What if I wanted to find all vendors from MA or CT
select * from vendors where vendor_state='Ma' or vendor_state='CT';
-- I can also rewrite this to use the IN keyword
select * from vendors where vendor_state in ('Ma','CT');


-- WRITE A QUERY THAT RETURNS ALL VENDORS NOT FROM NEW ENGLAND
select * from vendors where vendor_state not in ('MA','CT','RI','VT','ME','NH');

-- What if I wanted all vendors whose name begins with A?
select * from vendors where vendor_name like 'A%';


-- DO I NEED TO CAPTILIZE THE A ?
-- aggregation
-- We can create aggregate queries that perform a function across tuples
-- the SQL standard operations we can perform are SUM, COUNT, MIN, MAX, AVG 
-- SELECT openation(field) FROM table;
-- find the amount paid for invoices 

select invoice_total from invoices;
select sum(invoice_total-payment_total) as invoice_owed from invoices;

select min(payment_total), max(payment_total) from invoices;

select count(vendor_id) from invoices;

select count(*) from invoices;

select count(distinct vendor_id) from invoices;

select count(payment_date) from invoices;

select vendor_id, sum(payment_total) as vendor_total from invoices group by vendor_id having vendor_total>1200 order by sum(payment_total) desc ;
-- GROUP BY keyword 

select vendor_id, sum(payment_total) as vendor_total from invoices group by vendor_id with rollup ;



-- it returns a single value for use
-- what if I wanted payment_total by the vendors 
-- I can use the GROUP BY clause to GROUP the invoices into groups 
-- groups are defined by the values of a specific field

-- Now let's say you are only interested in reporting vendors where the sum of the payment
-- is greater than $800 - you want to apply a filter to the results we just generated
-- the HAVING clause allows you to filter an AGGREGATED RESULT

  
  -- MYSQL does have an additional aggregate function called group_concat - 
  -- it produces a comma separate list of a string 
  
  select group_concat(vendor_state) from vendors;
  
  select group_concat(distinct vendor_city)n from vendors group by vendor_state;
  
  select vendor_city, vendor_state, count(vendor_zip_code) from vendors group by vendor_city, vendor_state;
  
  
-- So far we have been generating information from 1 table 
-- but useful information is across multiple tables
-- this schema seems to have some redundancy 
-- what if I want vendor contacts - it looks like I have this
-- information in the vendors table and the vendor contacts table
-- SELECT vendor_id, last_name, first_name FROM vendor_contacts ORDER BY vendor_id;
-- I CAN ALSO WRITE THE same query for the vendors table

-- SELECT vendor_id, vendor_contact_last_name, vendor_contact_first_name FROM vendors ORDER BY vendor_id;
-- WHAT I WANT TO DO IS GLUE THESE 2 RESULTS TOGETHER
-- union OPERATION DOES THIS FOR ME

-- I GET BACK 130 TUPLES so we can look at the duplicates 
-- 1 Select all fields and all tuples from the invoices table

-- there are no duplicates in this result each tuple was different due to the names

-- but what if there would be duplicates like

-- UNION removes the duplicates - makes sense since it is a SET operation
-- but what if you want the duplicates???
-- use the KEYWORD ALL


select vendor_id, vendor_contact_first_name, vendor_contact_last_name from vendors union select vendor_id, first_name, last_name from vendor_contacts;

select vendor_id from vendors
union
select vendor_id from invoices;


-- we can also use the JOIN operation to pull data from multiple tables
-- what if I want fields from different tables like the invoice total and the vendor name
-- in my result 
-- this is where we take advantage of our foreign keys 
-- SELECE field_list FROM table1 JOIN table2 ON table1.field1 = table2.field2;
-- this is knows as an inner join, we limit our result to tuples that satsfy the
-- ON clause 

select vendors.vendor_id, invoices.vendor_id, vendor_name, invoice_total from invoices inner join vendors on vendors.vendor_id= invoices.vendor_id join vendor_contacts on vendors.vendor_id= vendor_contacts.vendor_id;


select * from vendors natural join invoices;

-- what if I wanted vendor_id in the result? can I just add it to the field list

-- NO I generate an error need the table name to disambiguate the field 

-- what happens if I forget the ON clause let's do it between the vendor and the
-- vendor_contacts table


-- CROSS PRODUCT FOR EACH TUPLE IN ONE TABLE 
-- Implicit join
-- NOW there is another way to express a JOIN - the old fashion syntax
-- SELECT fieldlist FROM tablelist WHERE to restrict tuples;


  -- I get the same result as the result where I use the JOIN key word
  -- this is known as an implicit JOIN when you use the KEYWORD JOIN
  -- that is known as an explicit JOIN
  -- INDUSTRY EXPLECTS EXPLICIT JOINS 
  
  -- EXPLICIT JOINS 
  -- money gotten from vendors we would use our JOIN construct to
  -- report on vendors 

  
  -- rach tuple in the OUTER table must appear in my result 
  
  
  -- THE VALUES FOR THE FIELDS FROM THE TABLE WITHOUT A MATCH ARE SET TO null 
  -- now what if I just want the vendors who have no invoices
  
  
  -- there is also something known as a NATURAL JOIN 
 
  -- what is different in the structure of the result ??
  
  

-- Count the number of vendors  assign the result to a variable names num_vendors (AGGREGATION )
-- Count the number of invoices per vendor 
-- Calculate the total payment by vendor, return the vendor name and the total
-- Calculate the total payment by vendor, return the vendor id  and the total payment for vendor for vendors who paid more than $100


