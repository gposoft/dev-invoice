
CREATE OR REPLACE FUNCTION products.create_catalogs( 
	_product_id character varying, 
    dataset jsonb 
)  
 RETURNS jsonb
LANGUAGE plpgsql  
AS  
$$  
    declare 
		register record;
	
		rcnews record;
		result jsonb;
	BEGIN  	
		delete from products.product_catalog where product_id = _product_id;

		WITH dscatalogs AS (
				SELECT cats->>'id'      AS id,
					   cats->>'type' AS catalog
				FROM jsonb_array_elements(dataset::jsonb->'register'->'catalogs') AS cats
			)
		INSERT INTO  products.product_catalog(product_id, catalog_id)
					select _product_id, 
						   cats.id
					from dscatalogs as cats;

		SELECT jsonb_build_object('catalogs', 
				jsonb_agg(
					jsonb_build_object(
						'product_catalog_id', ds.product_catalog_id,
						'product_id', ds.product_id,
						'catalog_id', ds.catalog_id
					)
				)
			) INTO result
		FROM products.product_catalog AS ds
		WHERE ds.product_id = _product_id; 
		
        return result;
    END  
$$;  





