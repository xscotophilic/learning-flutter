import 'package:my_store/shared/favorites/data/repositories/favorites_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_notifier.g.dart';

@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  Future<Set<String>> build() async {
    final repository = ref.watch(favoritesRepositoryProvider);
    return repository.getFavoriteIds();
  }

  Future<void> toggle(String productId) async {
    final currentState = state.value ?? await future;
    final isCurrentlyFavorite = currentState.contains(productId);

    final nextState = {...currentState};
    if (isCurrentlyFavorite) {
      nextState.remove(productId);
    } else {
      nextState.add(productId);
    }
    state = AsyncData(nextState);

    try {
      final repository = ref.read(favoritesRepositoryProvider);
      if (isCurrentlyFavorite) {
        await repository.removeFavorite(productId);
      } else {
        await repository.addFavorite(productId);
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
