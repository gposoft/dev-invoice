import { Client, ClientGetByCodeRepository, Result } from "../models";

export class ClientGetByCodeService {
    constructor(private readonly providers: { clientGetByCodeRepository: ClientGetByCodeRepository }) {}

    async execute(code: string): Promise<Result<Client | null>> {
        return this.providers.clientGetByCodeRepository.execute(code);
    }
}
