

   SELECT * FROM tagg_daily_pr_sales WHERE date='2016-11-23'
    
    CREATE OR REPLACE FUNCTION tagg_daily_pr_sales(_dt date)
    RETURNS void AS $$
    declare
        curtime timestamp := now();
    BEGIN
    Delete from tagg_daily_pr_sales where date= _dt;
    
    INSERT INTO tagg_daily_pr_sales(date,dbh_id,sku_id,pr_sales_volume,pr_sales_ctn,pr_sales_unit,pr_sales_amount)
    select date,
            dbh_id,
            sku_id ,
            pr_lifting_volume,
            pr_lifting_unit,
            pr_lifting_ctn,
            pr_lifting_amount
    from
    TAGG_PRIMARY_DAILY_LIFTING
    where date = _dt;
    END;
$$ LANGUAGE plpgsql;
  
