class AppConfig {
  final String baseUrl;
  final String productFlavor;
  final String apiFlavor;
  final String iconPath;
  final bool enableLogin;
  final bool isProd;
  final bool enalbeNativeLogin;
  final bool? enableGraphql;
  static AppConfig? _instance;
  factory AppConfig({
    String? baseUrl,
    String? productFlavor,
    String? apiFlavor,
    String? iconPath,
    bool? enableLogin,
    bool? isProd,
    bool? enalbeNativeLogin,
    bool? enableGraphql,
  }) {
    _instance ??= AppConfig._internal(baseUrl!, productFlavor!, apiFlavor!,
        iconPath!, enableLogin!, isProd!, enalbeNativeLogin!, enableGraphql!);
    return _instance!;
  }

  AppConfig._internal(
      this.baseUrl,
      this.productFlavor,
      this.apiFlavor,
      this.iconPath,
      this.enableLogin,
      this.isProd,
      this.enalbeNativeLogin,
      this.enableGraphql);
  static AppConfig? get instance {
    return _instance;
  }
}
