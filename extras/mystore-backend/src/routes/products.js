import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import auth from "../middleware/auth.js";
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
router.get("/mine", auth, asyncHandler(getMyProducts));
router.post("/", auth, asyncHandler(createProduct));
router.put("/:id", auth, asyncHandler(updateProduct));
router.delete("/:id", auth, asyncHandler(deleteProduct));

export default router;
