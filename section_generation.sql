CREATE OR REPLACE FUNCTION section_generation()
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN
INSERT into tbld_section(section_id,section_name,section_code,section_type,section_class)
SELECT section_id,section_name,section_code,'UNKNOWN'section_type,'UNKNOWN'section_class
from tbldr_section 
where section_id in 
   (
    SELECT section_id from tbldr_section
    EXCEPT
    SELECT section_id FROM tbld_section
   );
  END;
  $$ LANGUAGE plpgsql;
  