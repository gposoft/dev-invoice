import { Pool, PoolClient, QueryResult } from "pg";
import { Client, ClientCreateRepository, CreateClient, Result } from "../../models";
import { connectPg } from "../../../../settings/db.setting";
import { register } from "module";

export class ClientCreatePgRepository implements ClientCreateRepository {
    private connectDB: Pool;

    constructor();
    constructor(connect: Pool);

    constructor(connect?: Pool) {
        if (connect) {
            this.connectDB = connect;
        } else {
            this.connectDB = connectPg;
        }
    }

    async execute(client: CreateClient): Promise<Result<Client | null>> {
        const codeExistsQuery = "SELECT code FROM store.client WHERE code = $1";
        const codeExistsValues = [client.code];

        const codeExistsResult = await this.connectDB.query(codeExistsQuery, codeExistsValues);

        if (codeExistsResult.rows.length > 0) {
            // Si el código ya existe, devuelve un error
            return {
                status: "error",
                data: null,
                error: "El código del cliente ya está en uso.",
            };
        }

        const param = {
            register: client,
        };

        const values = [param];
        const query = "SELECT store.client_create($1)";

        const customer: PoolClient = await this.connectDB.connect();
        let response: Result<Client | null>;

        try {
            const result: QueryResult = await customer.query(query, values);
            const dataset = result.rows.map(({ client_create: row }) => <Client>row);

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
