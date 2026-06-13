import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/shared/favorites/domain/repositories/favorites_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_favorite_ids.g.dart';

class GetFavoriteIdsUseCase {
  GetFavoriteIdsUseCase({
    required this.favoritesRepository,
  });

  final FavoritesRepository favoritesRepository;

  Future<Set<String>> execute() async {
    return favoritesRepository.getFavoriteIds();
  }
}

@riverpod
GetFavoriteIdsUseCase getFavoriteIdsUseCase(Ref ref) {
  return GetFavoriteIdsUseCase(
    favoritesRepository: ref.watch(favoritesRepositoryProvider),
  );
}
