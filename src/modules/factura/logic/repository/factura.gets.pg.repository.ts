import { PoolClient, QueryResult } from "pg";
import { Result } from "../../../commons/result.mode";
import { Factura, FacturaGetsRepository } from "../../models";
import { connectPg } from "../../../../settings/db.setting";

export class FacturaGetsPgRepository implements FacturaGetsRepository {
    async execute(): Promise<Result<Factura[]>> {
        const query = "SELECT * FROM store.invoice_gets()";
        const client: PoolClient = await connectPg.connect();

        let response: Result<Factura[]>;

        try {
            const result: QueryResult = await client.query(query);
            const dataset = result.rows.map((row) => <Factura>row);

            response = {
                status: "success",
                data: dataset,
                error: null,
            };
        } catch (error: any) {
            let message = error.message;

            response = {
                status: "error",
                data: [],
                error: message,
            };
        }
        return response;
    }
}
