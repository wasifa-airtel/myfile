CREATE OR REPLACE FUNCTION tagg_daily_pr_sales_lymtd(_dt date)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
	curtime TIMESTAMP := now();
BEGIN
DELETE FROM tagg_daily_pr_sales_lymtd  WHERE date=_dt;

INSERT INTO tagg_daily_pr_sales_lymtd (date,dbh_id,sku_id,pr_sales_volume,pr_sales_ctn,pr_sales_unit,pr_sales_amount)
	SELECT _dt,dbh_id,sku_id,
	pr_sales_volume,
	pr_sales_ctn,
	pr_sales_unit,
	pr_sales_amount

	FROM  tagg_daily_pr_sales 
	WHERE date =_dt-(SELECT lymtddel FROM tbld_lmtd_lymtd WHERE date=_dt);
END;
$function$

SELECT * FROM tagg_daily_pr_sales_lmtd