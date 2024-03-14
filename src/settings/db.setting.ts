import { Pool } from "pg";
import { envSetting } from "./env.setting";

export const connectPg = new Pool({
    user: envSetting.db.postgres.DB_USER,
    password : envSetting.db.postgres.DB_PASSWORD,
    host: envSetting.db.postgres.DB_SERVER,
    port: Number(envSetting.db.postgres.DB_PORT),
    database: envSetting.db.postgres.DB_DATA
})

