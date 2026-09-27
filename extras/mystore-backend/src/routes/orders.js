import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import { createOrder, getOrders } from "../controllers/orders.controller.js";

export default function ordersRouter(auth) {
  const router = express.Router();

  router.post("/", auth, asyncHandler(createOrder));
  router.get("/", auth, asyncHandler(getOrders));

  return router;
}
