
CREATE OR REPLACE FUNCTION products.delete( 
	_id       character varying(40)
)  
 RETURNS jsonb
LANGUAGE plpgsql  
AS  
$$  
    declare 
		register record;
		
		rcnews record;
		result record;
	BEGIN  
	
		select ds.product_id as id, 
			   ds.code,  
			   ds.name,
			   ds.description, 
			   ds.sort
		INTO result
		FROM products.product AS ds
		where ds.product_id = _id;
		
		
        delete from products.product where product_id = _id;
		
        return to_jsonb(result);
    END  
$$;  



CREATE OR REPLACE FUNCTION providers.product_delete(
	_id       character varying(40)
)
RETURNS jsonb
LANGUAGE plpgsql
AS
$$
DECLARE
    result jsonb;
BEGIN
    result := products.delete(_id);
    RETURN result;
END
$$;