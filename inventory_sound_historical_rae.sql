CREATE OR REPLACE FUNCTION tblh_daily_sound_inventory_raw(_dt date)
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN


DELETE FROM tblh_daily_sound_inventory_raw where Date(dt)=_dt;

INSERT INTO tblh_daily_sound_inventory_raw(dt,dbh_id,sku_id,batch_date,inventory_volume,inventory_ctn,inventory_unit,inventory_amount)
select 
        dt,
        dbh_id,
        sku_id,
        batch_date,
        inventory_volume,
        inventory_ctn,
        inventory_unit,
        inventory_amount
From 
        tblr_daily_sound_inventory_oneday
where Date(dt) = _dt;

END;
$$ LANGUAGE plpgsql;
