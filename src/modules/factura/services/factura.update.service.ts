import { Affected, Result } from "../../commons/result.mode";
import { FacturaUpdateRepository, UpdateFactura } from "../models";

export class FacturaUpdateService {
    constructor(private readonly providers: { facturaUpdateRepository: FacturaUpdateRepository }) {}

    async execute(id: string, factura: UpdateFactura): Promise<Result<Affected>> {
        return this.providers.facturaUpdateRepository.execute(id, factura);
    }
}
