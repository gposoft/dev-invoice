import { ClientInjection } from "./modules/client/dependencies/client.dependecies";
import { CreateClient } from "./modules/client/models";
import { FacturaInjection } from "./modules/factura/dependencies/factura.dependecies";
import { CreateFactura } from "./modules/factura/models";
// INDEX PARA EL MODULO DE CLIENTE
// async function init() {
//     const createService = ClientInjection.create();
//     const customer: CreateClient = {
//         code: "P01",
//         first_name: "oramas",
//         second_name: "rojas",
//         name: "angel",
//     };

//     // const result = await createService.execute(customer);
//     // if (result.status === "success") {
//     //     console.log("Se guardo el registro:");
//     //     console.table(result);
//     // } else {
//     //     console.log("Se encontro un error:", result.error);
//     //     const updateService = ClientInjection.update();
//     //     const resultUpdate = await updateService.execute("P01", { name: "ANGEL" });
//     //     console.log("Afectaciones:", resultUpdate.data);
//     // }

//     const getClient = await ClientInjection.get();
//     const resultGetById = await getClient.execute("P01");

//     console.table(resultGetById.data);
// }

async function init() {
    // const createService = FacturaInjection.create();
    // const facturas: CreateFactura = {
    //     id: "001",
    //     state: "active",
    //     folio: "F200",
    //     date: new Date(2024, 3, 14),
    //     client_code: "P01",
    //     concept: "MI PRIMER FACTURA",
    //     details: [
    //         { cant: 10, concept: "concepto 1", amount: 100.8 },
    //         { cant: 1, concept: "concepto 2", amount: 1000.5 },
    //     ],
    // };
    // const result = await createService.execute(facturas);
    // if (result.status === "success") {
    //     console.log("Se guardo el registro de factura");
    //     console.table(result);
    // } else {
    //     console.log("Se encontro un error:", result.error);
    //     console.log("Se actualizara el dato");
    // const updateService = FacturaInjection.update();
    // const resultUpdate = await updateService.execute("001", { concept: "NUEVA ACTUALIZACION DE LA FACTURA" });
    // console.log("Afectaciones:", resultUpdate.data);
    // }
    /*
    const getClient = await FacturaInjection.get();
    const resultGetById = await getClient.execute("001");
    console.table(resultGetById.data);
    */
    const updateStateService = FacturaInjection.updateState();
    const resultUpdate = await updateStateService.execute("001", "delete");
    console.log("Afectaciones:", resultUpdate.data);
    console.log(resultUpdate.error);
}

init();
