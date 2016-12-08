CREATE OR REPLACE FUNCTION tblh_se_sales_outlet_raw(_dt date)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
	curtime TIMESTAMP := now();
BEGIN

DELETE FROM tblh_outlet_daily_sales_raw WHERE Date(dt)= _dt;
        INSERT INTO tblh_outlet_daily_sales_raw (dt,dbh_id,sku_id,sr_id,route_id,section_id,cluster_id,outlet_id,
credit_id,displayed_id,se_net_sales_volume,se_net_sales_unit,se_net_sales_ctn,se_net_sales_amount,
        se_free_sales_volume,se_free_sales_unit,se_free_sales_ctn,se_free_sales_amount,
        se_gross_sales_volume,se_gross_sales_unit,se_gross_sales_ctn,se_gross_sales_amount)
        SELECT dt,dbh_id,sku_id,sr_id,route_id,section_id,cluster_id,outlet_id,
        credit_id,displayed_id,se_net_sales_volume,se_net_sales_unit,se_net_sales_ctn,se_net_sales_amount,
        se_free_sales_volume,se_free_sales_unit,se_free_sales_ctn,se_free_sales_amount,
        se_gross_sales_volume,se_gross_sales_unit,se_gross_sales_ctn,se_gross_sales_amount
        FROM 
        tblr_outlet_daily_sales_oneday
        WHERE Date(dt)=_dt;
        
  END;
$function$

SELECT * FROM tblh_se_sales_outlet_raw(CURRENT_DATE-1);

SELECT * FROM tblh_outlet_daily_sales_raw