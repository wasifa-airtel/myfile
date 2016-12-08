CREATE OR REPLACE FUNCTION daily_se_sales_lymtd(_dt date)
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN
DELETE from tagg_daily_se_sales_lmtd where date=_dt;

INSERT INTO tagg_daily_se_sales_lmtd (date,dbh_id,sku_id,se_net_sales_volume ,
se_net_sales_unit ,se_net_sales_ctn ,se_net_sales_amount,se_free_sales_volume ,se_free_sales_amount ,se_free_sales_unit,
se_free_sales_ctn,se_gross_sales_volume,se_gross_sales_unit,se_gross_sales_ctn,se_gross_sales_amount)
	select _dt,dbh_id,sku_id,
	se_net_sales_volume ,
	se_net_sales_unit ,
	se_net_sales_ctn ,
	se_net_sales_amount,
	se_free_sales_volume ,
	se_free_sales_amount ,
	se_free_sales_unit,
	se_free_sales_ctn,
	se_gross_sales_volume,
	se_gross_sales_unit,
	se_gross_sales_ctn,
	se_gross_sales_amount

	from  tagg_daily_se_sales
	where date =_dt-(select lymtddel from tbld_lmtd_lymtd where date=_dt);
END;
$$ LANGUAGE plpgsql;

