CREATE OR REPLACE FUNCTION store.client_get_by_code(
   _code character varying(40)
)  
  RETURNS table(
	 			id character varying(40),
		        code text,
	  			first_name text,
				second_name text,
				name text
			  ) 
LANGUAGE plpgsql  
AS  
$$  
    declare 
		register record;
	BEGIN  
			
		return query 
		select ds.client_id as id, 
			   ds.code,  
			   ds.first_name,
			   ds.second_name, 
			   ds.name
		FROM store.client AS ds
		WHERE ds.code = _code;
    END  
$$;  



CREATE OR REPLACE FUNCTION providers.client_get_by_code(
   _code character varying(40)
)  
  RETURNS table(
				id character varying(40),
		        code text,
	  			first_name text,
				second_name text,
				name text
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
			   ds.first_name,
			   ds.second_name, 
			   ds.name
	from store.client_get_by_code(_code) as ds;
END
$$;