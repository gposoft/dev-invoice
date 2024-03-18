import { Client, CreateClient } from "../../client/models";

export class ClientTestFactory {
    static getClient({ id = "1", code = "code1", paterno = "oramas", materno = "rojas", nombre = "angel" }): Client {
        return {
            id,
            code,
            paterno,
            materno,
            nombre,
        };
    }

    static getCreateClient({ id = "1", code = "code1", paterno = "name1", materno = "description1", nombre = "sort1" }): CreateClient {
        return {
            id,
            code,
            paterno,
            materno,
            nombre,
        };
    }
}
