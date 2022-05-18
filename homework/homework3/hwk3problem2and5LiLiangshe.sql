/**
2.a Three databases are created.
2.b (1) Database name: ap
        Tables: general_ledger_accounts, terms, vendors, invoices, invoice_line_items, vendor_contacts, invoice_archive
    (2) Database name: ex
        Tables: null_sample, departments, employees, projects, customers, color_sample, string_sample, float_sample, date_sample, active_invoices, paid_invoices
    (3) Database name: om
        Tables: customers, items, orders, order_details
2.c 68 records.
2.d 114 records.
2.e 122 records.
2.f Yes, there is a foreign key between the ap.invoices and the ap.vendors table, it is called vendor_id in both tables.
2.g Two.
2.h Customer_id is the promary key of the om.customers table.
**/

-- 2.i --
SELECT * FROM om.orders;

-- 2.j --
SELECT title, artist FROM om.items;

/**
5.a 11 tables are created.
5.b Album, artist, customer, employee, genre, invoice, invoiceline, mediatype, playlist, playlisttrack, track
5.c 347 records.
5.d AlbumId is the primary key.
**/

-- 5.e --
SELECT * FROM chinook.artist;

-- 5.f --
SELECT FirstName, LastName, Title from chinook.employee;