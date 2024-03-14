import { Client, ClientUpdateRepository, UpdateClient, Result } from "../models";

export class ClientUpdateService {
    constructor(private readonly providers: { clientUpdateRepository: ClientUpdateRepository }) {}

    execute(id: string, client: UpdateClient): Promise<Result<Client | null>> {
        return this.providers.clientUpdateRepository.execute(id, client);
    }
}
