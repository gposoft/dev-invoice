import { PoolClient, QueryResult } from "pg";
import { Result } from "../../../commons/result.mode";
import { Factura, FacturaGetByIdRepository } from "../../models";
import { connectPg } from "../../../../settings/db.setting";

export class FacturaGetByIdPgRepository implements FacturaGetByIdRepository {
    async execute(id: string): Promise<Result<Factura | null>> {
        const values = [id];
        const query = "SELECT * FROM store.invoice_get_by_id($1)";
        const client: PoolClient = await connectPg.connect();

        let response: Result<Factura | null>;

        try {
            const result: QueryResult = await client.query(query, values);
            const dataset = result.rows.map((row) => <Factura>row);

            response = {
                status: "success",
                data: dataset[0],
                error: null,
            };
        } catch (error: any) {
            response = {
                status: "error",
                data: null,
                error: error.message,
            };
        }
        return response;
    }
}
