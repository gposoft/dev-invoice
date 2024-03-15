
CREATE OR REPLACE FUNCTION store.invoice_update( 
	id       character varying(40), 
    dataset  jsonb 
)  
 RETURNS jsonb
LANGUAGE plpgsql  
AS  
$$  
    declare 
		register record;
		
		cli_id text;
		dsinvoice record;
		
		rcnews record;
		resp_catalog jsonb;
		result jsonb;
		details jsonb;
	BEGIN  
	
		SELECT         
			value->>'state'         as state,
			value->>'folio'         as folio,
		   (value->>'date')::date   as date,
			value->>'client_code'   as client_code,
		    value->>'concept'       as concept,
			COALESCE(value->>'details', '') as details
		INTO register
		FROM jsonb_each(dataset);
	
	   WITH dsrows AS ( 
			UPDATE store.invoice
					SET 
		     		state   = COALESCE(register.state, state),
					folio   = COALESCE(register.folio, folio),
					date    = COALESCE(register.date, date),
					concept = COALESCE(register.concept, concept)
		    WHERE invoice_id = id 
		    RETURNING *)
				
	   		select ds.invoice_id as id, 
			       ds.state,  
				   ds.folio,
				   to_char(ds.date, 'YYYY-MM-DD') as date, 
				   ds.concept
			INTO dsinvoice
			FROM dsrows AS ds;
			
			
			IF register.client_code <> '' THEN
				cli_id := (select client_id from store.client where code = register.client_code);
				DELETE FROM store.invoice_client WHERE client_id = cli_id;
	    		INSERT INTO store.invoice_client(invoice_id, client_id) VALUES(dsinvoice.id, cli_id);
			END IF;
			
			IF register.details <> '' THEN
			
				DELETE FROM store.invoice_details WHERE invoice_id = dsinvoice.id;

				WITH dsdetails AS (
					SELECT (items->>'cant')::numeric    AS cant,
						   (items->>'concept') AS concept,
						   (items->>'amount')::numeric  AS amount
					FROM jsonb_array_elements(dataset->'register'->'details') AS items
					)

				INSERT INTO store.invoice_details( invoice_id, cant, concept, amount )	
				SELECT dsinvoice.id,
					   det.cant,
					   det.concept,
					   det.amount
				FROM dsdetails as det;
		    END IF;
			
			SELECT 
				jsonb_agg(
					jsonb_build_object(
						'detail_id', ds.invoice_detail_id,
						'invoice_id', ds.invoice_id,
						'cant', ds.cant,
						'concept', ds.concept,
						'amount', ds.amount
					)
				)
			INTO details
			FROM store.invoice_details AS ds
			WHERE ds.invoice_id = dsinvoice.id; 	
		
			result = jsonb_build_object(
						'id', dsinvoice.id,
						'state', dsinvoice.state,
						'folio', dsinvoice.folio,
						'date', dsinvoice.date,
						'client_code', register.client_code,
						'concept', dsinvoice.concept,

						'details', details 
					);



			return result;
    END  
$$;  



CREATE OR REPLACE FUNCTION providers.invoice_update(
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
    result := store.invoice_update(id, dataset);
    RETURN result;
END
$$;



/*
select store.invoice_update('1', '{
					   "register": {
							"state": "delete"
					   }
					   }')   
					   
					   
select store.invoice_update('1', '{
					   "register": {
							"state": "delete",
							"details": [
					            {  "cant": 10, "concept": "concepto 10",  "amount": 10.01} ,
								{  "cant": 100,  "concept": "concepto 20",  "amount": 100.05},
								{  "cant": 1000,  "concept": "concepto 30",  "amount": 1000.09}
					        ]  
					   }
					   }')   
					   
select store.invoice_update('1', '{
					   "register": {
							"state": "active",
					   		"folio": "F200",
					   		"date": "2024-03-14",
					   		"client_code": "200",
					   		"concept": "Mi primera factura...!",
					        "details": [
					            {  "cant": 10, "concept": "concepto 1",  "amount": 100.80} ,
								{  "cant": 1,  "concept": "concepto 2",  "amount": 1000.50}
					        ]  
					   }
					   }')   
*/
