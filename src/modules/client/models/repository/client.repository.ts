import { Affected, Result } from "../commons/result.mode";
import { Client, CreateClient, UpdateClient } from "../entity/client.entity";

export interface ClientCreateRepository {
    execute(client: CreateClient): Promise<Result<Client | null>>;
}

export interface ClientUpdateRepository {
    execute(id: string, client: UpdateClient): Promise<Result<Affected>>;
}

export interface ClientGetByCodeRepository {
    execute(code: string): Promise<Result<Client | null>>;
}
