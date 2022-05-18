USE ap;
-- 1. Get all invoices greater than the average invoice total
SELECT *
FROM invoices
WHERE invoice_total > 
    (SELECT AVG(invoice_total)
     FROM invoices)
ORDER BY invoice_total;

-- 2. Find all invoices for vendors from New Jersey. 
-- Provide the invoice number, invoice date and invoice total in the result

SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE vendor_id IN
    (SELECT vendor_id
     FROM vendors
     WHERE vendor_state = 'NJ')
ORDER BY invoice_date;

-- 3. Get all invoices amount that's greater than the vendor's average invoice total  
-- Provide the invoice number, invoice date and invoice total in the result
SELECT vendor_id, invoice_number, invoice_total
FROM invoices i
WHERE invoice_total >
    (SELECT AVG(invoice_total)
     FROM invoices
     WHERE vendor_id = i.vendor_id)
ORDER BY vendor_id, invoice_total;


-- 4. Get invoices that are larger than the largest invoice for vendor 34 
SELECT vendor_name, invoice_number, invoice_total
FROM invoices i JOIN vendors v ON i.vendor_id = v.vendor_id
WHERE invoice_total > ALL
    (SELECT invoice_total
     FROM invoices
     WHERE vendor_id = 34)
ORDER BY vendor_name;

-- 5. Get invoices that are smaller than any invoice for vendor 34 
SELECT vendor_name, invoice_number, invoice_total
FROM invoices i JOIN vendors v ON i.vendor_id = v.vendor_id
WHERE invoice_total < ANY
    (SELECT invoice_total
     FROM invoices
     WHERE vendor_id = 34)
ORDER BY vendor_name;

-- 6. Use the EXISTS clause to find vendors without any invoices 
SELECT * FROM vendors WHERE NOT EXISTS 
 ( SELECT * FROM invoices WHERE invoices.vendor_id = vendors.vendor_id ) ;
 
 -- 7. Get the largest invoice_total  for each state 
 
 SELECT max(invoice_total), vendor_state 
      FROM invoices JOIN vendors using(vendor_id)
       group by vendor_state; 
 
 -- 8. For each state, get the largest sum of the  vendors' invoice total
        
        
SELECT vendor_state, vendor_name, SUM(invoice_total) as vendor_total
      FROM invoices JOIN vendors USING(vendor_id) 
      GROUP BY vendor_name
	;
    
	SELECT vendor_state, MAX(t.vendor_total) AS max_vendor_total FROM 
    ( 
	SELECT vendor_state, vendor_name, SUM(invoice_total) as vendor_total
      FROM invoices JOIN vendors USING(vendor_id) 
      GROUP BY vendor_state, vendor_name )  AS t gROUP BY vendor_state; 
            SELECT vendor_state,  
                   MAX(sum_of_invoices) AS max_sum_of_invoices
            FROM
            (
                 -- invoice totals by vendor
                 SELECT vendor_state, vendor_name,
                     SUM(invoice_total) AS sum_of_invoices
                 FROM vendors v JOIN invoices i 
                     ON v.vendor_id = i.vendor_id
                 GROUP BY vendor_state, vendor_name
            ) AS t2
            GROUP BY vendor_state;