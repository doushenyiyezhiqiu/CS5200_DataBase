-- create a procedure named practice with the following signature
-- CREATE PROCEDURE practice ( 
-- IN test_val_p INT ,
-- OUT ret_val_p INT) 
-- it assigns  ret_val to 20 if test_value is 5
-- if the condition fails it assigns ret_val to 30 
use ap;

-- delimiter $$
-- create procedure practice(in test_val_p int,
-- 							out ret_val_p int)
-- begin
-- if test_val_p = 5 then
-- set ret_val_p = 20;
-- else
-- set ret_val_p = 30;
-- end if;

-- select ret_val_p;
-- end$$

-- delimiter ;
-- set @output=0;

-- call practice(5, @output);

-- select @output;

delimiter $$
create procedure practice2(
	in test_val_p int,
    out ret_val_p int)

begin

if test_val_p =5 then
	set ret_val_p =20;
else set ret_val_p=30;
end if;
end$$

delimiter ;

call practice2(5,@t);
select @t;

call practice2(10,@t);
select @t;


-- create a procedure that given an invoice_id returns the invoice_total
-- CREATE PROCEDURE get_invoice_total (
-- IN invoice_id_p INT ,
-- OUT invocie_total_p DECIMAL(9,2) ) 

delimiter $$
create procedure get_invoice_total (
	in invoice_id_p int,
    out invoice_total_p decimal(9,2))
begin
	declare local_v decimal(9,2);
    
    select invoice_total into invoice_total_p from invoices
		where invoice_id = invoice_id_p;
end $$

delimiter ;



-- create a procedure that gicen a vendor_id returns the invoices
-- for that vendor
-- CREATE PROCEDURE get_invoices( IN vendor_id_p INT ) 

delimiter $$
create procedure get_invoices(in vendor_id_p int)
begin

select * from invoices where vendor_id = vendor_id_p;

end $$

delimiter ;
