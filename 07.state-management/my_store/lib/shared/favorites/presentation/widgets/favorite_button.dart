import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/shared/favorites/presentation/providers/favorites_notifier.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({super.key, required this.productId, this.iconSize});

  final String productId;
  final double? iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(
      favoritesProvider.select((s) => s.value?.contains(productId) ?? false),
    );

    final icon = isFavorite ? Icons.favorite : Icons.favorite_border;
    final color = isFavorite ? Colors.red : null;

    return GestureDetector(
      onTap: () => ref.read(favoritesProvider.notifier).toggle(productId),
      child: Icon(icon, color: color, size: iconSize),
    );
  }
}
