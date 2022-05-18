USE ap;
-- 1. Get all invoices greater than the average invoice total

select * from invoices where invoice_total>(select avg(invoice_total) from invoices);

-- 2. Find all invoices for vendors from New Jersey. 
-- Provide the invoice number, invoice date and invoice total in the result

select * from invoices where vendor_id in (select vendor_id from vendors where vendor_state='NJ');

select invoice_number, invoice_date, invoice_total from invoices join vendors using(vendor_id) where vendor_state='NJ';

-- 3. Get all invoices amount that's greater than the vendor's average invoice total  
-- Provide the invoice number, invoice date and invoice total in the result

select invoice_number, invoice_date, invoice_total from invoices where invoice_total>(select avg(invoice_total) from invoices);

-- 4. Get invoices that are larger than the largest invoice for vendor 34 

select * from invoices where invoice_total>(select max(invoice_total) from invoices where vendor_id=34);

select * from invoices where invoice_total> all(select invoice_total from invoices where vendor_id=34);

-- 5. Get invoices that are smaller than any invoice for vendor 34 

select * from invoices where invoice_total<(select min(invoice_total) from invoices where vendor_id=34);

select * from invoices where invoice_total< any(select invoice_total from invoices where vendor_id=34);


-- 6. Use the EXISTS clause to find vendors without any invoices 
 
 select * from vendors where vendor_id not in (select distinct vendor_id from invoices);
 
 select i.vendor_id, v.* from vendors v left join invoices i using(vendor_id) where i.vendor_id is null;
 
 select * from vendors where not exists (select * from invoices where vendors.vendor_id = invoices.vendor_id);
 
 -- 7. Get the largest invoice_total for each state 
select v.vendor_state, max(i.invoice_total) from vendors v join invoices i using(vendor_id) group by v.vendor_state;

-- for each state, get the largest sum of the vendors' invoice total
select vendor_state, sum(vendor_total) from (select vendor_state, vendor_name, sum(invoice_total) as vendor_total from invoices join vendors using (vendor_id)) group by vendor_state, vendor_name;

select vendor_state, vendor_name, sum(invoice_total) as vendor_total from invoices join vendors using(vendor_id) group by vendor_name;