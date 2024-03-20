import { PoolClient, QueryResult } from "pg";
import { Client, ClientGetByCodeRepository, Result } from "../../models";
import { connectPg } from "../../../../settings/db.setting";

export class ClientGetByCodePgRepository implements ClientGetByCodeRepository {
    async execute(code: string): Promise<Result<Client | null>> {
        const values = [code];
        const query = "SELECT * from store.client_get_by_code($1)";
        const customer: PoolClient = await connectPg.connect();

        let response: Result<Client | null>;

        try {
            const result: QueryResult = await customer.query(query, values);
            const dataset = result.rows.map((row) => <Client>row);

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
