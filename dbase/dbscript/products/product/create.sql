CREATE OR REPLACE FUNCTION products.create( 
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
			value->>'id'               as product_id,
			value->>'code'             as code,
			value->>'name'             as name,
			value->>'description'      as description,
		    value->>'sort'             as sort,
			
			COALESCE(NULLIF(value->>'catalogs', ''),'') as catalogs
		INTO register
		FROM jsonb_each(dataset);
	
	   WITH dsrows AS ( 
		INSERT INTO products.product(
			        product_id, 
			        code,
			        name,
			        description, 
			        sort)
			VALUES(
				    register.product_id, 
				    register.code, 
				    register.name, 
				    register.description, 
				    register.sort
			      )
		    RETURNING *)
					
		   select jsonb_build_object(
			       'id', ds.product_id, 
			       'code', ds.code,  
				   'name', ds.name,
				   'description', ds.description, 
				   'sort', ds.sort
			) INTO result
			FROM dsrows AS ds;
			
			/*
		if register.catalogs <> '' then
			resp_catalog = products.create_catalogs(register.product_id, dataset);
			--result = result || jsonb_build_object('catalogs', resp_catalog);
			result = result || jsonb_build_object('catalogs', jsonb_array_elements(resp_catalog->'catalogs'));
		end if;
		*/
		
		
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
		
			
        return result;
    END  
$$; 


CREATE OR REPLACE FUNCTION providers.product_create(
    dataset jsonb
)
RETURNS jsonb
LANGUAGE plpgsql
AS
$$
DECLARE
    result jsonb;
BEGIN
    result := products.create(dataset);
    RETURN result;
END
$$;

/*

select products.create('{
					   "register": {
					   		"id": "5",
					   		"code": "200",
					   		"name": "Pantalón",
					   		"description": "Producto 1",
					   		"sort": "1",
					        "catalogs": [
					           {  "id":"PC-1", "type":"PRODUCT-CATEGORY" } 
					        ]  
					   }
					   }')
					   
*/




