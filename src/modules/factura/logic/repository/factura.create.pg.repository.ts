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
        const folioExistsQuery = "SELECT folio FROM store.invoice WHERE folio = $1";
        const folioExistsValues = [factura.folio];

        const folioExistsResult = await this.connectDb.query(folioExistsQuery, folioExistsValues);

        if (folioExistsResult.rows.length > 0) {
            // Si el código ya existe, devuelve un error
            return {
                status: "error",
                data: null,
                error: "El folio ya está en uso.",
            };
        }

        const param = {
            register: factura,
        };

        const values = [param];
        const query = "SELECT providers.invoice_create($1)";

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
