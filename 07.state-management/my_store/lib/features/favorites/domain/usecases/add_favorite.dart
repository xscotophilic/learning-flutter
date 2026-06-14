import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_favorite.g.dart';

class AddFavoriteUseCase {
  const AddFavoriteUseCase({required this.favoritesRepository});

  final FavoritesRepository favoritesRepository;

  Future<void> execute(String productId) async {
    return favoritesRepository.addFavorite(productId);
  }
}

@riverpod
AddFavoriteUseCase addFavoriteUseCase(Ref ref) {
  return AddFavoriteUseCase(
    favoritesRepository: ref.watch(favoritesRepositoryProvider),
  );
}
