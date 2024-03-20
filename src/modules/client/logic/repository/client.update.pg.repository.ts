import { PoolClient, QueryResult } from "pg";
import { Affected, ClientUpdateRepository, Result, UpdateClient } from "../../models";
import { connectPg } from "../../../../settings/db.setting";
import { register } from "module";

export class ClientUpdatePgRepository implements ClientUpdateRepository {
    async execute(client_id: string, client: UpdateClient): Promise<Result<number>> {
        const param = {
            register: client,
        };

        const customer: PoolClient = await connectPg.connect();

        const codeGetIdQuery = "SELECT client_id FROM store.client WHERE code = $1";

        const codeIdResult = await customer.query(codeGetIdQuery, [client_id]);
        const codeId = codeIdResult.rows[0].client_id;
        const values = [codeId, param];
        const query = "SELECT store.client_update($1,$2)";
        console.log(values);

        let response: Result<Affected>;

        try {
            const result: QueryResult = await customer.query(query, values);
            console.log(result.fields);

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
        console.log(response);

        return response;
    }
}
