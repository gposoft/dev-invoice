import { Client, ClientCreateRepository, CreateClient, Result } from "../models";

export class ClientCreateService {
    constructor(private readonly providers: { clientCreateRepository: ClientCreateRepository }) {}

    execute(client: CreateClient): Promise<Result<Client | null>> {
        return this.providers.clientCreateRepository.execute(client);
    }
}
