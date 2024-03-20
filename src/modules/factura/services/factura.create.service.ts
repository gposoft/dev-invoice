import { Result } from "../../commons/result.mode";
import { CreateFactura, Factura, FacturaCreateRepository } from "../models";

export class FacturaCreateService {
    constructor(private readonly providers: { facturaCreateRepository: FacturaCreateRepository }) {}

    async execute(factura: CreateFactura): Promise<Result<Factura | null>> {
        return this.providers.facturaCreateRepository.execute(factura);
    }
}
