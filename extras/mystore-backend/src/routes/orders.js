import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import auth from "../middleware/auth.js";
import { createOrder, getOrders } from "../controllers/orders.controller.js";

const router = express.Router();

router.post("/", auth, asyncHandler(createOrder));
router.get("/", auth, asyncHandler(getOrders));

export default router;
