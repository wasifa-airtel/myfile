CREATE OR REPLACE FUNCTION tblh_se_sales_raw(_dt date)
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN

delete from tblh_se_sales_raw where DATE(dt)=_dt;
        Insert into tblh_se_sales_raw (dt,dbh_id,sku_id, se_net_sales_volume,se_net_sales_unit,se_net_sales_ctn,    se_net_sales_amount,
        se_free_sales_volume,se_free_sales_unit,se_free_sales_ctn,se_free_sales_amount,
        se_gross_sales_volume,se_gross_sales_unit,se_gross_sales_ctn,se_gross_sales_amount)
        select dt,dbh_id,sku_id, se_net_sales_volume,se_net_sales_unit,se_net_sales_ctn,se_net_sales_amount,
        se_free_sales_volume,se_free_sales_unit,se_free_sales_ctn,se_free_sales_amount,
        se_gross_sales_volume,se_gross_sales_unit,se_gross_sales_ctn,se_gross_sales_amount
        from 
         tbl_daily_se_sales_oneday 
         where DATE(dt)=_dt ;
  END;
$$ LANGUAGE plpgsql;
SELECT * FROM tblh_se_sales_raw('2016-11-20')
SELECT *FROM  tblh_se_sales_raw