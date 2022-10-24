/* This script create a table to keep track of people's age, height, and weight.
Then, it creates a procedure to generate random data for this database.
Finally, it generates 1000 random datarows. */

-- Create the table:
CREATE TABLE people (
    id INT AUTO_INCREMENT,
    name VARCHAR(15) NOT NULL,
    age INT NOT NULL DEFAULT 23,
    height DOUBLE(5,2) NOT NULL DEFAULT 170.00,
    weight DOUBLE(5,2) NOT NULL DEFAULT 70.00,
    PRIMARY KEY(id)
);

-- Display the data:
SELECT * FROM people;

-- Create the procedure:
DELIMITER #
CREATE PROCEDURE RandomlyInsert(IN NumRows INT, IN MinAge INT, IN MaxAge INT, IN MinHeight INT, IN MaxHeight INT, IN MinWeight INT, IN MaxWeight INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        -- START TRANSACTION;
        label:
        WHILE i <= NumRows DO
            INSERT INTO people(name, age, height, weight) VALUES (
                CONCAT("name_", i),
                MinAge + CEIL(RAND() * (MaxAge - MinAge)),
                MinHeight + CEIL(RAND() * (MaxHeight - MinHeight)),
                MinWeight + CEIL(RAND() * (MaxWeight - MinWeight))
                );
            SET i = i + 1;
        END WHILE;
        -- COMMIT;
    END#
DELIMITER ;
SHOW CREATE PROCEDURE RandomlyInsert;


-- FIRST DATABASE: Generate random 1000 records: 
CALL RandomlyInsert(1000, 10, 100, 150.00, 210.00, 40.00, 220.00);

-- SECOND DATABASE: Generate a little more logical data:
--         500 people under 10 years old:
CALL RandomlyInsert(500, 1, 10, 50.00, 140.00, 3.00, 40.00);
--         500 people between 10-20 years old:
CALL RandomlyInsert(500, 10, 20, 140.00, 180.00, 40.00, 80.00);
--         500 people between 20-30 years old:
CALL RandomlyInsert(500, 20, 30, 150.00, 200.00, 50.00, 90.00);
--         1500 people between 30-80 years old:
CALL RandomlyInsert(1500, 30, 40, 150.00, 200.00, 55.00, 120.00);

-- Get rid of the tables and procedures if necessary:
DROP TABLE people;
DROP PROCEDURE RandomlyInsert;
