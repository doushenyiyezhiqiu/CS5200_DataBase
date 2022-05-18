use ap;

/* sometimes you want to compute the value to compare from thr DB */
/* we can achieve this with a nested query */
/* find all invoices above the average priced invoice */


 /* WHERE can a subquery appear ? */
 /* In a WHERE clause as a search condition
/* In the FROM clause as a table specification
In the SELECT clause as a column specification. 

The example above has the subquery in which clause ? */
/* how many values are returned ? */ 
/* are we limited to just that return shape ? */ 

/* Let's do an example IN THE where clause using IN */
/* FIND ALL invoices for vendors from california */


    
    /* CAN USE NOT IN AS WELL */
    /* SELECR VENDORS WITH NO INVOICES */
    


/* OTHER METHOD WITH A JOIN */ 


/* a subquery can return more than 1 value but most where clause predicates
   a written for 1 value to help with this disconnect we have 2 new keyowrds
   that can be used in front of a subquery ANY ALL */
   
   /* FIND ALL VENDORS WHOSE INVOICE TOTALS ARE ALL GREATER THAN 
      VENDOR NUMBER 34 */
 

/* IF WE ONLY WANT TO FIND AT LEAST ONE WE CAN USE THE ANY keyword */
   
   /* FIND ALL VENDORS WHOSE INVOICE TOTALS ARE ALL GREATER THAN 
      VENDOR NUMBER 34 */
 

/* So far we have considered unorrelated queries - the
   subquery is computed first and the value(s) are passed to the
   outer query */
   
/* we can choose to correlate the inner and the outer query */
/* we found all invoices greater than the average - but what if you 
   want to group the invoices by the vendor and compute an average per
   vendor - we can do this with a correlated query */


/* Sometimes you are not interested in the results from a subquery
   you only want to see if the subquery returns tuples 
   you can use the EXISTS keyword to test if you have a result */

/* Find vendors with no invoices using NOT EXISTS */

     
/* SUBQUERY IN THE SELECT field CLAUSE */ 
/* YOU CAN COMPUTE ANY VALUE YOU WANT AS A RESULT FIELD */



/* we can correlate the query 
   have the outer queries' table  affect the inner query */


/* QUERY IN THE FROM clause */ 
/* we can create results that we use as input into another 
   SQL operation - THIS APPROACH ALLOWS US TO USE 
   DIFFERENT DATA TRANSFORMATIONS TO get the results we want 
   WHEN we have a subquery in the FROM CLAUSE it must be assigned an alias */
   
/* compute the largest invoice per state */ 

/* in the example above we had 1 base table and 1 inline view (subquery result)
   and we performed a JOIN */
/* we can have more than 1 inline view in the FROM clause */

/* for each state find the vendor with the highest sum of invoices */
/* report the vendor, and the sum of the onvoices for the vendor wirh the 
   highest invoice toral */
/* t1 computes the total per vendor
   t2 computes the maximum amount per state 
   we JOIN them to find the max amount and the vendor per state */ 


/* the above query can be rewritten with a common table experssion - each 
   subquery is given a name and then can be referenced in the following query */
   /* we would create 2 references tables using the WITH keyword */
   
