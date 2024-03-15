CREATE OR REPLACE FUNCTION store.client_create( 
    dataset jsonb 
)  
 RETURNS jsonb
LANGUAGE plpgsql  
AS  
$$  
    declare 
		register record;
		resp_catalog jsonb;
	
		rcnews record;
		result jsonb;
		resultCatalog jsonb;
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
		INSERT INTO store.client(
			        code,
			        first_name,
			        second_name, 
			        name)
			VALUES(
				    register.code, 
				    register.first_name, 
				    register.second_name, 
				    register.name
			      )
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
			
			SELECT jsonb_agg(jsonb_build_object(
							'product_catalog_id', c->>'product_catalog_id',
							'product_id', c->>'product_id',
							'catalog_id', c->>'catalog_id'
						))
			INTO resultCatalog
			FROM jsonb_array_elements(resp_catalog->'catalogs') AS c;

			result = result || jsonb_build_object('catalogs', resultCatalog);
		end if;
		*/
		
			
        return result;
    END  
$$; 


CREATE OR REPLACE FUNCTION providers.client_create(
    dataset jsonb
)
RETURNS jsonb
LANGUAGE plpgsql
AS
$$
DECLARE
    result jsonb;
BEGIN
    result := store.client_create(dataset);
    RETURN result;
END
$$;

/*

select store.client_create('{
					   "register": {
					   		"code": "200",
					   		"first_name": "Lopez",
					   		"second_name": "Martinez",
					   		"name": "Mariana"
					   }
					   }')
					   
*/




