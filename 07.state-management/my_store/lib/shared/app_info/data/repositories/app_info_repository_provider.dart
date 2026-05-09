import 'package:my_store/shared/app_info/data/repositories/package_info_repository.dart';
import 'package:my_store/shared/app_info/domain/repositories/app_info_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_info_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AppInfoRepository appInfoRepository(Ref ref) {
  return PackageInfoRepository();
}
