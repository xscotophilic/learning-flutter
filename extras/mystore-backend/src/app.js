import express from "express";

import productRoutes from "./routes/products.js";
import favoritesRoutes from "./routes/favorites.js";
import cartRoutes from "./routes/cart.js";
import orderRoutes from "./routes/orders.js";
import authRoutes from "./routes/auth.js";

import dummyAuth from "./middleware/dummyAuth.js";
import jwtAuth from "./middleware/jwtAuth.js";

import errorHandler from "./middleware/errorHandler.js";
import notFound from "./middleware/notFound.js";

const app = express();

app.use(express.json());

app.use("/api/v1/products", productRoutes(dummyAuth));
app.use("/api/v1/favorites", favoritesRoutes(dummyAuth));
app.use("/api/v1/cart", cartRoutes(dummyAuth));
app.use("/api/v1/orders", orderRoutes(dummyAuth));

app.use("/api/v2/auth", authRoutes);
app.use("/api/v2/products", productRoutes(jwtAuth));
app.use("/api/v2/favorites", favoritesRoutes(jwtAuth));
app.use("/api/v2/cart", cartRoutes(jwtAuth));
app.use("/api/v2/orders", orderRoutes(jwtAuth));

app.use(notFound);
app.use(errorHandler);

export default app;
