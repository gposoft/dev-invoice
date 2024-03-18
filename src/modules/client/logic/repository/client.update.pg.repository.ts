import { Pool, PoolClient, QueryResult } from "pg";
import { Affected, Client, ClientUpdateRepository, CreateClient, Result, UpdateClient } from "../../models";
import { connectPg } from "../../../../settings/db.setting";
import { register } from "module";

export class ClientUpdatePgRepository implements ClientUpdateRepository {
    async execute(id: string, client: UpdateClient): Promise<Result<number>> {
        const param = {
            register: client,
        };

        const values = [id, param];
        const query = "SELECT store.client_update($1,$2)";

        const customer: PoolClient = await connectPg.connect();
        let response: Result<Affected>;

        try {
            const result: QueryResult = await customer.query(query, values);

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
