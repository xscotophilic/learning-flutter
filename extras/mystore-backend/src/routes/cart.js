import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import auth from "../middleware/auth.js";
import { getCart, updateCartItem } from "../controllers/cart.controller.js";

const router = express.Router();

router.get("/", auth, asyncHandler(getCart));
router.patch("/items", auth, asyncHandler(updateCartItem));

export default router;
