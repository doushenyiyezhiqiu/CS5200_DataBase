CREATE DATABASE IF NOT EXISTS SCRATCH;
USE SCRATCH;

CREATE TABLE address
      ( phone CHAR(11) PRIMARY KEY,
       Street VARCHAR(64) NOT NULL ,
        City VARCHAR(64) NOT NULL,
        State CHAR(2) NOT NULL,
        Zipcode char(5) NOT NULL
      );

CREATE TABLE musician 
( ssn INT PRIMARY KEY,
  name VARCHAR(64) NOT NULL,
   phone CHAR(11) DEFAULT 'NOAVAILABLE',
   CONSTRAINT musician_address_fk FOREIGN KEY  (phone) REFERENCES address(phone) 
	ON DELETE SET NULL
	ON UPDATE SET NULL
  );

  CREATE TABLE instrument 
( instrumentid INT PRIMARY KEY,
  name VARCHAR(64) NOT NULL,
  musicalkey VARCHAR(64)
  );
  
  CREATE TABLE album 
( albumid INT AUTO_INCREMENT PRIMARY KEY,
  releasedate DATE NOT NULL,
  formattype char(8) NOT NULL,
  producer INT NOT NULL,
  FOREIGN KEY (producer) REFERENCES musician(ssn) 
    ON UPDATE CASCADE ON DELETE CASCADE
  );
  
  CREATE TABLE song 
( songid INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(128) NOT NULL,
  author INT NOT NULL,
  albumid INT NOT NULL,
  FOREIGN KEY (albumid) REFERENCES album(albumid) 
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  FOREIGN KEY (author) REFERENCES musician(ssn) 
    ON UPDATE RESTRICT ON DELETE RESTRICT
  );
  -- mapping tables to support the multiple artists on a song 
  CREATE TABLE performs 
  (artist INT,
   song INT,
   PRIMARY KEY (artist,song),
   FOREIGN KEY (artist) REFERENCES musician(ssn)
     ON UPDATE RESTRICT ON DELETE RESTRICT,
   FOREIGN KEY (song) REFERENCES song(songid)
     ON UPDATE RESTRICT ON DELETE RESTRICT
	);
 -- mapping table to support the multiple instruments a musician can play    
CREATE TABLE musiciantoinstrument 
( instrumentid INT,
 	 artist INT,
 	 PRIMARY KEY (instrumentid,artist),
 	 FOREIGN KEY (instrumentid) REFERENCES instrument(instrumentid) 
   	      ON UPDATE RESTRICT ON DELETE RESTRICT,
  	FOREIGN KEY (artist) REFERENCES musician(ssn) 
   	      ON UPDATE RESTRICT ON DELETE RESTRICT
 	 );   
