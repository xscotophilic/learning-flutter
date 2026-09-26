import 'package:my_store/core/dependency_injection/service_providers.dart';
import 'package:my_store/core/storage/local_storage.dart';
import 'package:my_store/core/storage/secure_local_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_providers.g.dart';

@Riverpod(keepAlive: true)
LocalStorage secureLocalStorage(Ref ref) {
  return SecureLocalStorage(ref.watch(flutterSecureStorageProvider));
}
