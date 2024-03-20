import { Detail } from "../../../commons/details.model";

export type State = "active" | "delete";

export interface Factura {
    id: string;
    state: State;
    folio: string;
    date: Date;
    client_code: string;
    concept: string;
    details: Detail[];
}
export interface CreateFactura {
    id: string;
    state: State;
    folio: string;
    date: Date;
    client_code: string;
    concept: string;
    details: Detail[];
}
export interface UpdateFactura {
    folio?: string;
    date?: Date;
    client_code?: string;
    concept?: string;
    details?: Detail[];
}
export interface UpdateStateById {
    state: State;
}
