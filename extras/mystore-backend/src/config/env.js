import "dotenv/config";

export default {
  port: Number(process.env.PORT) || 3000,
  databaseUrl: process.env.DATABASE_URL,
};
