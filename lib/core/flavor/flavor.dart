class AppConfig {
  final String baseUrl;
  final String productFlavor;
  final String apiFlavor;
  final String iconPath;
  static AppConfig _instance;
  factory AppConfig(
      {String baseUrl,
      String productFlavor,
      String apiFlavor,
      String iconPath}) {
    _instance ??=
        AppConfig._internal(baseUrl, productFlavor, apiFlavor, iconPath);
    return _instance;
  }

  AppConfig._internal(
      this.baseUrl, this.productFlavor, this.apiFlavor, this.iconPath);
  static AppConfig get instance {
    return _instance;
  }
}
