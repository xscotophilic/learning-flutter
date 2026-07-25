import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import dummyAuth from "../middleware/dummyAuth.js";
import { createOrder, getOrders } from "../controllers/orders.controller.js";

const router = express.Router();

router.post("/", dummyAuth, asyncHandler(createOrder));
router.get("/", dummyAuth, asyncHandler(getOrders));

export default router;
