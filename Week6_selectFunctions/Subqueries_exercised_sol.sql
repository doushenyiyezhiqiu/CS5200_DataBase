use ap;

/* sometimes you want to compute the value to compare from thr DB */
/* we can achieve this with a nested query */
/* find all invoices above the average priced invoice */

SELECT avg(invoice_total) FROM invoices;

SELECT 
    *
FROM
    invoices
WHERE
    invoice_total >= (SELECT 
            AVG(invoice_total)
        FROM
            invoices);
 
 /* WHERE can a subquery appear ? */
 /* In a WHERE clause as a search condition
/* In the FROM clause as a table specification
In the SELECT clause as a column specification. 

The example above has the subquery in which clause ? */
/* how many values are returned ? */ 
/* are we limited to just that return shape ? */ 

/* Let's do an example IN THE where clause using IN */
/* FIND ALL invoices for vendors from california */

SELECT * from invoices where vendor_id IN 
 (select vendor_id from vendors WHERE 
    vendor_state = 'CA'); 
    
    /* CAN USE NOT IN AS WELL */
    /* SELECR VENDORS WITH NO INVOICES */
    
    SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE vendor_id NOT IN
    (SELECT DISTINCT vendor_id
     FROM invoices)
ORDER BY vendor_id;

/* OTHER METHOD WITH A JOIN */ 
SELECT v.vendor_id, vendor_name, vendor_state
FROM vendors v LEFT JOIN invoices i
    ON v.vendor_id = i.vendor_id
WHERE i.vendor_id IS NULL
ORDER BY v.vendor_id;

/* a subquery can return more than 1 value but most where clause predicates
   a written for 1 value to help with this disconnect we have 2 new keyowrds
   that can be used in front of a subquery ANY ALL */
   
   /* FIND ALL VENDORS WHOSE INVOICE TOTALS ARE ALL GREATER THAN 
      VENDOR NUMBER 34 */
   SELECT vendor_name, invoice_number, invoice_total
FROM invoices i JOIN vendors v ON i.vendor_id = v.vendor_id
WHERE invoice_total > ALL
    (SELECT invoice_total
     FROM invoices
     WHERE vendor_id = 34)
ORDER BY vendor_name;

/* IF WE ONLY WANT TO FIND AT LEAST ONE WE CAN USE THE ANY keyword */
   
   /* FIND ALL VENDORS WHOSE INVOICE TOTALS ARE ALL GREATER THAN 
      VENDOR NUMBER 34 */
   SELECT vendor_name, invoice_number, invoice_total
FROM invoices i JOIN vendors v ON i.vendor_id = v.vendor_id
WHERE invoice_total >  ANY
    (SELECT invoice_total
     FROM invoices
     WHERE vendor_id = 34)
ORDER BY vendor_name;

/* So far we have considered unorrelated queries - the
   subquery is computed first and the value(s) are passed to the
   outer query */
   
/* we can choose to correlate the inner and the outer query */
/* we found all invoices greater than the average - but what if you 
   want to group the invoices by the vendor and compute an average per
   vendor - we can do this with a correlated query */
SELECT vendor_id, invoice_number, invoice_total
FROM invoices i
WHERE invoice_total >
    (SELECT AVG(invoice_total)
     FROM invoices
     WHERE vendor_id = i.vendor_id)
ORDER BY vendor_id, invoice_total;

/* Sometimes you are not interested in the results from a subquery
   you only want to see if the subquery returns tuples 
   you can use the EXISTS keyword to test if you have a result */

/* Find vendors with no invoices using NOT EXISTS 
SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE NOT EXISTS
    (SELECT * 
     FROM invoices
     WHERE vendor_id = vendors.vendor_id);
     
/* SUBQUERY IN THE SELECT field CLAUSE */ 
/* YOU CAN COMPUTE ANY VALUE YOU WANT AS A RESULT FIELD */

select invoice_id, invoice_total, 
(SELECT AVG(invoice_total) FROM invoices) AS avg_invoice_total
FROM invoices; 

/* we can correlate the query 
   have the outer queries' table  affect the inner query */
SELECT vendor_name,
    (SELECT MAX(invoice_date) FROM invoices
     WHERE vendor_id = vendors.vendor_id) AS latest_inv
FROM vendors
ORDER BY latest_inv DESC;

/* QUERY IN THE FROM clause */ 
/* we can create results that we use as input into another 
   SQL operation - THIS APPROACH ALLOWS US TO USE 
   DIFFERENT DATA TRANSFORMATIONS TO get the results we want 
   WHEN we have a subquery in the FROM CLAUSE it must be assigned an alias */
   
/* compute the largest invoice per state */ 
SELECT vendor_state, MAX(sum_of_invoices) AS max_sum_of_invoices
FROM
(
     SELECT vendor_state, vendor_name,
         SUM(invoice_total) AS sum_of_invoices
     FROM vendors v JOIN invoices i 
         ON v.vendor_id = i.vendor_id
     GROUP BY vendor_state, vendor_name
) t
GROUP BY vendor_state
ORDER BY vendor_state;

/* in the example above we had 1 base table and 1 inline view (subquery result)
   and we performed a JOIN */
/* we can have more than 1 inline view in the FROM clause */

/* for each state find the vendor with the highest sum of invoices */
/* report the vendor, and the sum of the onvoices for the vendor wirh the 
   highest invoice toral */
/* t1 computes the total per vendor
   t2 computes the maximum amount per state 
   we JOIN them to find the max amount and the vendor per state */ 
SELECT t1.vendor_state, vendor_name, t1.sum_of_invoices
FROM
    (
        -- invoice totals by vendor
        SELECT vendor_state, vendor_name,
            SUM(invoice_total) AS sum_of_invoices
        FROM vendors v JOIN invoices i 
            ON v.vendor_id = i.vendor_id
        GROUP BY vendor_state, vendor_name
    ) t1
    JOIN
        (
            -- top invoice totals by state
            SELECT vendor_state,  
                   MAX(sum_of_invoices) AS sum_of_invoices
            FROM
            (
                 -- invoice totals by vendor
                 SELECT vendor_state, vendor_name,
                     SUM(invoice_total) AS sum_of_invoices
                 FROM vendors v JOIN invoices i 
                     ON v.vendor_id = i.vendor_id
                 GROUP BY vendor_state, vendor_name
            ) t2
            GROUP BY vendor_state
        ) t3
    ON t1.vendor_state = t3.vendor_state AND 
       t1.sum_of_invoices = t3.sum_of_invoices
ORDER BY vendor_state;

/* the above query can be rewritten with a common table experssion - each 
   subquery is given a name and then can be referenced in the following query */
   /* we would create 2 references tables using the WITH keyword */
   
   WITH summary AS
(
    SELECT vendor_state, vendor_name, SUM(invoice_total) AS sum_of_invoices
    FROM vendors v JOIN invoices i 
        ON v.vendor_id = i.vendor_id
    GROUP BY vendor_state, vendor_name
),
top_in_state AS
(
    SELECT vendor_state, MAX(sum_of_invoices) AS sum_of_invoices
    FROM summary
    GROUP BY vendor_state
)
SELECT summary.vendor_state, summary.vendor_name, top_in_state.sum_of_invoices
FROM summary JOIN top_in_state
    ON summary.vendor_state = top_in_state.vendor_state AND
       summary.sum_of_invoices = top_in_state.sum_of_invoices
ORDER BY summary.vendor_state;
 