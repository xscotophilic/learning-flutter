import 'package:my_store/features/favorites/domain/usecases/add_favorite.dart';
import 'package:my_store/features/favorites/domain/usecases/get_favorite_ids.dart';
import 'package:my_store/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_notifier.g.dart';

@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  Future<Set<String>> build() async {
    final getFavoriteIds = ref.watch(getFavoriteIdsUseCaseProvider);
    return getFavoriteIds.execute();
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
      if (isCurrentlyFavorite) {
        final removeFavorite = ref.read(removeFavoriteUseCaseProvider);
        await removeFavorite.execute(productId);
      } else {
        final addFavorite = ref.read(addFavoriteUseCaseProvider);
        await addFavorite.execute(productId);
      }
    } catch (e) {
      state = AsyncData(currentState);
    }
  }
}
