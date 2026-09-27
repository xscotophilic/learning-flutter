import 'package:my_store/features/favorites/domain/repositories/favorites_repository.dart';

class GetFavoriteIdsUseCase {
  const GetFavoriteIdsUseCase({required this.favoritesRepository});

  final FavoritesRepository favoritesRepository;

  Future<Set<String>> execute() async {
    return favoritesRepository.getFavoriteIds();
  }
}
