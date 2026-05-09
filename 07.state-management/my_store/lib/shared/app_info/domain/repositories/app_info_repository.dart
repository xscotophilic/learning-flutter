abstract interface class AppInfoRepository {
  Future<String> readAppVersion();

  Future<String> readAppBuildNumber();
}
