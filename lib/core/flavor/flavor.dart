class AppConfig {
  final String baseUrl;
  final String flavor;
  final String iconPath;
  static AppConfig _instance;
  factory AppConfig({String baseUrl, String flavor, String iconPath}) {
    _instance ??= AppConfig._internal(baseUrl, flavor, iconPath);
    return _instance;
  }

  AppConfig._internal(this.baseUrl, this.flavor, this.iconPath);
  static AppConfig get instance {
    return _instance;
  }
}
