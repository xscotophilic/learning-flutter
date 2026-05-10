import 'package:my_store/shared/favorites/data/repositories/mock_favorites_repository.dart';
import 'package:my_store/shared/favorites/domain/repositories/favorites_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_repository_provider.g.dart';

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(Ref ref) {
  return MockFavoritesRepository();
}
