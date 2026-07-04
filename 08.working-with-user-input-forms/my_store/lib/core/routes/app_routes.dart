import 'package:flutter/material.dart';
import 'package:my_store/features/cart/presentation/pages/cart_page.dart';
import 'package:my_store/features/home/presentation/pages/home_page.dart';
import 'package:my_store/features/my_products/presentation/pages/my_products_page.dart';
import 'package:my_store/features/orders/presentation/pages/orders_page.dart';
import 'package:my_store/features/product_details/presentation/pages/product_details_page.dart';
import 'package:my_store/features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final arguments = settings.arguments;

    switch (routeName) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case ProductDetailsPage.routeName:
        final String? productId;
        if (arguments is String) {
          productId = arguments;
        } else {
          productId = null;
        }
        return MaterialPageRoute(
          builder: (context) => ProductDetailsPage(productId: productId),
        );
      case CartPage.routeName:
        return MaterialPageRoute(builder: (context) => const CartPage());
      case OrdersPage.routeName:
        return MaterialPageRoute(builder: (context) => const OrdersPage());
      case MyProductsPage.routeName:
        return MaterialPageRoute(builder: (context) => const MyProductsPage());
      default:
        return null;
    }
  }
}
