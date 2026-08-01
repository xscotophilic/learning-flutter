import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/favorites/domain/usecases/add_favorite.dart';
import 'package:my_store/features/favorites/domain/usecases/get_favorite_ids.dart';
import 'package:my_store/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_usecase_providers.g.dart';

@riverpod
AddFavoriteUseCase addFavoriteUseCase(Ref ref) {
  return AddFavoriteUseCase(
    favoritesRepository: ref.watch(favoritesRepositoryProvider),
  );
}

@riverpod
GetFavoriteIdsUseCase getFavoriteIdsUseCase(Ref ref) {
  return GetFavoriteIdsUseCase(
    favoritesRepository: ref.watch(favoritesRepositoryProvider),
  );
}

@riverpod
RemoveFavoriteUseCase removeFavoriteUseCase(Ref ref) {
  return RemoveFavoriteUseCase(
    favoritesRepository: ref.watch(favoritesRepositoryProvider),
  );
}
