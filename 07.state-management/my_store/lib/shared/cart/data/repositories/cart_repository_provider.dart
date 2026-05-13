import 'package:my_store/shared/cart/data/repositories/mock_cart_repository.dart';
import 'package:my_store/shared/cart/domain/repositories/cart_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_repository_provider.g.dart';

@Riverpod(keepAlive: true)
CartRepository cartRepository(Ref ref) {
  return MockCartRepository();
}
