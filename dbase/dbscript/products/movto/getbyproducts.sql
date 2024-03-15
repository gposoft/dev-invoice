CREATE OR REPLACE FUNCTION products.movto_get_by_product(
   _product_id character varying(40)
)  
  RETURNS table(
	 			id character varying(40),
		        product_id character varying(40),
    			operation character varying(20),
                date text,
                quantity integer,
                price numeric,
                description text,
    			sort text
			  ) 
LANGUAGE plpgsql  
AS  
$$  
    declare 
		register record;
	BEGIN  
			
		return query 
		select ds.id AS id,
	           ds.product_id, 
	           ds.operation,
	           to_char(ds.date,'YYYY-MM-DD')::text as date,
	           ds.quantity,
	           ds.price,
	           ds.description,
	           ds.sort
		FROM products.product_movto AS ds
		WHERE ds.product_id = _product_id;
    END  
$$;  



CREATE OR REPLACE FUNCTION providers.product_movto_get_by_product(
   _product_id character varying(40)
)  
    RETURNS table(
	 			id character varying(40),
		        product_id character varying(40),
    			operation character varying(20),
                date text,
                quantity integer,
                price numeric,
                description text,
    			sort text
			  ) 
LANGUAGE plpgsql
AS
$$
DECLARE
    result jsonb;
BEGIN
	
	return query 
		select ds.id,
	           ds.product_id, 
	           ds.operation,
	           ds.date::text as date,
	           ds.quantity,
	           ds.price,
	           ds.description,
	           ds.sort
	from products.movto_get_by_product(_product_id) as ds;
END
$$;