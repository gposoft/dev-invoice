import { Affected, Result } from "../../../commons/result.mode";
import { CreateFactura, Factura, UpdateFactura, UpdateStateById } from "../entity/factura.entity";

export interface FacturaCreateRepository {
    execute(factura: CreateFactura): Promise<Result<Factura | null>>;
}
export interface FacturaUpdateRepository {
    execute(id: string, factura: UpdateFactura): Promise<Result<Affected>>;
}
export interface FacturaGetsRepository {
    execute(): Promise<Result<Factura[]>>;
}
export interface FacturaGetByIdRepository {
    execute(id: string): Promise<Result<Factura | null>>;
}
export interface UpdateStateByIdRepository {
    execute(id: string, state: UpdateStateById): Promise<Result<Affected>>;
}
