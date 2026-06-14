abstract interface class FavoritesRepository {
  Future<Set<String>> getFavoriteIds();

  Future<void> addFavorite(String productId);

  Future<void> removeFavorite(String productId);
}
