import { Result } from "../../client/models";
import { ClientDTO, CreateClientDTO } from "../model/client.core.dto";

export interface ClientServiceCore {
    execute(client: CreateClientDTO): Promise<Result<ClientDTO | null>>;
}
