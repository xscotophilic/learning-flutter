import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import dummyAuth from "../middleware/dummyAuth.js";
import {
  getHeroProduct,
  getFeaturedProducts,
  getProductsByIds,
  getMyProducts,
  createProduct,
  updateProduct,
  deleteProduct,
} from "../controllers/products.controller.js";

const router = express.Router();

router.get("/hero", asyncHandler(getHeroProduct));
router.get("/featured", asyncHandler(getFeaturedProducts));
router.post("/bulk", asyncHandler(getProductsByIds));
router.get("/mine", dummyAuth, asyncHandler(getMyProducts));
router.post("/", dummyAuth, asyncHandler(createProduct));
router.put("/:id", dummyAuth, asyncHandler(updateProduct));
router.delete("/:id", dummyAuth, asyncHandler(deleteProduct));

export default router;
