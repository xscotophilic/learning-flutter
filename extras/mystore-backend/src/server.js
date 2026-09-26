import app from "./app.js";
import connectDB from "./db/index.js";
import env from "./config/env.js";

async function start() {
  await connectDB();

  app.listen(env.port, () => {
    console.log(`Server listening on ${env.port}`);
  });
}

start().catch((err) => {
  console.error(err);
  process.exit(1);
});
