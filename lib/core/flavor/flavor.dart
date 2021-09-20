class AppConfig {
  final String baseUrl;
  final String flavor;
  static AppConfig _instance;
  factory AppConfig({String baseUrl, String flavor}) {
    _instance ??= AppConfig._internal(baseUrl, flavor);
    return _instance;
  }

  AppConfig._internal(this.baseUrl, this.flavor);
  static AppConfig get instance {
    return _instance;
  }
}
