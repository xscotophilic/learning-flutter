import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_store/shared/favorites/presentation/providers/favorites_notifier.dart';

class FavoriteButton extends ConsumerStatefulWidget {
  const FavoriteButton({super.key, required this.productId, this.iconSize});

  final String productId;
  final double? iconSize;

  @override
  ConsumerState<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton>
    with SingleTickerProviderStateMixin {
  final Duration _duration = const Duration(milliseconds: 200);
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _duration, vsync: this);

    _rotationAnimation = TweenSequence<double>([
      // rotate toward the positive direction
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: 0.05,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      // rotate toward the negative direction
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.05,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(
      favoritesProvider.select(
        (s) => s.value?.contains(widget.productId) ?? false,
      ),
    );

    return GestureDetector(
      onTap: () {
        _controller.forward(from: 0.0);
        ref.read(favoritesProvider.notifier).toggle(widget.productId);
      },
      behavior: HitTestBehavior.opaque,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: AnimatedSwitcher(
          duration: _duration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            key: ValueKey(isFavorite),
            color: isFavorite ? Colors.red : null,
            size: widget.iconSize,
          ),
        ),
      ),
    );
  }
}
