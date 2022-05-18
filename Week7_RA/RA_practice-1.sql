-- Query to Relational algebra 

use ap;

-- q1
SELECT invoice_id, invoice_date, invoice_total FROM inovices;




-- q2
SELECT * FROM invoices;




-- q3
SELECT * FROM vendors WHERE vendor_id = 7;




-- q 3 A
SELECT invoice_id, invoice_date, invoice_total FROM invices
                  WHERE vendor_id =7;


-- q4
SELECT * FROM vendors WHERE vendor_id >= 7 AND  vendor_id <= 20;

-- Q5
SELECT * FROM invoices INNER JOIN vendors
  ON invoices.vendor_id = vendors.vendor_id;

-- q5 A
SELECT 
    vendor_name,
    vendors.vendor_id
FROM
    vendors
        LEFT JOIN
    invoices ON invoices.vendor_id = vendors.vendor_id
ORDER BY sum(payment_total);

-- q6
SELECT 
    i.*, vendor_name
FROM
    invoices AS i
        JOIN
    vendors AS v ON v.vendor_id = i.vendor_id
WHERE
    vendor_name LIKE 'P%';





-- q7 
SELECT sum(payment_total) FROM invoices; 





-- q8
SELECT vendor_id, last_name, first_name FROM vendor_contacts 
UNION 
SELECT vendor_id, vendor_contact_last_name, vendor_contact_first_name FROM vendors ORDER BY vendor_id;



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







-- q 10 
SELECT invoice_id, vendor_name, invoice_total FROM invoices NATURAL 
   JOIN vendors;
 
 
 
 
 
 -- q 11 
SELECT invoice_id, vendor_name, invoice_total FROM invoices JOIN vendors;


