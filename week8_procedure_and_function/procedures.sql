/* Today's topics
/* CREATING DATABASE PROGRAMMING OBJECTS FUNCTIONS AND PROCEDURES
/* EXTENSIONS MADE TO THE SQL PROGRAMMING LANGUAGE
/* 		IF ...  ELSEIF...ELSE    END IF
/* 		WHILE DO LOOP 
/* 		DECLARE local_variable data_type
/* 		CASE ... WHEN ... ELSE
/* HANDLING ERRORS 
/* https://dev.mysql.com/doc/mysql-errors/8.0/en/server-error-reference.html
*/
/* create a simple procedure - show the update to the schema, */
use student; 
CREATE PROCEDURE test()
BEGIN
END;

/* create a simple procedure - that declares a local variable  
use student;  - look what happens I generate a syntax error - anyone know why?
CREATE PROCEDURE test()
BEGIN
DECLARE i int; 
END;*./

/* the semicolon at the end of the declaration statement is terminating the CREATE PROCEDURE command
/* we want to embed semicolons in this command - the way we do this is by temporarily resetting the
delimiter - or the end of line character. The default is ; but you can ovverride this */

use student;
DROP PROCEDURE IF EXISTS test2;

DELIMITER $$
CREATE PROCEDURE test2()
BEGIN
DECLARE i int; 
END$$
DELIMITER ;

/* LET'S WRITE A PROCEDURE THAT UPDATES THE SCHOOL FOR A STUDENT */
/* STATEMENT TO DO THIS
/* update STUDENT set SCHOOL = "KHOURY" where ID = argument; */
/* when specifying arguments you state how they are used by the procedure 
/* SPECIFY in out OR inout BEFORE THE PARAMETER */
DROP PROCEDURE IF EXISTS TO_KHOURY;
DELIMITER $$
CREATE PROCEDURE TO_KHOURY(IN id_p INT) 
    BEGIN
    UPDATE student SET school = "Khoury" WHERE id = id_p;
    END $$

DELIMITER ; 
CALL TO_KHOURY(2); -- EXECUTE THE PROCEDURE 

/* NOW LET'S TRY OUT if STATEMENT - WE UPDATE THE SCHOOL ONLY IF THE ID > 10 */ 
DELIMITER $$
CREATE PROCEDURE TO_KHOURY_LARGE(IN id_p INT) 
    BEGIN
    IF ( id_p > 10 ) THEN 
          UPDATE student SET school = "Khoury" WHERE id = id_p;
	END IF; 
    END $$
   DELIMITER ;  
  
  /* NO UPDATE MADE DUE TO THE if statement */
   CALL TO_KHOURY_LARGE(2);
   
/* what if we had bands of id values going to different schools */
/* NOTICE THE SPACE IN END IF BUT NO SPACE IN ELSEIF */
DELIMITER $$
CREATE PROCEDURE change_school(id_p INT) 
    BEGIN
    IF ( id_p <  10 ) THEN 
          UPDATE student SET school = "Khoury" WHERE id = id_p;
	ELSEIF (id > 10 ) THEN 
		UPDATE student SET school = "COE" WHERE id = id_p;
        END IF; 
    END $$
   DELIMITER ;  

DROP PROCEDURE IF EXISTS iterator; 
/* LET'S DO A SIMPLE LOOK */
DELIMITER $$
CREATE PROCEDURE iterator(INOUT n INT)
     BEGIN
     DECLARE j int; 
     SET j = n;
     WHILE j > 0 DO 
         SELECT j;
         SET j = j -1; 
     END WHILE;
     END$$
DELIMITER ; 

/* can I change the value of a paramter? */

DROP PROCEDURE IF EXISTS iterator2; 
/* LET'S DO A SIMPLE LOOK */
DELIMITER $$
CREATE PROCEDURE iterator2(n INT)
     BEGIN
  
     WHILE n > 0 DO 
         SELECT n;
         SET n = n -1; 
     END WHILE;
     END$$
DELIMITER ; 


/* should call the iterator with different values */
CALL iterator2(5); 

/* CURSOR WITH A CONTINUE HANDLER */

DELIMITER $$
CREATE procedure walk_students( ) 
BEGIN

DECLARE row_not_found, student_id_var INT;
DECLARE name_var, major_var, school_var varchar(30);

DECLARE student_major_c CURSOR FOR
  SELECT student_id, name, school, major FROM student_major JOIN student USING(student_id); 

DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET row_not_found = TRUE;
    
SET row_not_found = FALSE; 
OPEN student_major_c;

WHILE row_not_found = FALSE DO
  FETCH student_major_c INTO student_id_var, name_var, school_var, major_var;
  SELECT student_id_var, name_var, school_var, major_var;
END WHILE ;
CLOSE student_major_c; 
END$$
DELIMITER ; 

DELIMITER $$
/* procedure with an exit handler ER_DUP_ENTRY */
CREATE PROCEDURE new_major(major VARCHAR(30))
BEGIN
  DECLARE duplicate_entry_for_key TINYINT DEFAULT FALSE;
  BEGIN
    DECLARE EXIT HANDLER FOR 1062
      SET duplicate_entry_for_key = TRUE;
      
    INSERT INTO available_major VALUES (major);
    
    SELECT '1 row was inserted.' AS message;    
  END;
  
  IF duplicate_entry_for_key = TRUE THEN
    SELECT 'Row was not inserted - duplicate key encountered.'
        AS message;
  END IF;
END$$
DELIMITER ;

CALL new_major("Assounting");


/* A function is executed typically in a SQL SELECT statement
   it only accepts INPUT arguments 
   it returns a value 
   SYNTAX
   CREATE FUNCTION name ( argument1 argument1Type
          )
         RETURNS DATA_TYPE 
         DETERMINISTIC
         CONTAINS SQL|NO SQL|READS SQL DATA|MODIFIES SQL DATA
  BEGIN
  -- Function definition 
  END
 HINTS TO OPTIMIZER


*/
DROP FUNCTION distinct_schools; 
DELIMITER $$
CREATE FUNCTION distinct_schools( )
   RETURNS INT DETERMINISTIC
   CONTAINS SQL
   BEGIN 
   DECLARE ret_int INT;
   
   SELECT COUNT(DISTINCT school) INTO ret_int FROM student;
   RETURN(ret_int); 
   END $$
   
   DELIMITER ; 
   
   SELECT distinct_schools(), count(id) count_students
       FROM student;
	
    /* remember it gets called per row */
    
    SELECT *, distinct_schools() from student; 

/* PREPARED statement - go through deck */

SET @a = "name";    
SET @b = "student";
SET @c = "Smith"; 
SET @s = CONCAT ("select ", @a, " FROM ", @b, " WHERE name = ?;" ); -- example dynamic SQL
SELECT @s;
PREPARE stmt FROM @s;
EXECUTE stmt USING @c;
DEALLOCATE PREPARE stmt;








