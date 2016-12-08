CREATE OR REPLACE FUNCTION tblht_daily_sound_inventory_2(_dt date)
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN
        Delete from tblht_daily_sound_inventory_2 where dt = _dt;

        insert into  tblht_daily_sound_inventory_2(dt , dbh_id , sku_id , batch_date,
                inventory_volume,
                inventory_ctn,
                inventory_unit,
                inventory_amount)

        select dt , dbh_id , sku_id , batch_date,
                inventory_volume,
                inventory_ctn,
                inventory_unit,
                inventory_amount
        from tblt_daily_sound_inventory_2_oneday
        where dt =_dt;
END;
$$ LANGUAGE plpgsql;
