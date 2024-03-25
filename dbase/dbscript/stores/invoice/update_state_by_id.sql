
CREATE OR REPLACE FUNCTION store.invoice_state_by_id( 
	_id       character varying(40),
	_state    text
)  
 RETURNS numeric
LANGUAGE plpgsql  
AS  
$$  
    declare 
	    register record; 
	BEGIN     
			UPDATE store.invoice
					SET  state  = COALESCE(_state, state)
		    WHERE invoice_id = _id 
			RETURNING * INTO register; 
		
			IF FOUND THEN
				RETURN 1;
			ELSE
				RETURN 0;
			END IF;
    END  
$$;  



CREATE OR REPLACE FUNCTION providers.invoice_state_by_id(
	_id       character varying(40),
    _state    text
)
RETURNS numeric
LANGUAGE plpgsql
AS
$$
DECLARE
    result numeric;
BEGIN
    result := store.invoice_state_by_id(_id, _state);
    RETURN result;
END
$$;

/*

select store.invoice_state_by_id('11','active');

*/