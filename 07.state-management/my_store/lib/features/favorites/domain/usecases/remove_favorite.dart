import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remove_favorite.g.dart';

class RemoveFavoriteUseCase {
  RemoveFavoriteUseCase({required this.favoritesRepository});

  final FavoritesRepository favoritesRepository;

  Future<void> execute(String productId) async {
    return favoritesRepository.removeFavorite(productId);
  }
}

@riverpod
RemoveFavoriteUseCase removeFavoriteUseCase(Ref ref) {
  return RemoveFavoriteUseCase(
    favoritesRepository: ref.watch(favoritesRepositoryProvider),
  );
}
