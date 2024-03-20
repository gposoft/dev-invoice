import { Affected, Result } from "../../commons/result.mode";
import { UpdateStateById, UpdateStateByIdRepository } from "../models";

export class FacturaUpdateStateByIdService {
    constructor(private readonly providers: { facturaUpdateStateByIdRepository: UpdateStateByIdRepository }) {}

    async execute(id: string, state: UpdateStateById): Promise<Result<Affected>> {
        return this.providers.facturaUpdateStateByIdRepository.execute(id, state);
    }
}
