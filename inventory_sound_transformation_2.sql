
CREATE OR REPLACE FUNCTION tblt_daily_sound_inventory_2_oneday(_dt date)
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN
 
        Delete from tblt_daily_sound_inventory_2_oneday where dt=_dt;
        
        INSERT INTO tblt_daily_sound_inventory_2_oneday (dt , dbh_id , sku_id , batch_date,inventory_volume,
        inventory_ctn,inventory_unit,inventory_amount)

        select dt , dbh_id , b.sku_id , batch_date,
        inventory_volume,
        inventory_ctn,
        inventory_unit,
        inventory_amount
        from tblt_daily_sound_inventory_oneday a , tbl_sku_max b
        where a.sku_id  = b.ori_id
        and dt = _dt;
        
END;
$$ LANGUAGE plpgsql;

