import 'package:my_store/data/models/product.dart';

class MockData {
  const MockData._();

  static final heroProduct = products[3];

  static const products = [
    Product(
      id: '1',
      name: 'Peanut Butter Cookie',
      price: Price(amount: 18.0, currency: 'USD'),
      imageUrl: 'https://i.ibb.co/jBNW3CC/peanut-butter-cookie.webp',
    ),
    Product(
      id: '2',
      name: 'Oatmeal Raisin Cookie',
      price: Price(amount: 20.0, currency: 'USD'),
      imageUrl: 'https://i.ibb.co/Q79ByhmD/oatmeal-raisin-cookie.webp',
    ),
    Product(
      id: '3',
      name: 'Snickerdoodle',
      price: Price(amount: 14.0, currency: 'USD'),
      imageUrl: 'https://i.ibb.co/whXG6Y2w/snickerdoodle.webp',
    ),
    Product(
      id: '4',
      name: 'Choco Chip Cookie',
      price: Price(amount: 10.0, currency: 'USD'),
      imageUrl: 'https://i.ibb.co/9mS5StLX/choco-chip-cookie.webp',
    ),
    Product(
      id: '5',
      name: 'Shortbread Cookie',
      price: Price(amount: 16.0, currency: 'USD'),
      imageUrl: 'https://i.ibb.co/Kz7NyDpH/shortbread-cookie.webp',
    ),
    Product(
      id: '6',
      name: 'Molasses Cookie',
      price: Price(amount: 12.0, currency: 'USD'),
      imageUrl: 'https://i.ibb.co/Z6QhWxHG/molasses-cookie.webp',
    ),
  ];
}
