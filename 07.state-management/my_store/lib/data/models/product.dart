extension CurrencyExtension on String {
  String get asCurrencySymbol {
    switch (this) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      default:
        return this;
    }
  }
}

class Price {
  const Price({
    required this.amount,
    required this.currency,
    this.discountPercent,
  });

  final double amount;
  final String currency;
  final double? discountPercent;

  String get formatted => '${currency.asCurrencySymbol}$amount';
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final Price price;
  final String imageUrl;
}
