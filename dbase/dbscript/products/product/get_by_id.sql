CREATE OR REPLACE FUNCTION products.get_by_id(
   _id character varying(40)
)  
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
		FROM products.product AS ds
		WHERE ds.product_id = _id;
    END  
$$;  



CREATE OR REPLACE FUNCTION providers.product_get_by_id(
   _id character varying(40)
)  
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
	from products.get_by_id(_id) as ds;
END
$$;