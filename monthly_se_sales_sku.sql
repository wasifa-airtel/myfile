CREATE OR REPLACE FUNCTION sku_monthly_sales(monthid INTEGER,_dt date, _dt2 date)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
	curtime TIMESTAMP := now();
BEGIN
DELETE FROM tagg_monthly_se_sales WHERE month_id = monthid;

INSERT INTO tagg_monthly_se_sales(month_id ,dbh_id,sku_id,se_net_sales_volume,se_net_sales_unit,se_net_sales_ctn,se_net_sales_amount,
se_gross_sales_amount,se_gross_sales_ctn,se_gross_sales_unit,se_gross_sales_volume,
se_free_sales_amount,se_free_sales_ctn,se_free_sales_unit,se_free_sales_volume)  
SELECT monthid,dbh_id,sku_id,
sum(se_net_sales_volume)se_net_sales_volume,
sum(se_net_sales_unit)se_net_sales_unit,
sum(se_net_sales_ctn)se_net_sales_ctn,
sum(se_net_sales_amount)se_net_sales_amount,
sum(se_gross_sales_amount)se_gross_sales_amount,
sum(se_gross_sales_ctn)se_gross_sales_ctn,
sum(se_gross_sales_unit)se_gross_sales_unit,
sum(se_gross_sales_volume)se_gross_sales_volume,
sum(se_free_sales_amount)se_free_sales_amount,
sum(se_free_sales_ctn)se_free_sales_ctn,
sum(se_free_sales_unit)se_free_sales_unit,
sum(se_free_sales_volume)se_free_sales_volume
    FROM tagg_daily_se_sales
    WHERE date BETWEEN _dt AND _dt2
    GROUP BY dbh_id , sku_id;
  END;
$function$

SELECT * FROM sku_monthly_sales(201610,'2016-10-01' ,'2016-10-08')

DROP FUNCTION sku_monthly_sales(INTEGER,date,date)

SELECT * FROM tagg_monthly_se_sales 