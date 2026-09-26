import Favorite from "../models/Favorite.js";
import Product from "../models/Product.js";
import ApiError from "../utils/ApiError.js";

export async function getFavoriteIds(userId) {
  return Favorite.findAllByUserId(userId);
}

export async function addFavorite(userId, productId) {
  if (!productId) {
    throw new ApiError(400, "Product ID is required");
  }

  const product = await Product.findById(productId);
  if (!product) {
    throw new ApiError(404, "Product not found");
  }

  await Favorite.add(userId, productId);
}

export async function removeFavorite(userId, productId) {
  if (!productId) {
    throw new ApiError(400, "Product ID is required");
  }

  await Favorite.remove(userId, productId);
}
