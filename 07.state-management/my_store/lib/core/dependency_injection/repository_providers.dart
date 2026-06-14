import 'package:my_store/features/cart/data/repositories/mock_cart_repository.dart';
import 'package:my_store/features/cart/domain/repositories/cart_repository.dart';
import 'package:my_store/features/favorites/data/repositories/mock_favorites_repository.dart';
import 'package:my_store/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:my_store/features/orders/data/repositories/mock_orders_repository.dart';
import 'package:my_store/features/orders/domain/repositories/orders_repository.dart';
import 'package:my_store/features/product/data/repositories/mock_product_repository.dart';
import 'package:my_store/features/product/domain/repositories/product_repository.dart';
import 'package:my_store/shared/app_info/data/repositories/package_info_repository.dart';
import 'package:my_store/shared/app_info/domain/repositories/app_info_repository.dart';
import 'package:my_store/shared/remote_config/data/repositories/mock_remote_config_repository.dart';
import 'package:my_store/shared/remote_config/domain/repositories/remote_config_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@Riverpod(keepAlive: true)
AppInfoRepository appInfoRepository(Ref ref) {
  return PackageInfoRepository();
}

@Riverpod(keepAlive: true)
RemoteConfigRepository remoteConfigRepository(Ref ref) {
  return MockRemoteConfigRepository();
}

@Riverpod(keepAlive: true)
ProductRepository productRepository(Ref ref) {
  return MockProductRepository();
}

@Riverpod(keepAlive: true)
CartRepository cartRepository(Ref ref) {
  return MockCartRepository();
}

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(Ref ref) {
  return MockFavoritesRepository();
}

@Riverpod(keepAlive: true)
OrdersRepository ordersRepository(Ref ref) {
  return const MockOrdersRepository();
}
