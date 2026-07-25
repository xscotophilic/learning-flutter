import * as favoritesService from "../services/favorites.service.js";

export async function getFavoriteIds(req, res) {
  const favoriteIds = await favoritesService.getFavoriteIds(req.user_id);
  res.status(200).json({ data: favoriteIds });
}

export async function addFavorite(req, res) {
  const productId = req.body.product_id;
  await favoritesService.addFavorite(req.user_id, productId);
  res.status(200).json({ data: null });
}

export async function removeFavorite(req, res) {
  const productId = req.params.productId;
  await favoritesService.removeFavorite(req.user_id, productId);
  res.status(200).json({ data: null });
}
