import 'package:my_store/shared/favorites/domain/repositories/favorites_repository.dart';

final class MockFavoritesRepository implements FavoritesRepository {
  static const Duration _kNetworkDelay = Duration(milliseconds: 250);

  final Set<String> _favoriteIds = {};

  @override
  Future<Set<String>> getFavoriteIds() async {
    await Future<void>.delayed(_kNetworkDelay);
    return _favoriteIds;
  }

  @override
  Future<void> addFavorite(String productId) async {
    await Future<void>.delayed(_kNetworkDelay);
    _favoriteIds.add(productId);
  }

  @override
  Future<void> removeFavorite(String productId) async {
    await Future<void>.delayed(_kNetworkDelay);
    _favoriteIds.remove(productId);
  }
}
