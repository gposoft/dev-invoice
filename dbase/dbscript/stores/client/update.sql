
CREATE OR REPLACE FUNCTION store.client_update( 
	id       character varying(40), 
    dataset  jsonb 
)  
 RETURNS jsonb
LANGUAGE plpgsql  
AS  
$$  
    declare 
		register record;
		
		rcnews record;
		resp_catalog jsonb;
		result jsonb;
	BEGIN  
	
		 SELECT         
			value->>'code'          as code,
			value->>'first_name'    as first_name,
			value->>'second_name'   as second_name,
		    value->>'name'          as name,
			
			COALESCE(NULLIF(value->>'catalogs', ''),'') as catalogs
		INTO register
		FROM jsonb_each(dataset);
	
	   WITH dsrows AS ( 
			UPDATE store.client
					SET 
		     		code        = COALESCE(register.code, code),
					first_name  = COALESCE(register.first_name, first_name),
					second_name = COALESCE(register.second_name, second_name),
					name        = COALESCE(register.name, name)
		    WHERE client_id = id 
		    RETURNING *)
				
			select jsonb_build_object(
			       'id', ds.client_id, 
			       'code', ds.code,  
				   'first_name', ds.first_name,
				   'second_name', ds.second_name, 
				   'name', ds.name
			) INTO result
			FROM dsrows AS ds;
			
			/*
		    if register.catalogs <> '' then
				resp_catalog = products.create_catalogs(register.product_id, dataset);
				result = result || jsonb_build_object('catalogs', jsonb_array_elements(resp_catalog->'catalogs'));
			end if;
			*/
		
           return result;
    END  
$$;  



CREATE OR REPLACE FUNCTION providers.client_update(
	id       character varying(40), 
    dataset jsonb
)
RETURNS jsonb
LANGUAGE plpgsql
AS
$$
DECLARE
    result jsonb;
BEGIN
    result := store.client_update(id, dataset);
    RETURN result;
END
$$;