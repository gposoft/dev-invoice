import { Result } from "../../commons/result.mode";
import { Factura, FacturaStateGetAllRepository } from "../models";

export class FacturaStateGetAllService {
    constructor(private readonly providers: { facturaStateGetAllRepository: FacturaStateGetAllRepository }) {}

    async execute(state: string): Promise<Result<Factura[]>> {
        return this.providers.facturaStateGetAllRepository.execute(state);
    }
}
