import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import {
  getFavoriteIds,
  addFavorite,
  removeFavorite,
} from "../controllers/favorites.controller.js";

export default function favoritesRouter(auth) {
  const router = express.Router();

  router.get("/", auth, asyncHandler(getFavoriteIds));
  router.post("/", auth, asyncHandler(addFavorite));
  router.delete("/:productId", auth, asyncHandler(removeFavorite));

  return router;
}
