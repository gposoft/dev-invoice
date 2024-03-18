import { describe, test, assert } from "vitest";
import { Client, CreateClient, Result } from "../models";
import { ClientCreateService } from "../services";
import { ClientTestFactory } from "../../core/test/client.test.factory";

describe("Testeo del ClientService", () => {
    test("Testeo del CreateClient", async () => {
        const mockClientCreateRepo = {
            execute: async (client: CreateClient): Promise<Result<Client | null>> => {
                return {
                    status: "success",
                    data: client,
                    error: null,
                };
            },
        };
        const clientService = new ClientCreateService({ clientCreateRepository: mockClientCreateRepo });

        const expected: Result<Client | null> = {
            status: "success",
            data: ClientTestFactory.getClient({}),
            error: null,
        };

        const create: CreateClient = ClientTestFactory.getCreateClient({ paterno: "oramas", materno: "rojas", nombre: "angel" });

        const result = await clientService.execute(create);

        assert.deepEqual(result, expected);
    });
});
