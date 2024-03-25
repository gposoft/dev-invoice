import { FacturaGetByIdPgRepository, FacturaGetsPgRepository, FacturaUpdatePgRepository, FacturaUpdateStateByIdPgRepository, FacturCreatePgRepository } from "../logic";
import { FacturaStateGetAllPgRepository } from "../logic/repository/factura.stategetall.pg.repository";
import {
    FacturaCreateRepository,
    FacturaGetByIdRepository,
    FacturaGetsRepository,
    FacturaStateGetAllRepository,
    FacturaUpdateRepository,
    UpdateStateByIdRepository,
} from "../models";
import { FacturaCreateService, FacturaGetByIdService, FacturaGetsService, FacturaUpdateService, FacturaUpdateStateByIdService } from "../services";
import { FacturaStateGetAllService } from "../services/factura.stategetall.service";

const facturaCreateRepository: FacturaCreateRepository = new FacturCreatePgRepository();
const facturaUpdateRepository: FacturaUpdateRepository = new FacturaUpdatePgRepository();
const facturaGetsRepository: FacturaGetsRepository = new FacturaGetsPgRepository();
const facturaGetByIdRepository: FacturaGetByIdRepository = new FacturaGetByIdPgRepository();
const facturaUpdateStateByIdRepository: UpdateStateByIdRepository = new FacturaUpdateStateByIdPgRepository();
const facturaStateGetAllRepository: FacturaStateGetAllRepository = new FacturaStateGetAllPgRepository();

export const FacturaInjection = {
    create: () => new FacturaCreateService({ facturaCreateRepository }),
    update: () => new FacturaUpdateService({ facturaUpdateRepository }),
    gets: () => new FacturaGetsService({ facturaGetsRepository }),
    get: () => new FacturaGetByIdService({ facturaGetByIdRepository }),
    updateState: () => new FacturaUpdateStateByIdService({ facturaUpdateStateByIdRepository }),
    getAll: () => new FacturaStateGetAllService({ facturaStateGetAllRepository }),
};
