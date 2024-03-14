import {config} from "dotenv"
config();

export const envSetting = {
  db: {
    postgres: {
      DB_USER: process.env.DB_POSTGRES_USER,
      DB_PASSWORD: process.env.DB_POSTGRES_PASSWORD,
      DB_SERVER: process.env.DB_POSTGRES_SERVER,
      DB_DATA: process.env.DB_POSTGRES_DATA,
      DB_PORT: process.env.DB_POSTGRES_PORT
    },
  },
};
