
CREATE OR REPLACE FUNCTION tblt_monthly_daily_sound_inventory (_dt date)
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN      
        
        DELETE FROM tblt_monthly_daily_sound_inventory where date = _dt;
        
        INSERT INTO 
        tblt_monthly_daily_sound_inventory (date, dbh_id,sku_id , batch_date,monthly_opening_inventory_volume,      monthly_opening_inventory_unit,monthly_opening_inventory_ctn,monthly_opening_inventory_amount,montly_closing_inventory_volume,
        montly_closing_inventory_unit,montly_closing_inventory_ctn,montly_closing_inventory_amount)


        select date , dbh_id,sku_id , batch_date,inventory_volume,inventory_ctn,inventory_unit,inventory_amount,0,0,0,0 from   tblht_daily_sound_inventory_2 a , tbld_calendar b
        where a.dt = b.month_opening_date
        and b.date = _dt;
        
        update  tblt_monthly_daily_sound_inventory 
        SET (montly_closing_inventory_volume,
            montly_closing_inventory_unit,
            montly_closing_inventory_ctn,
            montly_closing_inventory_amount)=(0,0,0,0) ;
       
        Update tblt_monthly_daily_sound_inventory c
        set montly_closing_inventory_volume=inventory_volume
        from   tblht_daily_sound_inventory_2 a , tbld_calendar b
        where a.dt = b.next_month_opening
        AND c.dbh_id = a.dbh_id
        and c.sku_id = a.sku_id
        and  b.date =_dt;
        
        Update tblt_monthly_daily_sound_inventory c
        set montly_closing_inventory_unit=inventory_unit
        from   tblht_daily_sound_inventory_2 a , tbld_calendar b
        where a.dt = b.next_month_opening
        AND c.dbh_id = a.dbh_id
        and c.sku_id = a.sku_id
        and b.date =_dt;
        
        Update tblt_monthly_daily_sound_inventory c
        set montly_closing_inventory_ctn=inventory_ctn
        from   tblht_daily_sound_inventory_2 a , tbld_calendar b
        where a.dt = b.next_month_opening
        AND c.dbh_id = a.dbh_id
        and c.sku_id = a.sku_id
        and  b.date =_dt;
             
        Update tblt_monthly_daily_sound_inventory c
        set montly_closing_inventory_amount=inventory_amount
        from   tblht_daily_sound_inventory_2 a , tbld_calendar b
        where a.dt =  b.next_month_opening
        AND c.dbh_id = a.dbh_id
        and c.sku_id = a.sku_id
        and  b.date =_dt;

     END;
$$ LANGUAGE plpgsql;   
