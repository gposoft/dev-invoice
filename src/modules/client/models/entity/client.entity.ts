//codigo string
// paterno string
// materno string
// nombre string

export interface Client {
    id: string;
    code: string;
    paterno: string;
    materno: string;
    nombre: string;
}

export interface CreateClient {
    id: string;
    code: string;
    paterno: string;
    materno: string;
    nombre: string;
}

export interface UpdateClient {
    code?: string;
    paterno?: string;
    materno?: string;
    nombre?: string;
}
