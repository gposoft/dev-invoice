import { Result } from "../../commons/result.mode";
import { Factura, FacturaGetByIdRepository } from "../models";

export class FacturaGetByIdService {
    constructor(private readonly proviers: { facturaGetByIdRepository: FacturaGetByIdRepository }) {}

    async execute(id: string): Promise<Result<Factura | null>> {
        return this.proviers.facturaGetByIdRepository.execute(id);
    }
}
