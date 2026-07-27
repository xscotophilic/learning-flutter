import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import { getCart, updateCartItem } from "../controllers/cart.controller.js";

export default function cartRouter(auth) {
  const router = express.Router();

  router.get("/", auth, asyncHandler(getCart));
  router.patch("/items", auth, asyncHandler(updateCartItem));

  return router;
}
