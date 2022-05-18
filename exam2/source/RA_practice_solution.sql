-- Queries to Relational algebra 
-- https://dev.mysql.com/doc/refman/8.0/en/functions.html
use ap;

-- q1
SELECT invoice_id, invoice_date, invoice_total FROM inovices;
-- π invoice_id, invoice_date, invoice_total (invoices);


-- q2
SELECT * FROM invoices;
-- (invoices)



-- q3
SELECT * FROM vendors WHERE vendor_id = 7;
-- σ vendor_id = 7 (vendors)



-- q 3 A
SELECT invoice_id, invoice_date, invoice_total FROM invoices
                  WHERE vendor_id =7;
-- π invoice_id, invoice_date, invoice_total(σ vendor_id = 7 (vendors))

-- q4
SELECT * FROM vendors WHERE vendor_id >= 7 AND  vendor_id <= 20;
-- σ vendor_id >= 7 ∧ vendor_id <=  20 (vendors)

-- Q5
SELECT * FROM invoices INNER JOIN vendors
  ON invoices.vendor_id = vendors.vendor_id;
-- invoices ⨝  invoices.vendor_id = vendors.vendor_id vendors


-- q5 A
SELECT 
    vendor_name,
    vendors.vendor_id
FROM
    vendors
        LEFT JOIN
    invoices ON invoices.vendor_id = vendors.vendor_id;

-- π vendor_name, vendors.vendor_id (vendors ⟕ invoices)


-- q6
SELECT 
    i.*, vendor_name
FROM
    invoices AS i
        JOIN
    vendors AS v ON v.vendor_id = i.vendor_id
WHERE
    vendor_name LIKE 'P%';

-- ρ(i, invoices)
-- ρ(v, vendors)
-- invoices ⨝ (π vendor_name, vendor_id ( σ vendor_namr LIKE 'P%' (vendors))) 



-- q7 
SELECT sum(payment_total) FROM invoices; 

-- 𝕱 sum, payment_total (invoices)




-- q8
SELECT vendor_id, last_name, first_name FROM vendor_contacts 
UNION 
SELECT vendor_id, vendor_contact_last_name, vendor_contact_first_name FROM vendors ORDER BY vendor_id;

-- π vendor_id, last_name, first_name (vendor_contacts)
-- ∪ 
-- π vendor_id, vendor_contact_last_name, vendor_contact_first_name (vendors)


-- q9 
SELECT 
    invoices.invoice_id,
    invoice_total,
    sum(line_item_amount) AS computed_total
FROM
    Invoice_line_items
        JOIN
    invoices ON invoices.invoice_id = invoice_line_items.invoice_id
GROUP BY invoices.invoice_id ,invoice_total; 

-- invoices.invoice_id, invoice_total 𝕱 sum, line_item_amount 
--                             (invoice_line_items ⨝ invoices) 






-- q 10 
SELECT invoice_id, vendor_name, invoice_total FROM invoices NATURAL 
   JOIN vendors;
 
-- π invoice_id, vendor_name, invoice_total (invoices x vendors)  
 
 
 
 -- q 11 
SELECT invoice_id, vendor_name, invoice_total FROM invoices JOIN vendors;


