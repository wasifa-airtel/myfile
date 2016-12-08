CREATE OR REPLACE FUNCTION route_generation()
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN
INSERT INTO tbld_route(route_id,route_name,route_code)
SELECT route_id , route_name , route_code 
from tbldr_route
where route_id in
    (
    SELECT route_id from tbldr_route
    EXCEPT
    SELECT route_id from tbld_route
    );
 END;
 $$ LANGUAGE plpgsql;