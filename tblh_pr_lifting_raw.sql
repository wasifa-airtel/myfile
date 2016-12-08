
CREATE OR REPLACE FUNCTION tblh_primary_lifting_raw (_dt date)
RETURNS void AS $$
declare
	curtime timestamp := now();
BEGIN

        DELETE FROM tblh_primary_lifting_raw where dt=_dt;

        INSERT INTO tblh_primary_lifting_raw (dt,dbh_id,sku_id,batch_date,pr_lifting_volume,pr_lifting_unit,pr_lifting_ctn,pr_lifting_amount )

                select dt,dbh_id,sku_id,batch_date,pr_lifting_volume,pr_lifting_unit,pr_lifting_ctn,pr_lifting_amount 
                from  tblr_primary_lifting_oneday 
                where dt=_dt;
END;
$$ LANGUAGE plpgsql;