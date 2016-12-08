CREATE OR REPLACE FUNCTION public.outlet_generation()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
	curtime TIMESTAMP := now();
BEGIN

INSERT INTO tbld_outlet (outlet_id,outlet_name,outlet_code,address,biz_channel_type,outlet_category,volume_class)
    SELECT outlet_id,outlet_name,outlet_code,address,biz_channel_type,outlet_category,volume_class
    FROM tblr_outlet
    WHERE outlet_id IN 
    (
        SELECT outlet_id FROM tblr_outlet
        EXCEPT
        SELECT outlet_id FROM tbld_outlet
    );
    END;
$function$
