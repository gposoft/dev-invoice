import { format } from "date-fns";
import { ClientInjection } from "./modules/client/dependencies/client.dependecies";
import { CreateClient } from "./modules/client/models";

async function init() {
    // console.log("init ...!");

    // const date1 = format(new Date(2014, 11, 31), "yyyy-MM-dd"); // yyyy , MM , dd =>  MM 0 - 11
    // const date2 = format(Date.now(), "yyyy-MM-dd");
    // const date3 = format(new Date("2014-12-31T00:00:00"), "yyyy-MM-dd"); // se requiere T00:00:00 para que de la fecha esperada

    // const fechas = {
    //   fecha1: date1,
    //   fecha2: date2,
    //   fecha3: date3,
    // };

    // console.table(fechas);

    const createService = ClientInjection.create();
    const customer: CreateClient = {
        code: "P01",
        first_name: "oramas",
        second_name: "rojas",
        name: "angel",
    };

    const result = await createService.execute(customer);
    console.table(result);
}

init();
