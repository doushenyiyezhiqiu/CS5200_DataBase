CREATE DATABASE IF NOT EXISTS student;

USE student;

CREATE TABLE available_major (
    major VARCHAR(30) PRIMARY KEY
);
            
CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    school VARCHAR(30),
    credit_earned INT DEFAULT 0,
    credit_req INT NOT NULL
);
                      
CREATE TABLE student_major (
    student_id INT,
    major VARCHAR(30),
    CONSTRAINT major_pk PRIMARY KEY (student_id , major),
    CONSTRAINT s_major_fks FOREIGN KEY (student_id)
        REFERENCES student (id)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT s_major_fkm FOREIGN KEY (major)
        REFERENCES available_major (major)
        ON DELETE RESTRICT ON UPDATE RESTRICT
); 

-- INSERT tuples into the student table
INSERT INTO student(name, school, credit_earned, credit_req) 
	VALUES ('Smith',"Khoury", 20, 128),
			('Shah', 'COE', 24, 128), 
			('Li', 'Khoury', 32, 120);
                
-- INSERT into the available_major table                
INSERT INTO available_major VALUES
               ('CS'), ('Accounting'), ('DS');
               
-- INSERT data into the student_major table
INSERT INTO student_major VALUES 
                (1,'CS'),
				(1,'Accounting'), 
				(2,'CS'), 
				(3, 'DS');
-- Create a view on the student table of CS majors 

INSERT INTO student_major VALUES
(1, 'DS'); 

