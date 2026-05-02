import 'package:my_store/data/models/cart.dart';
import 'package:my_store/data/models/order.dart';
import 'package:my_store/data/models/price.dart';
import 'package:my_store/data/models/product.dart';
import 'package:my_store/data/models/total.dart';

class MockData {
  const MockData._();

  static final heroProduct = products[3];

  static Product? findProductById(String id) {
    return products.cast<Product?>().firstWhere(
      (p) => p?.id == id,
      orElse: () => null,
    );
  }

  static const products = [
    Product(
      id: '1',
      name: 'Peanut Butter Cookie',
      description:
          'A rich, indulgent cookie packed with creamy peanut butter flavor in every bite. '
          'Perfectly crisp on the edges with a soft, chewy center that melts in your mouth. '
          'Made with premium roasted peanut butter and a touch of vanilla for extra depth. '
          'The classic crosshatch pattern isn\'t just for looks — it ensures even baking throughout. '
          'A timeless treat loved by peanut butter fans of all ages.',
      price: Price(amount: 18.0, currency: 'USD', discountPercent: 10),
      imageUrl: 'https://i.ibb.co/jBNW3CC/peanut-butter-cookie.webp',
    ),
    Product(
      id: '2',
      name: 'Oatmeal Raisin Cookie',
      description:
          'A wholesome, hearty cookie loaded with plump, juicy raisins and rolled oats. '
          'Warmly spiced with cinnamon and a hint of nutmeg for that cozy, homemade aroma. '
          'Each bite delivers a satisfying chew from thick oats and naturally sweet raisins. '
          'Baked to golden perfection with crisp edges and a tender, soft interior. '
          'A classic comfort cookie that feels like a warm hug with every single bite.',
      price: Price(amount: 20.0, currency: 'USD', discountPercent: 10),
      imageUrl: 'https://i.ibb.co/Q79ByhmD/oatmeal-raisin-cookie.webp',
    ),
    Product(
      id: '3',
      name: 'Snickerdoodle',
      description:
          'A beloved classic rolled generously in a fragrant cinnamon-sugar coating before baking. '
          'Soft, pillowy, and slightly tangy thanks to a touch of cream of tartar in the dough. '
          'The warm cinnamon crust gives way to a melt-in-your-mouth, buttery soft center. '
          'Simple yet irresistible, this cookie fills the room with a comforting, spiced aroma. '
          'Perfect for sharing — though once you start, stopping is nearly impossible.',
      price: Price(amount: 14.0, currency: 'USD'),
      imageUrl: 'https://i.ibb.co/whXG6Y2w/snickerdoodle.webp',
    ),
    Product(
      id: '4',
      name: 'Choco Chip Cookie',
      description:
          'The ultimate crowd-pleaser, loaded with generous pockets of rich semi-sweet chocolate chips. '
          'Golden-brown and perfectly crisp on the outside with a gooey, soft center inside. '
          'Made with brown butter and a blend of sugars for deep caramel-like undertones. '
          'Every bite guarantees melty chocolate in every single mouthful — no dry spots here. '
          'The cookie that started it all, and still the one everyone reaches for first.',
      price: Price(amount: 10.0, currency: 'USD', discountPercent: 10),
      imageUrl: 'https://i.ibb.co/9mS5StLX/choco-chip-cookie.webp',
    ),
    Product(
      id: '5',
      name: 'Shortbread Cookie',
      description:
          'An elegant, buttery cookie with a delicate crumb that simply dissolves on the tongue. '
          'Made with just a few quality ingredients — real butter, flour, and a whisper of sugar. '
          'Its simplicity is its strength, letting the rich, creamy butter flavor truly shine. '
          'Lightly golden with a satisfying snap, it pairs beautifully with tea or coffee. '
          'A refined, timeless classic that proves the finest things in life are often the simplest.',
      price: Price(amount: 16.0, currency: 'USD'),
      imageUrl: 'https://i.ibb.co/Kz7NyDpH/shortbread-cookie.webp',
    ),
    Product(
      id: '6',
      name: 'Molasses Cookie',
      description:
          'A bold, deeply spiced cookie made with rich blackstrap molasses for intense, complex flavor. '
          'Infused with a warming blend of ginger, cloves, and cinnamon in every single bite. '
          'The molasses keeps these cookies incredibly soft and chewy for days after baking. '
          'Rolled in sugar before baking for a sparkly, slightly crisp exterior that contrasts beautifully. '
          'A festive favorite that brings warmth and spice to any cookie jar or dessert spread.',
      price: Price(amount: 12.0, currency: 'USD'),
      imageUrl: 'https://i.ibb.co/Z6QhWxHG/molasses-cookie.webp',
    ),
  ];

  static final cart = Cart(
    id: 'CART-123',
    ownerId: 'USER-123',
    createdAt: DateTime(2025, 11, 10, 10),
    items: const [
      CartItem(productId: '1', quantity: 2),
      CartItem(productId: '4', quantity: 3),
    ],
    total: const Total(
      subtotal: 66,
      discount: 5.4,
      total: 60.6,
      currency: 'USD',
    ),
  );

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
