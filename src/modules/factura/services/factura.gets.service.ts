import { Result } from "../../commons/result.mode";
import { Factura, FacturaGetsRepository } from "../models";

export class FacturaGetsService {
    constructor(private readonly providers: { facturaGetsRepository: FacturaGetsRepository }) {}

    async execute(): Promise<Result<Factura[]>> {
        return this.providers.facturaGetsRepository.execute();
    }
}
