CREATE OR REPLACE FUNCTION dbh_generation()
RETURNS void AS $$
declare
    curtime.timestamp:=now();
BEGIN
INSERT INTO tbld_distribution_house(dbh_id,dbh_name,dbh_code,stock_dbh_name,biz_channel_type,territory,territory_officer,area,asm,region,rsm,rank)
    select dbh_id,dbh_name,dbh_code,stock_dbh_name,biz_channel_type,territory,territory_officer,area,asm,region,rsm,-1 
    from tbldr_distribution_house
    where dbh_id in 
       (
        SELECT dbh_id FROM tbldr_distribution_house
        EXCEPT
        SELECT dbh_id FROM tbld_distribution_house
        );
 END;
 $$ LANGUAGE plpgsql;
