CREATE OR REPLACE FUNCTION tagg_outlet_daily_sales(_dt date)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
	curtime TIMESTAMP := now();
BEGIN

DELETE FROM tagg_daily_se_sales WHERE date=_dt;


INSERT INTO tagg_outlet_daily_sales (date,
dbh_id, 
sku_id , 
sr_id,
route_id,
section_id,
cluster_id,
outlet_id,
credit_id,
displayed_id,
se_net_sales_volume,
se_net_sales_unit,
se_net_sales_ctn,    
se_net_sales_amount,
se_free_sales_volume,
se_free_sales_unit,
se_free_sales_ctn,
se_free_sales_amount,
se_gross_sales_volume,
se_gross_sales_unit,
se_gross_sales_ctn,
se_gross_sales_amount)


SELECT 
dt,
dbh_id, 
b.sku_id , 
sr_id,
route_id,
section_id,
cluster_id,
outlet_id,
credit_id,
displayed_id,
sum(se_net_sales_volume)se_net_sales_volume ,
sum(se_net_sales_unit)se_net_sales_unit ,
sum(se_net_sales_ctn)se_net_sales_ctn ,
sum(se_net_sales_amount)se_net_sales_amount ,
sum(se_free_sales_volume)se_free_sales_volume ,
sum(se_free_sales_unit)se_free_sales_unit ,
sum(se_free_sales_ctn)se_free_sales_ctn ,
sum(se_free_sales_amount)se_free_sales_amount ,
sum(se_gross_sales_volume)se_gross_sales_volume ,
sum(se_gross_sales_unit)se_gross_sales_unit ,
sum(se_gross_sales_ctn)se_gross_sales_ctn ,
sum(se_gross_sales_amount)se_gross_sales_amount 

FROM tblt_outlet_daily_sales_oneday a , tbl_sku_max b
WHERE a.sku_id=b.ori_id
AND dt =_dt
GROUP BY 
dt,
dbh_id, 
b.sku_id , 
sr_id,
route_id,
section_id,
cluster_id,
outlet_id,
credit_id,
displayed_id;
  END;
$function$

SELECT * FROM tagg_outlet_daily_sales(CURRENT_DATE-1);