
CREATE OR REPLACE FUNCTION products.movto_create( 
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
		result record;
	BEGIN  
	
		 SELECT         
			value->>'operation'          as operation,
		   (value->>'quantity')::numeric as quantity,
			value->>'description'        as description,
		   (value->>'price')::numeric     as price,
		    value->>'sort'               as sort
		INTO register
		FROM jsonb_each(dataset);
	
	   WITH dsrows AS ( 
			INSERT INTO products.product_movto(
				   product_id, 
				   operation, 
				   quantity, 
				   price, 
				   description, 
				   sort)
			VALUES(
					_product_id,
					 register.operation,
				     register.quantity,
					 register.price,
				     register.description, 
				     register.sort
			      )
		    RETURNING *)
				
	        
		   	SELECT 
			    ds.product_movto_id, 
				ds.product_id, 
				ds.operation, 
				to_char(ds.date,'YYYY-MM-DD') as date,
				register.quantity,
				register.price,
				ds.description, 
				ds.sort
			INTO result
			FROM dsrows AS ds;
		
        return to_jsonb(result);
    END  
$$;  


CREATE OR REPLACE FUNCTION providers.product_movto_create(
    _product_id character varying, 
    dataset jsonb 
)
RETURNS jsonb
LANGUAGE plpgsql
AS
$$
DECLARE
    result jsonb;
BEGIN
    result := products.movto_create(_product_id, dataset);
    RETURN result;
END
$$;

/*

select providers.product_movto_create('1','{
   "register": {
        "operation": "S",
		"quantity": 25, 
		"description": "registro incial",
		"sort": "1"
    }  
}')



*/






