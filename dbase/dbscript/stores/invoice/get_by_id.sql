CREATE OR REPLACE FUNCTION store.invoice_get_by_id(
   _id character varying(40)
)  
 RETURNS jsonb
LANGUAGE plpgsql  
AS  
$$  
    declare 
		register record;
		
		details jsonb;
		dsinvoice record;
		result jsonb;
	BEGIN  
	
	
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
		WHERE ds.invoice_id = _id; 	
		
		
		select ds.invoice_id as id,
			   cli.code as client_code,
			   ds.state,  
			   ds.folio,
			   to_char(ds.date, 'YYYY-MM-DD') as date, 
			   ds.concept
		INTO dsinvoice
		FROM store.invoice AS ds
		           inner join store.invoice_client as edge_cli on 
				        ds.invoice_id = edge_cli.invoice_id
				   inner join store.client as cli on 
				        cli.client_id = edge_cli.client_id 
		WHERE ds.invoice_id = _id;
		
		
		result = jsonb_build_object(
				'id', dsinvoice.id,
				'state', dsinvoice.state,
				'folio', dsinvoice.folio,
				'date', dsinvoice.date,
				'client_code', dsinvoice.client_code, 
				'concept', dsinvoice.concept,

				'details', details 
			);
			
        return case when result->>'id' is  null then null else result end;
    END  
$$;  



CREATE OR REPLACE FUNCTION providers.invoice_get_by_id(
   _id character varying(40)
)  
RETURNS jsonb
LANGUAGE plpgsql
AS
$$
DECLARE
    result jsonb;
BEGIN
	
	result := store.invoice_get_by_id(_id);
    RETURN result;
END
$$;

/*

select store.invoice_get_by_id('1')

*/


