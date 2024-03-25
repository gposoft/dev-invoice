import { PoolClient, QueryResult } from "pg";
import { Result } from "../../../commons/result.mode";
import { Factura, FacturaStateGetAllRepository } from "../../models";
import { connectPg } from "../../../../settings/db.setting";

export class FacturaStateGetAllPgRepository implements FacturaStateGetAllRepository {
    async execute(state: string): Promise<Result<Factura[]>> {
        const values = [state];
        const query = "SELECT * from providers.invoice_get_all($1)";
        const client: PoolClient = await connectPg.connect();

        let response: Result<Factura[]>;

        try {
            const result: QueryResult = await client.query(query, values);
            const dataset = result.rows.map((row) => <Factura>row);

            response = {
                status: "success",
                data: dataset,
                error: null,
            };
        } catch (error: any) {
            response = {
                status: "error",
                data: [],
                error: error.message,
            };
        }

        return response;
    }
}
