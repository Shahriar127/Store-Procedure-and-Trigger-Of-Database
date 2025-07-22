CREATE OR REPLACE PROCEDURE MULTI_TABLE(base_num INT, limit_num INT)
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 1;
BEGIN
    RAISE NOTICE 'Multiplication Table of % up to %:', base_num, limit_num;
    WHILE i <= limit_num LOOP
        RAISE NOTICE '% x % = %', base_num, i, base_num * i;
        i := i + 1;
    END LOOP;
END;
$$;


CALL MULTI_TABLE(5, 10);


