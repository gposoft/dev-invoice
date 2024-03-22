import { FacturaGetByIdPgRepository, FacturaGetsPgRepository, FacturaUpdatePgRepository, FacturaUpdateStateByIdPgRepository, FacturCreatePgRepository } from "../logic";
import { FacturaCreateRepository, FacturaGetByIdRepository, FacturaGetsRepository, FacturaUpdateRepository, UpdateStateByIdRepository } from "../models";
import { FacturaCreateService, FacturaGetByIdService, FacturaGetsService, FacturaUpdateService, FacturaUpdateStateByIdService } from "../services";

const facturaCreateRepository: FacturaCreateRepository = new FacturCreatePgRepository();
const facturaUpdateRepository: FacturaUpdateRepository = new FacturaUpdatePgRepository();
const facturaGetsRepository: FacturaGetsRepository = new FacturaGetsPgRepository();
const facturaGetByIdRepository: FacturaGetByIdRepository = new FacturaGetByIdPgRepository();
const facturaUpdateStateByIdRepository: UpdateStateByIdRepository = new FacturaUpdateStateByIdPgRepository();

export const FacturaInjection = {
    create: () => new FacturaCreateService({ facturaCreateRepository }),
    update: () => new FacturaUpdateService({ facturaUpdateRepository }),
    gets: () => new FacturaGetsService({ facturaGetsRepository }),
    get: () => new FacturaGetByIdService({ facturaGetByIdRepository }),
    updateState: () => new FacturaUpdateStateByIdService({ facturaUpdateStateByIdRepository }),
};
