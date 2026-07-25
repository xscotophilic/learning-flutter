import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import dummyAuth from "../middleware/dummyAuth.js";
import { getCart, updateCartItem } from "../controllers/cart.controller.js";

const router = express.Router();

router.get("/", dummyAuth, asyncHandler(getCart));
router.patch("/items", dummyAuth, asyncHandler(updateCartItem));

export default router;
