CREATE OR REPLACE FUNCTION tagg_daily_se_sales(_dt date)
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN

delete from tagg_daily_se_sales where date=_dt;


INSERT INTO tagg_daily_se_sales (date,dbh_id,sku_id, se_net_sales_volume,se_net_sales_unit,se_net_sales_ctn,    se_net_sales_amount,se_free_sales_volume,se_free_sales_unit,se_free_sales_ctn,se_free_sales_amount,
        se_gross_sales_volume,se_gross_sales_unit,se_gross_sales_ctn,se_gross_sales_amount,no_of_days_month,mtd_working_day)


select dt,dbh_id, b.sku_id , 
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
sum(gross_sales_amount)se_gross_sales_amount ,
max(26) no_of_working_days,
count(distinct dt)mtd_working_days

from tblt_daily_se_sales_oneday a , tbl_sku_max b
where a.sku_id=b.ori_id
and dt=_dt
group by dt,dbh_id,b.sku_id;

  END;
$$ LANGUAGE plpgsql;
