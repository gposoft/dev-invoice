import { Result } from "../../commons/result.mode";
import { CreateFactura, Factura, FacturaCreateRepository } from "../models";

export class FacturaCreateProvider implements FacturaCreateRepository {
    constructor(private readonly providers: { facturaCreateRepository: FacturaCreateRepository }) {}

    async execute(factura: CreateFactura): Promise<Result<Factura | null>> {
        const register: CreateFactura = { ...factura };
        const result = await this.providers.facturaCreateRepository.execute(register);

        if (result.status === "error") {
            return {
                status: "success",
                data: {
                    id: factura.id,
                    state: factura.state,
                    folio: factura.folio,
                    date: factura.date,
                    client_code: factura.client_code,
                    concept: factura.concept,
                    details: factura.details,
                },
                error: result.error,
            };
        }

        return {
            status: "success",
            data: {
                id: result.data?.id!,
                state: result.data?.state!,
                folio: result.data?.folio!,
                date: result.data?.date!,
                client_code: result.data?.client_code!,
                concept: result.data?.concept!,
                details: result.data?.details!,
            },
            error: null,
        };
    }
}
