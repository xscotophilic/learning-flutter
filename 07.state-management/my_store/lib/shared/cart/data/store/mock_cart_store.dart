import 'package:my_store/shared/cart/domain/entities/cart.dart';

class MockCartStore {
  MockCartStore._internal();

  factory MockCartStore() => _instance;

  static final MockCartStore _instance = MockCartStore._internal();

  final Map<String, Cart<CartItem>> carts = {};
}
