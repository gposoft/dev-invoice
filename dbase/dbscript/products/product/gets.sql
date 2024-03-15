CREATE OR REPLACE FUNCTION products.gets()  
  RETURNS table(
	 			id character varying(40),
		        code text,
	  			name text,
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
		select ds.product_id as id, 
			   ds.code,  
			   ds.name,
			   ds.description, 
			   ds.sort
		FROM products.product AS ds;
    END  
$$;  



CREATE OR REPLACE FUNCTION providers.product_gets()
  RETURNS table(
	 			id character varying(40),
		        code text,
	  			name text,
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
			   ds.code,  
			   ds.name,
			   ds.description, 
			   ds.sort
	from products.gets() as ds;
END
$$;