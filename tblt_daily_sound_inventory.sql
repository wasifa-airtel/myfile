CREATE OR REPLACE FUNCTION tblt_daily_sound_inventory(_dt date, _dt2 date)
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN

            DELETE FROM tblt_daily_sound_inventory where date=_dt;

            INSERT INTO tblt_daily_sound_inventory(date, dbh_id , sku_id , batch_date,day_opening_inventory_volume,day_opening_inventory_ctn,day_opening_inventory_unit,day_opening_inventory_amount,day_closing_inventory_volume,day_closing_inventory_unit,day_closing_inventory_ctn,day_closing_inventory_amount)

            SELECT dt, dbh_id , sku_id , batch_date , inventory_volume, inventory_ctn,inventory_unit,inventory_amount,0,0,0,0
            FROM tblt_daily_sound_inventory_2_oneday
            where dt = _dt;

            UPDATE tblt_daily_sound_inventory
            SET (day_closing_inventory_volume,day_closing_inventory_unit,
            day_closing_inventory_ctn,day_closing_inventory_amount)=(0,0,0,0)
            where date =_dt2;

            UPDATE tblt_daily_sound_inventory a
            set day_closing_inventory_volume = (SELECT inventory_volume from tblt_daily_sound_inventory_2_oneday b where dt=_dt 
                 and a.sku_id=b.sku_id and a.dbh_id = b.dbh_id)
            where date =_dt2
            ;

            UPDATE tblt_daily_sound_inventory a
            set day_closing_inventory_unit = (SELECT inventory_unit from tblt_daily_sound_inventory_2_oneday b where dt=_dt 
                 and a.sku_id=b.sku_id and a.dbh_id = b.dbh_id)
            where date =_dt2
            ;

            UPDATE tblt_daily_sound_inventory a
            set day_closing_inventory_ctn = (SELECT inventory_ctn from tblt_daily_sound_inventory_2_oneday b where dt=_dt
                 and a.sku_id=b.sku_id and a.dbh_id = b.dbh_id)
            where date =_dt2
            ;

            UPDATE tblt_daily_sound_inventory a
            set day_closing_inventory_amount = (SELECT inventory_amount from tblt_daily_sound_inventory_2_oneday b where dt=_dt
                 and a.sku_id=b.sku_id and a.dbh_id = b.dbh_id)
            where date =_dt2
            ;

END;
$$ LANGUAGE plpgsql
