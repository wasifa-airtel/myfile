CREATE OR REPLACE FUNCTION tagg_monthly_pr_sales(monthid INTEGER ,_dt date,_dt2 date)
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN

delete from tagg_monthly_pr_sales where month_id = monthid;

INSERT INTO tagg_monthly_pr_sales (month_id,dbh_id,sku_id,pr_sales_volume,pr_sales_ctn,pr_sales_unit,pr_sales_amount)
select 
    monthid,
    dbh_id ,
    sku_id,
    sum(pr_sales_volume)pr_sales_volume,
    sum(pr_sales_ctn)pr_sales_ctn,
    sum(pr_sales_unit)pr_sales_unit,
    sum(pr_sales_amount)pr_sales_amount

from 
    tagg_daily_pr_sales
where date between _dt and _dt2
group by 
  dbh_id ,
  sku_id ;
END;
$$ LANGUAGE plpgsql;