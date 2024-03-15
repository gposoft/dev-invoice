
CREATE OR REPLACE FUNCTION products.update( 
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
			value->>'code'            as code,
			value->>'name'            as name,
			value->>'description'     as description,
		    value->>'sort'            as sort,
			
			COALESCE(NULLIF(value->>'catalogs', ''),'') as catalogs
		INTO register
		FROM jsonb_each(dataset);
	
	   WITH dsrows AS ( 
			UPDATE products.product
					SET 
		     		code        = COALESCE(register.code, code),
					name        = COALESCE(register.name, name),
					description = COALESCE(register.description, description),
					sort        = COALESCE(register.sort, sort)
		    WHERE product_id = id 
		    RETURNING *)
				
			select jsonb_build_object(
			       'id', ds.product_id, 
			       'code', ds.code,  
				   'name', ds.name,
				   'description', ds.description, 
				   'sort', ds.sort
			) INTO result
			FROM dsrows AS ds;
			
			
		    if register.catalogs <> '' then
				resp_catalog = products.create_catalogs(register.product_id, dataset);
				result = result || jsonb_build_object('catalogs', jsonb_array_elements(resp_catalog->'catalogs'));
			end if;
		
           return result;
    END  
$$;  



CREATE OR REPLACE FUNCTION providers.product_update(
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
    result := products.update(id, dataset);
    RETURN result;
END
$$;