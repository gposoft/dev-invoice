import { Affected, Result } from "../../../commons/result.mode";
import { UpdateStateById, UpdateStateByIdRepository } from "../../models";
import { PoolClient, QueryResult } from "pg";
import { connectPg } from "../../../../settings/db.setting";

export class FacturaUpdateStateByIdPgRepository implements UpdateStateByIdRepository {
    async execute(id: string, state: string): Promise<Result<number>> {
        const values = [id, state];
        const query = "SELECT providers.invoice_state_by_id($1,$2)";

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
