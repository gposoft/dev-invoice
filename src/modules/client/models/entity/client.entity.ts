//codigo string
// paterno string
// materno string
// nombre string

export interface Client {
    id: string;
    code: string;
    first_name: string;
    second_name: string;
    name: string;
}

export interface CreateClient {
    //id: string;
    code: string;
    first_name: string;
    second_name: string;
    name: string;
}

export interface UpdateClient {
    code?: string;
    first_name?: string;
    second_name?: string;
    name?: string;
}
