import 'package:my_store/shared/app_info/domain/repositories/app_info_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class PackageInfoRepository implements AppInfoRepository {
  PackageInfo? _packageInfo;

  Future<PackageInfo> _getPackageInfo() async {
    return _packageInfo ??= await PackageInfo.fromPlatform();
  }

  @override
  Future<String> readAppVersion() async {
    return (await _getPackageInfo()).version;
  }

  @override
  Future<int> readAppBuildNumber() async {
    final buildNumber = (await _getPackageInfo()).buildNumber;
    return int.tryParse(buildNumber) ?? 0;
  }
}
