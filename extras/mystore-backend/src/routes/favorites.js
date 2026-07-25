import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import dummyAuth from "../middleware/dummyAuth.js";
import {
  getFavoriteIds,
  addFavorite,
  removeFavorite,
} from "../controllers/favorites.controller.js";

const router = express.Router();

router.get("/", dummyAuth, asyncHandler(getFavoriteIds));
router.post("/", dummyAuth, asyncHandler(addFavorite));
router.delete("/:productId", dummyAuth, asyncHandler(removeFavorite));

export default router;
