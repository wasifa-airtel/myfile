CREATE OR REPLACE FUNCTION sr_generation()
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN

INSERT INTO TBLD_SR(SR_ID , SR_NAME ,SR_CODE)
SELECT SR_ID , SR_NAME , SR_CODE 
FROM TBLR_SR
WHERE SR_ID IN (
                SELECT SR_ID FROM tblr_sr
                EXCEPT
                SELECT SR_ID FROM tbld_sr
                );
END;
$$ LANGUAGE plpgsql;


