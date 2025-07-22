use lab_test_12_07_25

CREATE TABLE Q_2_table (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50)
);


CREATE TRIGGER trg_Block_Insert_Update_On_Q2
ON Q_2_table
AFTER INSERT, UPDATE
AS
BEGIN
    -- Raise a user-defined error message with severity 16 and state 1
    RAISERROR ('INSERT and UPDATE operations are not allowed on Q_2_table.', 16, 1);

    -- Rollback the transaction so the operation does not complete
    ROLLBACK TRANSACTION;
END;

INSERT INTO Q_2_table (ID, Name) VALUES (1, 'Ashik');

UPDATE Q_2_table SET Name = 'NewName' WHERE ID = 1;
