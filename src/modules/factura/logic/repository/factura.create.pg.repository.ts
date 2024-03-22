import { Pool, PoolClient, QueryResult } from "pg";
import { CreateFactura, Factura, FacturaCreateRepository } from "../../models";
import { connectPg } from "../../../../settings/db.setting";
import { Result } from "../../../commons/result.mode";
import { register } from "module";

export class FacturCreatePgRepository implements FacturaCreateRepository {
    private connectDb: Pool;

    constructor();
    constructor(connect: Pool);
    constructor(connect?: Pool) {
        if (connect) {
            this.connectDb = connect;
        } else {
            this.connectDb = connectPg;
        }
    }

    async execute(factura: CreateFactura): Promise<Result<Factura | null>> {
        const param = {
            register: factura,
        };

        const values = [param];
        const query = "SELECT store.invoice_create($1)";

        const client: PoolClient = await this.connectDb.connect();
        let response: Result<Factura | null>;

        try {
            const result: QueryResult = await client.query(query, values);
            const dataset = result.rows.map(({ factura_create: row }) => <Factura>row);

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
