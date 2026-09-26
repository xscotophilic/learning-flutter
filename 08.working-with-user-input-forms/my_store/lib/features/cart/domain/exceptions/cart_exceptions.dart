class CartException implements Exception {
  const CartException(this.message);
  final String message;

  @override
  String toString() => 'CartException: $message';
}

class CartNotFoundException extends CartException {
  const CartNotFoundException() : super('Cart not found');
}
