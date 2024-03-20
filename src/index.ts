import { format } from "date-fns";
import { ClientInjection } from "./modules/client/dependencies/client.dependecies";
import { CreateClient } from "./modules/client/models";

async function init() {
    const createService = ClientInjection.create();
    const customer: CreateClient = {
        code: "P01",
        first_name: "oramas",
        second_name: "rojas",
        name: "angel",
    };

    // const result = await createService.execute(customer);
    // if (result.status === "success") {
    //     console.log("Se guardo el registro:");
    //     console.table(result);
    // } else {
    //     console.log("Se encontro un error:", result.error);
    //     const updateService = ClientInjection.update();
    //     const resultUpdate = await updateService.execute("P01", { name: "ANGEL" });
    //     console.log("Afectaciones:", resultUpdate.data);
    // }

    const getClient = await ClientInjection.get();
    const resultGetById = await getClient.execute("P01");

    console.table(resultGetById.data);
}

init();
