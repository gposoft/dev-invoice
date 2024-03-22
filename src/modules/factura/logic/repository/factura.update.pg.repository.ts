import { register } from "module";
import { Affected, Result } from "../../../commons/result.mode";
import { FacturaUpdateRepository, UpdateFactura } from "../../models";
import { PoolClient, QueryResult } from "pg";
import { connectPg } from "../../../../settings/db.setting";

export class FacturaUpdatePgRepository implements FacturaUpdateRepository {
    async execute(id: string, factura: UpdateFactura): Promise<Result<number>> {
        const param = {
            register: factura,
        };

        const values = [id, param];
        const query = "SELECT store.invoice_update($1,$2)";

        const client: PoolClient = await connectPg.connect();
        let response: Result<Affected>;

        try {
            const result: QueryResult = await client.query(query, values);

            response = {
                status: "success",
                data: result.rowCount ? result.rowCount : 0,
                error: null,
            };
        } catch (error: any) {
            response = {
                status: "error",
                data: 0,
                error: error.message,
            };
        }
        return response;
    }
}
