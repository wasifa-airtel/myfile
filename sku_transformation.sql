CREATE TABLE tbldt_sku_2
(
sku_id INTEGER DEFAULT 7580000,
sku_name TEXT,
sku_code TEXT,
brand TEXT,
category TEXT,
sku_group_name TEXT,
sku_macro_group_name TEXT,
tally_code TEXT,
unit_price_mrp_b2b TEXT,
unit_price_sales_b2b TEXT,
unit_price_lifting_b2b TEXT,
unit_price_mrp_mt TEXT,
unit_price_sales_mt TEXT,
unit_price_lifting_mt TEXT,
unit_price_mrp_gt TEXT,
unit_price_sales_gt TEXT,
unit_price_lifting_gt TEXT,
ctn_size TEXT
)
CREATE SEQUENCE incr_id
    INCREMENT 1
    MINVALUE 7580000
    MAXVALUE 9223372036854775807
    START 7580000
    CACHE 1;
    
 ALTER TABLE tbldt_sku_2 ALTER COLUMN sku_id SET DEFAULT nextval('incr_id'::regclass);
 
 
 SELECT sku_id , sku_name , sku_code ,tally_code,unit_price_mrp_b2b ,unit_price_sales_b2b,unit_price_lifting_b2b,
unit_price_mrp_mt,unit_price_sales_mt,unit_price_lifting_mt,unit_price_mrp_gt,unit_price_sales_gt,unit_price_lifting_gt,ctn_size
FROM tbldt_sku 
EXCEPT
 SELECT sku_id , sku_name , sku_code ,tally_code,unit_price_mrp_b2b ,unit_price_sales_b2b,unit_price_lifting_b2b,
unit_price_mrp_mt,unit_price_sales_mt,unit_price_lifting_mt,unit_price_mrp_gt,unit_price_sales_gt,unit_price_lifting_gt,ctn_size
FROM tbldt_sku_2
