class Price {
  const Price({required this.amount, required this.currency, this.discount});

  final double amount;
  final String currency;
  final String? discount;

  String get currencySymbol {
    switch (currency) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      default:
        return currency;
    }
  }

  String get formatted => '$currencySymbol$amount';
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
