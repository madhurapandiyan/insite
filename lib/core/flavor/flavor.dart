class AppConfig {
  final String baseUrl;
  static AppConfig _instance;
  factory AppConfig({String baseUrl}) {
    _instance ??= AppConfig._internal(baseUrl);
    return _instance;
  }

  AppConfig._internal(this.baseUrl);
  static AppConfig get instance {
    return _instance;
  }
}
