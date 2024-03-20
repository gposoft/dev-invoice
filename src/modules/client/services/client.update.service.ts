import { Client, ClientUpdateRepository, UpdateClient, Result, Affected } from "../models";

export class ClientUpdateService {
    constructor(private readonly providers: { clientUpdateRepository: ClientUpdateRepository }) {}

    execute(client_id: string, client: UpdateClient): Promise<Result<Affected>> {
        return this.providers.clientUpdateRepository.execute(client_id, client);
    }
}
