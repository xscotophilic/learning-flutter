import pg from "pg";
import env from "../config/env.js";

const { Pool } = pg;

const pool = new Pool({
  connectionString: env.databaseUrl,
});

export async function query(sql, params = []) {
  const result = await pool.query(sql, params);
  return result.rows;
}

export async function getClient() {
  return pool.connect();
}

const connectDB = async () => {
  try {
    if (!env.databaseUrl) {
      throw new Error("DATABASE_URL is not defined in the environment");
    }

    await pool.query("SELECT 1");

    console.log("PostgreSQL connected");
  } catch (error) {
    console.error("PostgreSQL connection error:", error.message);
    process.exit(1);
  }
};

export { pool };
export default connectDB;
