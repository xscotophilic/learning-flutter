import 'package:my_store/features/favorites/domain/repositories/favorites_repository.dart';

class RemoveFavoriteUseCase {
  const RemoveFavoriteUseCase({required this.favoritesRepository});

  final FavoritesRepository favoritesRepository;

  Future<void> execute(String productId) async {
    return favoritesRepository.removeFavorite(productId);
  }
}
