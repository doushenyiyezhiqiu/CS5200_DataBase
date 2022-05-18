/* start by creating a database */
CREATE database scratch1; 
/* what happens if you try and create the database again? 
/* [if not exists] will do the operation only if the object
does not exist in the database 
*/

CREATE database if not exists scratch1;

/* to set your context */
USE scratch1;

/* Syntax for the CREATE TABLE command
   CREATE TABLE table_name 
   ( field1 field1_type field_constraint [, field2 field2_type ...);
*/

/* What are the field constraints in MySQL? */
/* UNIQUE, NOT NULL, PRIMARY KEY,AUTO_INCREMENT
 * some require a value like DEFAULT default_value
 
/* You can also express table constraints for a table
   CREATE TABLE name(field1 field_type1 field1_attributes 
[, field2 field_type2 field2_attributes ]
[, table_constraints ] ) ;
 Table constraints limit the table
 */ 
/* Example */
CREATE TABLE scratch1.student (
    nuid INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL
); 
CREATE TABLE course ( cid INT PRIMARY KEY,
                      name VARCHAR(30) NOT NULL );
/* what if we wanted to represent the registers relationship 
 * between student and courses
 * we need to look at the multiplicities to determine how to
   represent it. A student can register for 0 to many courses
   a course is registered by 1 to many courses. Since both sides 
   have a cadninalty of many it is a *:* relationship. We need a 
   separate table to represent a *:* relationship
   We need to determine the PRIMARY KEY, FOREIGN keys
*/

CREATE TABLE registers (
    cid INT,
    sid INT,
    PRIMARY KEY (cid, sid)
);
/* next we need to represent that registers.cid and registers.sid 
   should be limitied to the values in course.cid and student.sid
   do you remember how we do this? 
*/

/* we need a foreign key - actually we need 2 foreign keys - so
   lets create them there are 2 different methods for 
   representing foreign keys, in one method you use the
   CONSTRAINT key word, this allows you to specify a name for
   the foreign key. The other method you do not provide a name */
CREATE TABLE if not exists registers (
    cid INT,
    sid INT,
    PRIMARY KEY (cid, sid),
    CONSTRAINT registers_fk1 FOREIGN KEY (cid) 
    REFERENCES course (cid),
    FOREIGN KEY (sid) REFERENCES student (nuid)
    ); 
/* We can also express what behavior we want to happen if there 
   is a change to the parent tuple that would violate the FK
   what change should be made to the child tuple to ensure referential
   integrity? 
   We use the ON UPDATE and ON DELETE clause for the FK to
   specify the behavior we want
   What actions can violate the FK?
*/



