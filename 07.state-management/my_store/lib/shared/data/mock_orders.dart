import 'package:my_store/features/orders/domain/entities/order.dart';
import 'package:my_store/shared/product/domain/entities/price.dart';

class MockOrdersData {
  const MockOrdersData._();

  // TODO: Delete this
  static final orders = [
    Order(
      id: 'ORD-2024-001',
      placedAt: DateTime(2024, 11, 12, 14, 35),
      currency: 'USD',
      lineItems: const [
        OrderLineItem(
          productId: '1',
          quantity: 2,
          purchasePrice: Price(amount: 14.40, currency: 'USD'),
        ),
        OrderLineItem(
          productId: '4',
          quantity: 3,
          purchasePrice: Price(amount: 9.00, currency: 'USD'),
        ),
      ],
    ),
    Order(
      id: 'ORD-2025-002',
      placedAt: DateTime(2025, 3, 5, 9, 20),
      currency: 'USD',
      lineItems: const [
        OrderLineItem(
          productId: '2',
          quantity: 1,
          purchasePrice: Price(amount: 20.00, currency: 'USD'),
        ),
        OrderLineItem(
          productId: '3',
          quantity: 2,
          purchasePrice: Price(amount: 14.00, currency: 'USD'),
        ),
        OrderLineItem(
          productId: '5',
          quantity: 1,
          purchasePrice: Price(amount: 16.00, currency: 'USD'),
        ),
      ],
    ),
    Order(
      id: 'ORD-2025-003',
      placedAt: DateTime(2025, 4, 28, 18, 55),
      currency: 'USD',
      lineItems: const [
        OrderLineItem(
          productId: '6',
          quantity: 4,
          purchasePrice: Price(amount: 12.00, currency: 'USD'),
        ),
      ],
    ),
  ];
}
