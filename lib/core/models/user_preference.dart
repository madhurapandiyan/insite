class UserPreference {
  String? timezone;
  String? language;
  String? units;
  String? dateFormat;
  String? timeFormat;
  String? assetLabelDisplay;
  String? meterLabelDisplay;
  String? locationDisplay;
  String? currencySymbol;
  String? temperatureUnit;
  String? pressureUnit;
  String? mapProvider;
  String? browserRefresh;
  String? thousandsSeparator;
  String? decimalSeparator;
  dynamic? decimalPrecision;

  UserPreference(
      {this.timezone,
      this.language,
      this.units,
      this.dateFormat,
      this.timeFormat,
      this.assetLabelDisplay,
      this.meterLabelDisplay,
      this.locationDisplay,
      this.currencySymbol,
      this.temperatureUnit,
      this.pressureUnit,
      this.mapProvider,
      this.browserRefresh,
      this.thousandsSeparator,
      this.decimalSeparator,
      this.decimalPrecision});

  UserPreference.fromJson(Map<String, dynamic> json) {
    timezone = json['Timezone'];
    language = json['Language'];
    units = json['Units'];
    dateFormat = json['DateFormat'];
    timeFormat = json['TimeFormat'];
    assetLabelDisplay = json['AssetLabelDisplay'];
    meterLabelDisplay = json['MeterLabelDisplay'];
    locationDisplay = json['LocationDisplay'];
    currencySymbol = json['CurrencySymbol'];
    temperatureUnit = json['TemperatureUnit'];
    pressureUnit = json['PressureUnit'];
    mapProvider = json['MapProvider'];
    browserRefresh = json['BrowserRefresh'];
    thousandsSeparator = json['ThousandsSeparator'];
    decimalSeparator = json['DecimalSeparator'];
    decimalPrecision = json['DecimalPrecision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Timezone'] = this.timezone;
    data['Language'] = this.language;
    data['Units'] = this.units;
    data['DateFormat'] = this.dateFormat;
    data['TimeFormat'] = this.timeFormat;
    data['AssetLabelDisplay'] = this.assetLabelDisplay;
    data['MeterLabelDisplay'] = this.meterLabelDisplay;
    data['LocationDisplay'] = this.locationDisplay;
    data['CurrencySymbol'] = this.currencySymbol;
    data['TemperatureUnit'] = this.temperatureUnit;
    data['PressureUnit'] = this.pressureUnit;
    data['MapProvider'] = this.mapProvider;
    data['BrowserRefresh'] = this.browserRefresh;
    data['ThousandsSeparator'] = this.thousandsSeparator;
    data['DecimalSeparator'] = this.decimalSeparator;
    data['DecimalPrecision'] = this.decimalPrecision;
    return data;
  }
}
