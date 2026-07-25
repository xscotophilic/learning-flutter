import 'package:my_store/core/network/api_client.dart';
import 'package:my_store/features/favorites/domain/repositories/favorites_repository.dart';

final class ApiFavoritesRepository implements FavoritesRepository {
  const ApiFavoritesRepository(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<Set<String>> getFavoriteIds() async {
    final json = await apiClient.get('/favorites');
    if (json is List) {
      return json.map((e) => e.toString()).toSet();
    }
    return <String>{};
  }

  @override
  Future<void> addFavorite(String productId) async {
    await apiClient.post('/favorites', body: {'product_id': productId});
  }

  @override
  Future<void> removeFavorite(String productId) async {
    await apiClient.delete('/favorites/$productId');
  }
}
