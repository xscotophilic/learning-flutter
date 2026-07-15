abstract interface class AppInfoRepository {
  Future<String> readAppVersion();

  Future<int> readAppBuildNumber();
}
