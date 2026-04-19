import 'package:flutter/material.dart';
import 'package:my_store/features/home/presentation/home_page.dart';
import 'package:my_store/features/orders/orders_page.dart';
import 'package:my_store/features/product_details/product_details_page.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final arguments = settings.arguments;

    switch (routeName) {
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
      case OrdersPage.routeName:
        return MaterialPageRoute(builder: (context) => const OrdersPage());
      default:
        return null;
    }
  }
}
