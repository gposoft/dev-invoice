CREATE OR REPLACE FUNCTION products.movto_summary(
	    _product_id character varying
)  
 RETURNS jsonb
LANGUAGE plpgsql 
AS  
$$  
DECLARE
    result record;
BEGIN  
        
		with summary as (select sum( case when operation = 'E' then quantity else 0 end) as total_input,
							    sum( case when operation = 'S' then quantity else 0 end) as total_output
						from products.product_movto as tra
						where tra.product_id = _product_id
						) 
	    select _product_id as product_id, 
		        total_input, 
				total_output, 
				total_input - total_output as total
		into result
		from summary;
		
		 return to_jsonb(result);
END  
$$;


CREATE OR REPLACE FUNCTION providers.product_movto_summary(
    _product_id character varying
)
RETURNS jsonb
LANGUAGE plpgsql
AS
$$
DECLARE
    result jsonb;
BEGIN
    result := products.movto_summary(_product_id);
    RETURN result;
END
$$;





