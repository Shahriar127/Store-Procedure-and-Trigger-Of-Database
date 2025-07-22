create database lab_test_12_07_25 
use lab_test_12_07_25

-- Create a simple table named Q_1_table with two columns
CREATE TABLE Q_1_table (
    ID INT PRIMARY KEY,        
    Name NVARCHAR(50)            
);

-- Create an AFTER trigger on Q_1_table for INSERT, UPDATE, DELETE
CREATE TRIGGER trg_Block_DML_On_Q1
ON Q_1_table
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Prevent any Insert, Update, or Delete operation on Q_1_table by raising an error
    RAISERROR ('INSERT, UPDATE, and DELETE operations are not allowed on Q_1_table.', 16, 1);
    
    -- Rollback the transaction to cancel the DML operation
    ROLLBACK TRANSACTION;
END;


/* 

| Severity | Meaning                                                                                                     |
| -------- | ----------------------------------------------------------------------------------------------------------- |
| 0-10     | Informational / warnings — does **not stop execution**                                                      |
| 11-16    | Errors that **can be fixed by the user** (like data violations, rule violations). These **stop execution**. |
| 17-25    | System or fatal errors. Often require DBA attention.                                                        |

This is the state code, from 0 to 255.

It is just a marker to help you or the DBA debug.

For example, if you have many RAISERROR statements in different places, you could use different states:

1 = operation blocked by trigger

2 = invalid account number

3 = insufficient permissions

So in error logs you can quickly see where it came from.


*/

INSERT INTO Q_1_table (ID, Name) 
VALUES (1, 'Ashik');
