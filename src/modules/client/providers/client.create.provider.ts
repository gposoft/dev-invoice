import { ClientDTO, CreateClientDTO } from "../../core/model/client.core.dto";
import { ClientServiceCore } from "../../core/services/client.core.service";
import { Client, ClientCreateRepository, CreateClient, Result } from "../models";

// export class ClientCreateProvider implements ClientServiceCore {
//     constructor(private readonly providers: { clientCreateRepository: ClientCreateRepository }) {}

//     async execute(client: CreateClientDTO): Promise<Result<ClientDTO>> {
//         const register: CreateClient = { ...client };
//         const result = await this.providers.clientCreateRepository.execute(register);

//         if (result.status === "error") {
//             return {
//                 status: "success",
//                 data: {
//                     id: client.id,
//                     code: client.code,
//                     paterno: client.paterno,
//                     materno: client.materno,
//                     nombre: client.nombre,
//                 },
//                 error: result.error,
//             };
//         }
//         return {
//             status: "success",
//             data: {
//                 id: client.id,
//                 code: result.data?.code!,
//                 paterno: result.data?.paterno!,
//                 materno: result.data?.materno!,
//                 nombre: result.data?.nombre!,
//             },
//             error: null,
//         };
//     }
// }
export class ClientCreateProvider implements ClientCreateRepository {
    constructor(private readonly providers: { clientCreateRepository: ClientCreateRepository }) {}

    async execute(client: CreateClient): Promise<Result<Client | null>> {
        const register = { ...client };
        const result = await this.providers.clientCreateRepository.execute(register);

        if (result.status === "error") {
            return {
                status: "success",
                data: {
                    id: client.id!,
                    code: client.code,
                    first_name: client.first_name,
                    second_name: client.second_name,
                    name: client.name,
                },
                error: result.error,
            };
        }
        return {
            status: "success",
            data: {
                id: client.id!,
                code: result.data?.code!,
                first_name: result.data?.first_name!,
                second_name: result.data?.second_name!,
                name: result.data?.name!,
            },
            error: null,
        };
    }
}
