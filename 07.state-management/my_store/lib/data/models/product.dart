class Price {
  const Price({required this.amount, required this.currency, this.discount});

  final double amount;
  final String currency;
  final String? discount;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final Price price;
  final String imageUrl;
}
