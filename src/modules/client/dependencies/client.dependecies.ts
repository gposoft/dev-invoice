import { ClientCreatePgRepository, ClientGetByCodePgRepository, ClientUpdatePgRepository } from "../logic";
import { ClientCreateRepository, ClientUpdateRepository } from "../models";
import { ClientCreateService, ClientGetByCodeService, ClientUpdateService } from "../services";

const clientCreateRepository: ClientCreateRepository = new ClientCreatePgRepository();
const clientUpdateRepository: ClientUpdateRepository = new ClientUpdatePgRepository();
const clientGetByCodeRepository: ClientGetByCodePgRepository = new ClientGetByCodePgRepository();

export const ClientInjection = {
    create: () => new ClientCreateService({ clientCreateRepository }),
    update: () => new ClientUpdateService({ clientUpdateRepository }),
    get: () => new ClientGetByCodeService({ clientGetByCodeRepository }),
};
