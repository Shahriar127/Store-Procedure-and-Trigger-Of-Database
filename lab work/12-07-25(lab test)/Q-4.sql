CREATE PROCEDURE MULTI_TABLE_Q_4
    @Number INT,     -- Base number
    @Limit INT       -- Range limit
AS
BEGIN
    DECLARE @i INT = 1;             -- Loop counter starts at 1
    DECLARE @Result INT;            -- Holds multiplication result
    DECLARE @Output NVARCHAR(100);  -- Holds the formatted output string

    WHILE @i <= @Limit
    BEGIN
        SET @Result = @Number * @i;

        -- Build the output string like '5 x 3 = 15'
        SET @Output = CAST(@Number AS NVARCHAR(10)) + ' x ' +
                      CAST(@i AS NVARCHAR(10)) + ' = ' +
                      CAST(@Result AS NVARCHAR(20));

        PRINT @Output;              -- Print to Messages tab

        SET @i = @i + 1;            -- Increment counter
    END
END;


EXEC MULTI_TABLE_Q_4 @Number = 7, @Limit = 12;
