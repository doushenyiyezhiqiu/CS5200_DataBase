USE ap;
START TRANSACTION;
  

INSERT INTO invoices
VALUES (116, 34, 'ZXA-080', '2015-01-18', 
        14092.59, 0, 0, 3, '2015-04-18', NULL);
        
SELECT * FROM invoices WHERE invoice_id = 116; 
ROLLBACK;
SELECT * FROM invoices WHERE invoice_id = 116; 