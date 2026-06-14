import 'package:my_store/features/favorites/domain/repositories/favorites_repository.dart';

class AddFavoriteUseCase {
  const AddFavoriteUseCase({required this.favoritesRepository});

  final FavoritesRepository favoritesRepository;

  Future<void> execute(String productId) async {
    return favoritesRepository.addFavorite(productId);
  }
}
