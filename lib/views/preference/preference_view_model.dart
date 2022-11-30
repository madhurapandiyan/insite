import 'dart:convert';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/user_preference.dart';

import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/views/preference/model/time_zone.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/services/preference_service.dart';

class PreferencesViewModel extends InsiteViewModel {
  Logger? log;

  NavigationService? _navigationService = locator<NavigationService>();
  PreferenceService? _preferenceService = locator<PreferenceService>();
  LocalService _localService = locator<LocalService>();
  bool isLoading = false;
  int? isSelectedDate;
  LoginService? _loginService = locator<LoginService>();
  UserPreference? userPreference;

  List<InsiteRadio> dateFormateButton = [
    InsiteRadio(
        title: "PREF_MMDDYY".tr(), key: "MM/dd/yy", formateValue: "MM/dd/yyyy"),
    InsiteRadio(
        title: "PREF_DDMMYY".tr(), key: "dd/MM/yy", formateValue: "dd/MM/yyyy"),
  ];
  List<InsiteRadio> timeFormateButton = [
    InsiteRadio(
        title: "PREF_HHMM_PMAM".tr(), key: "hh:mm a", formateValue: "hh:mm a"),
    InsiteRadio(title: "PREF_HHMM".tr(), key: "HH:mm", formateValue: "HH:mm"),
  ];
  List<InsiteRadio> locationDisplayButton = [
    InsiteRadio(title: "PREF_LAT_LON".tr(), key: "Lat/Lon"),
    InsiteRadio(title: "PREF_ADDRESS".tr(), key: "Address"),
  ];
  List<InsiteRadio> unitsOfMeasurementButton = [
    InsiteRadio(title: "PREF_US_STANDARD".tr(), key: "US Standard"),
    InsiteRadio(title: "PREF_IMPERIAL".tr(), key: "Imperial"),
    InsiteRadio(title: "PREF_METRIC".tr(), key: "Metric"),
  ];
  List<InsiteRadio> pressureUnitButton = [
    InsiteRadio(title: "PREF_PSI".tr(), key: "PSI"),
    InsiteRadio(title: "PREF_KPA".tr(), key: "kPa"),
    InsiteRadio(title: "PREF_BAR".tr(), key: "BAR"),
  ];
  List<InsiteRadio> temperatureUnitButton = [
    InsiteRadio(title: "PREF_CELSIUS".tr(), key: "Celsius"),
    InsiteRadio(title: "PREF_FAHRENHEIT".tr(), key: "Fahrenheit"),
  ];

  List<Language> languageList = [
    Language(langName: 'English', locale: const Locale('en'), key: "en-US"),
    Language(langName: 'French', locale: const Locale('fr'), key: "fr-FR"),
    Language(langName: 'Japanese', locale: const Locale('ja'), key: "ja-JP"),
    Language(langName: 'German', locale: const Locale('de'), key: "de-DE"),
    Language(langName: 'Korean', locale: const Locale('ko'), key: "ko-KR"),
     Language(langName: 'Español', locale: const Locale('es'), key: "es-AR"),
  ];
  TimeZone? selectTimeZone;
  Language? selectedLang;

  PreferencesViewModel() {
    this.log = getLogger(this.runtimeType.toString());

    getUserPreference();
  }
  getPreferenceData() async {
    isLoading = true;
    await _preferenceService!.getPreferenceDataLocal();
  }

  getUserPreference() async {
    await getPreferenceData();
    isLoading = false;
    userPreference = await _localService.getUserPreferenceData();
    //Logger().w(userPreference!.toJson());
    if (userPreference != null) {
      dateFormateButton.forEach((element) {
        if (element.key == userPreference!.dateFormat) {
          element.isSelected = true;
        }
      });
      languageList.forEach((element) {
        if (element.key == userPreference!.language) {
          selectedLang = element;
        }
      });
      timeZoneDropdownListData.forEach((element) {
        if (element.value == userPreference!.timezone) {
          selectTimeZone = element;
        }
      });
      timeFormateButton.forEach((element) {
        if (element.key == userPreference!.timeFormat) {
          element.isSelected = true;
        }
      });
      locationDisplayButton.forEach(
        (element) {
          if (element.key == userPreference!.locationDisplay) {
            element.isSelected = true;
          }
        },
      );
      unitsOfMeasurementButton.forEach(
        (element) {
          if (element.key == userPreference!.units) {
            element.isSelected = true;
          }
        },
      );
      temperatureUnitButton.forEach((element) {
        if (element.key == userPreference!.temperatureUnit) {
          element.isSelected = true;
        }
      });
      pressureUnitButton.forEach(
        (element) {
          if (element.key == userPreference!.pressureUnit) {
            element.isSelected = true;
          }
        },
      );
    }
    notifyListeners();
  }

  onDateFormateChange(int i) {
    dateFormateButton.forEach((element) {
      element.isSelected = false;
    });
    dateFormateButton[i].isSelected = true;

    notifyListeners();
  }

  onTimeFormateChange(int i) {
    timeFormateButton.forEach((element) {
      element.isSelected = false;
    });
    timeFormateButton[i].isSelected = true;

    notifyListeners();
  }

  onLocationDisplayChange(int i) {
    locationDisplayButton.forEach((element) {
      element.isSelected = false;
    });
    locationDisplayButton[i].isSelected = true;

    notifyListeners();
  }

  onUnitsOfMeasurementChange(int i) {
    unitsOfMeasurementButton.forEach((element) {
      element.isSelected = false;
    });
    unitsOfMeasurementButton[i].isSelected = true;

    notifyListeners();
  }

  onPressureUnitChange(int i) {
    pressureUnitButton.forEach((element) {
      element.isSelected = false;
    });
    pressureUnitButton[i].isSelected = true;

    notifyListeners();
  }

  onTemperatureUnitChange(int i) {
    temperatureUnitButton.forEach((element) {
      element.isSelected = false;
    });
    temperatureUnitButton[i].isSelected = true;

    notifyListeners();
  }

  changedropDownTimeZomeValue(value) {
    selectTimeZone = value;
    notifyListeners();
  }

  changedropDownLanguageValue(value) {
    selectedLang = value;
    notifyListeners();
  }

  onSave() async {
    try {
      showLoadingDialog();
      UserPreference userData = UserPreference(
          timezone: selectTimeZone!.value,
          language: selectedLang!.key,
          units: unitsOfMeasurementButton
              .singleWhere((element) => element.isSelected == true)
              .key,
          dateFormat: dateFormateButton
              .singleWhere((element) => element.isSelected == true)
              .key,
          timeFormat: timeFormateButton
              .singleWhere((element) => element.isSelected == true)
              .key,
          assetLabelDisplay: userPreference!.assetLabelDisplay,
          meterLabelDisplay: userPreference!.meterLabelDisplay,
          locationDisplay: locationDisplayButton
              .singleWhere((element) => element.isSelected == true)
              .key,
          currencySymbol: userPreference!.currencySymbol,
          pressureUnit: pressureUnitButton
              .singleWhere((element) => element.isSelected == true)
              .key,
          decimalPrecision: userPreference!.decimalPrecision,
          temperatureUnit: temperatureUnitButton
              .singleWhere((element) => element.isSelected == true)
              .key,
          decimalSeparator: userPreference!.decimalSeparator,
          browserRefresh: userPreference!.browserRefresh,
          mapProvider: userPreference!.mapProvider,
          thousandsSeparator: userPreference!.thousandsSeparator);
      Logger().w(jsonEncode(userData));
      var data = await _preferenceService?.createPreferenceData(
          userPrefernce: jsonEncode(userData), time: DateTime.now().toString());

      await getPreferenceData();
isLoading=false;
      hideLoadingDialog();
    } catch (e) {
      Logger().e(e.toString());
      hideLoadingDialog();
    }
  }
}

class Language {
  Locale? locale;
  String? langName;
  String? key;
  Language({required this.locale, required this.langName, this.key});
}

const List<TimeZone> timeZoneDropdownListData = [
  TimeZone(
      display: '(UTC) Coordinated Universal Time',
      value: 'Coordinated Universal Time',
      localeValue: '(GMT) Coordinated Universal Time',
      token: 'COORDINATED_UNIVERSAL_TIME',
      momentTimezone: 'Etc/GMT'),
  TimeZone(
      display: '(UTC) Dublin, Edinburgh, Lisbon, London',
      value: 'GMT Standard Time',
      localeValue:
          '(GMT) Greenwich Mean Time : Dublin, Edinburgh, Lisbon, London',
      token: 'GMTSTANDARD_TIME',
      momentTimezone: 'Europe/London'),
  TimeZone(
      display: '(UTC) Monrovia, Reykjavik',
      value: 'Greenwich Standard Time',
      localeValue: '(GMT) Monrovia, Reykjavik',
      token: 'GREENWICH_STANDARD_TIME',
      momentTimezone: 'Atlantic/Reykjavik'),
  TimeZone(
      display: '(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna',
      value: 'W. Europe Standard Time',
      localeValue:
          '(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna',
      token: 'WEUROPE_STANDARD_TIME',
      momentTimezone: 'Europe/Berlin'),
  TimeZone(
      display: '(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague',
      value: 'Central Europe Standard Time',
      localeValue:
          '(GMT+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague',
      token: 'CENTRAL_EUROPE_STANDARD_TIME',
      momentTimezone: 'Europe/Budapest'),
  TimeZone(
      display: '(UTC+01:00) Casablanca',
      value: 'Morocco Standard Time',
      localeValue: '(GMT+01:00) Casablanca',
      token: 'MOROCCO_STANDARD_TIME',
      momentTimezone: 'Africa/Casablanca'),
  TimeZone(
      display: '(UTC+01:00) Brussels, Copenhagen, Madrid, Paris',
      value: 'Romance Standard Time',
      localeValue: '(GMT+01:00) Brussels, Copenhagen, Madrid, Paris',
      token: 'ROMANCE_STANDARD_TIME',
      momentTimezone: 'Europe/Paris'),
  TimeZone(
      display: '(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb',
      value: 'Central European Standard Time',
      localeValue: '(GMT+01:00) Sarajevo, Skopje, Warsaw, Zagreb',
      token: 'CENTRAL_EUROPEAN_STANDARD_TIME',
      momentTimezone: 'Europe/Warsaw'),
  TimeZone(
      display: '(UTC+01:00) West Central Africa',
      value: 'W. Central Africa Standard Time',
      localeValue: '(GMT+01:00) West Central Africa',
      token: 'WCENTRAL_AFRICA_STANDARD_TIME',
      momentTimezone: 'Africa/Lagos'),
  TimeZone(
      display: '(UTC+01:00) Windhoek',
      value: 'Namibia Standard Time',
      localeValue: '(GMT+01:00) Windhoek',
      token: 'NAMIBIA_STANDARD_TIME',
      momentTimezone: 'Africa/Windhoek'),
  TimeZone(
      display: '(UTC+02:00) Amman',
      value: 'Jordan Standard Time',
      localeValue: '(GMT+02:00) Amman',
      token: 'JORDAN_STANDARD_TIME',
      momentTimezone: 'Asia/Amman'),
  TimeZone(
      display: '(UTC+02:00) Athens, Bucharest',
      value: 'GTB Standard Time',
      localeValue: '(GMT+02:00) Athens, Bucharest, Istanbul',
      token: 'GTBSTANDARD_TIME',
      momentTimezone: 'Europe/Bucharest'),
  TimeZone(
      display: '(UTC+02:00) Beirut',
      value: 'Middle East Standard Time',
      localeValue: '(GMT+02:00) Beirut',
      token: 'MIDDLE_EAST_STANDARD_TIME',
      momentTimezone: 'Asia/Beirut'),
  TimeZone(
      display: '(UTC+02:00) Cairo',
      value: 'Egypt Standard Time',
      localeValue: '(GMT+02:00) Cairo',
      token: 'EGYPT_STANDARD_TIME',
      momentTimezone: 'Africa/Cairo'),
  TimeZone(
      display: '(UTC+02:00) Damascus',
      value: 'Syria Standard Time',
      localeValue: '(GMT+02:00) Damascus',
      token: 'SYRIA_STANDARD_TIME',
      momentTimezone: 'Asia/Damascus'),
  TimeZone(
      display: '(UTC+02:00) E. Europe',
      value: 'E. Europe Standard Time',
      localeValue: '(GMT+02:00) Minsk',
      token: 'EEUROPE_STANDARD_TIME',
      momentTimezone: 'Europe/Chisinau'),
  TimeZone(
      display: '(UTC+02:00) Harare, Pretoria',
      value: 'South Africa Standard Time',
      localeValue: '(GMT+02:00) Harare, Pretoria',
      token: 'SOUTH_AFRICA_STANDARD_TIME',
      momentTimezone: 'Africa/Johannesburg'),
  TimeZone(
      display: '(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius',
      value: 'FLE Standard Time',
      localeValue: '(GMT+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius',
      token: 'FLESTANDARD_TIME',
      momentTimezone: 'Europe/Kiev'),
  TimeZone(
      display: '(UTC+02:00) Istanbul',
      value: 'Turkey Standard Time',
      localeValue: '(GMT+02:00) Istanbul',
      token: 'TURKEY_STANDARD_TIME',
      momentTimezone: 'Europe/Istanbul'),
  TimeZone(
      display: '(UTC+02:00) Jerusalem',
      value: 'Jerusalem Standard Time',
      localeValue: '(GMT+02:00) Jerusalem',
      token: 'JERUSALEM_STANDARD_TIME',
      momentTimezone: 'Asia/Jerusalem'),
  TimeZone(
      display: '(UTC+02:00) Kaliningrad (RTZ 1)',
      value: 'Russia TZ 1 Standard Time',
      localeValue: '(UTC+02:00) Kaliningrad (RTZ 1)',
      token: 'RUSSIA_TZ1STANDARD_TIME',
      momentTimezone: 'Europe/Kaliningrad'),
  TimeZone(
      display: '(UTC+02:00) Tripoli',
      value: 'Libya Standard Time',
      localeValue: '(UTC+02:00) Tripoli',
      token: 'LIBYA_STANDARD_TIME',
      momentTimezone: 'Africa/Tripoli'),
  TimeZone(
      display: '(UTC+03:00) Baghdad',
      value: 'Arabic Standard Time',
      localeValue: '(GMT+03:00) Baghdad',
      token: 'ARABIC_STANDARD_TIME',
      momentTimezone: 'Asia/Baghdad'),
  TimeZone(
      display: '(UTC+03:00) Kuwait, Riyadh',
      value: 'Arab Standard Time',
      localeValue: '(GMT+03:00) Kuwait, Riyadh',
      token: 'ARAB_STANDARD_TIME',
      momentTimezone: 'Asia/Riyadh'),
  TimeZone(
      display: '(UTC+03:00) Minsk',
      value: 'Belarus Standard Time',
      localeValue: '(UTC+03:00) Minsk',
      token: 'BELARUS_STANDARD_TIME',
      momentTimezone: 'Europe/Minsk'),
  TimeZone(
      display: '(UTC+03:00) Moscow, St. Petersburg, Volgograd (RTZ 2)',
      value: 'Russia TZ 2 Standard Time',
      localeValue: '(UTC+03:00) Moscow, St. Petersburg, Volgograd (RTZ 2)',
      token: 'RUSSIA_TZ2STANDARD_TIME',
      momentTimezone: 'Europe/Moscow'),
  TimeZone(
      display: '(UTC+03:00) Nairobi',
      value: 'E. Africa Standard Time',
      localeValue: '(GMT+03:00) Nairobi',
      token: 'EAFRICA_STANDARD_TIME',
      momentTimezone: 'Africa/Nairobi'),
  TimeZone(
      display: '(UTC+03:30) Tehran',
      value: 'Iran Standard Time',
      localeValue: '(GMT+03:30) Tehran',
      token: 'IRAN_STANDARD_TIME',
      momentTimezone: 'Asia/Tehran'),
  TimeZone(
      display: '(UTC+04:00) Abu Dhabi, Muscat',
      value: 'Arabian Standard Time',
      localeValue: '(GMT+04:00) Abu Dhabi, Muscat',
      token: 'ARABIAN_STANDARD_TIME',
      momentTimezone: 'Asia/Dubai'),
  TimeZone(
      display: '(UTC+04:00) Baku',
      value: 'Azerbaijan Standard Time',
      localeValue: '(GMT+04:00) Baku',
      token: 'AZERBAIJAN_STANDARD_TIME',
      momentTimezone: 'Asia/Baku'),
  TimeZone(
      display: '(UTC+04:00) Izhevsk, Samara (RTZ 3)',
      value: 'Russia TZ 3 Standard Time',
      localeValue: '(UTC+04:00) Izhevsk, Samara (RTZ 3)',
      token: 'RUSSIA_TZ3STANDARD_TIME',
      momentTimezone: 'Europe/Samara'),
  TimeZone(
      display: '(UTC+04:00) Port Louis',
      value: 'Mauritius Standard Time',
      localeValue: '(GMT+04:00) Port Louis',
      token: 'MAURITIUS_STANDARD_TIME',
      momentTimezone: 'Indian/Mauritius'),
  TimeZone(
      display: '(UTC+04:00) Tbilisi',
      value: 'Georgian Standard Time',
      localeValue: '(GMT+04:00) Tbilisi',
      token: 'GEORGIAN_STANDARD_TIME',
      momentTimezone: 'Asia/Tbilisi'),
  TimeZone(
      display: '(UTC+04:00) Yerevan',
      value: 'Caucasus Standard Time',
      localeValue: '(GMT+04:00) Yerevan',
      token: 'CAUCASUS_STANDARD_TIME',
      momentTimezone: 'Asia/Yerevan'),
  TimeZone(
      display: '(UTC+04:30) Kabul',
      value: 'Afghanistan Standard Time',
      localeValue: '(GMT+04:30) Kabul',
      token: 'AFGHANISTAN_STANDARD_TIME',
      momentTimezone: 'Asia/Kabul'),
  TimeZone(
      display: '(UTC+05:00) Ashgabat, Tashkent',
      value: 'West Asia Standard Time',
      localeValue: '(GMT+05:00) Tashkent',
      token: 'WEST_ASIA_STANDARD_TIME',
      momentTimezone: 'Asia/Tashkent'),
  TimeZone(
      display: '(UTC+05:00) Ekaterinburg (RTZ 4)',
      value: 'Russia TZ 4 Standard Time',
      localeValue: '(UTC+05:00) Ekaterinburg (RTZ 4)',
      token: 'RUSSIA_TZ4STANDARD_TIME',
      momentTimezone: 'Asia/Yekaterinburg'),
  TimeZone(
      display: '(UTC+05:00) Islamabad, Karachi',
      value: 'Pakistan Standard Time',
      localeValue: '(GMT+05:00) Islamabad, Karachi',
      token: 'PAKISTAN_STANDARD_TIME',
      momentTimezone: 'Asia/Karachi'),
  TimeZone(
      display: '(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi',
      value: 'India Standard Time',
      localeValue: '(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi',
      token: 'INDIA_STANDARD_TIME',
      momentTimezone: 'Asia/Kolkata'),
  TimeZone(
      display: '(UTC+05:30) Sri Jayawardenepura',
      value: 'Sri Lanka Standard Time',
      localeValue: '(GMT+05:30) Sri Jayawardenepura',
      token: 'SRI_LANKA_STANDARD_TIME',
      momentTimezone: 'Asia/Colombo'),
  TimeZone(
      display: '(UTC+05:45) Kathmandu',
      value: 'Nepal Standard Time',
      localeValue: '(GMT+05:45) Kathmandu',
      token: 'NEPAL_STANDARD_TIME',
      momentTimezone: 'Asia/Kathmandu'),
  TimeZone(
      display: '(UTC+06:00) Astana',
      value: 'Central Asia Standard Time',
      localeValue: '(GMT+06:00) Astana, Dhaka',
      token: 'CENTRAL_ASIA_STANDARD_TIME',
      momentTimezone: 'Asia/Almaty'),
  TimeZone(
      display: '(UTC+06:00) Dhaka',
      value: 'Bangladesh Standard Time',
      localeValue: '(GMT+06:00) Dhaka',
      token: 'BANGLADESH_STANDARD_TIME',
      momentTimezone: 'Asia/Dhaka'),
  TimeZone(
      display: '(UTC+06:00) Novosibirsk (RTZ 5)',
      value: 'Russia TZ 5 Standard Time',
      localeValue: '(UTC+06:00) Novosibirsk (RTZ 5)',
      token: 'RUSSIA_TZ5STANDARD_TIME',
      momentTimezone: 'Asia/Novosibirsk'),
  TimeZone(
      display: '(UTC+06:30) Yangon (Rangoon)',
      value: 'Myanmar Standard Time',
      localeValue: '(GMT+06:30) Yangon (Rangoon)',
      token: 'MYANMAR_STANDARD_TIME',
      momentTimezone: 'Asia/Rangoon'),
  TimeZone(
      display: '(UTC+07:00) Bangkok, Hanoi, Jakarta',
      value: 'SE Asia Standard Time',
      localeValue: '(GMT+07:00) Bangkok, Hanoi, Jakarta',
      token: 'SEASIA_STANDARD_TIME',
      momentTimezone: 'Asia/Bangkok'),
  TimeZone(
      display: '(UTC+07:00) Krasnoyarsk (RTZ 6)',
      value: 'Russia TZ 6 Standard Time',
      localeValue: '(UTC+07:00) Krasnoyarsk (RTZ 6)',
      token: 'RUSSIA_TZ6STANDARD_TIME',
      momentTimezone: 'Asia/Krasnoyarsk'),
  TimeZone(
      display: '(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi',
      value: 'China Standard Time',
      localeValue: '(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi',
      token: 'CHINA_STANDARD_TIME',
      momentTimezone: 'Asia/Shanghai'),
  TimeZone(
      display: '(UTC+08:00) Irkutsk (RTZ 7)',
      value: 'Russia TZ 7 Standard Time',
      localeValue: '(UTC+08:00) Irkutsk (RTZ 7)',
      token: 'RUSSIA_TZ7STANDARD_TIME',
      momentTimezone: 'Asia/Irkutsk'),
  TimeZone(
      display: '(UTC+08:00) Kuala Lumpur, Singapore',
      value: 'Malay Peninsula Standard Time',
      localeValue: '(GMT+08:00) Kuala Lumpur, Singapore',
      token: 'MALAY_PENINSULA_STANDARD_TIME',
      momentTimezone: 'Asia/Singapore'),
  TimeZone(
      display: '(UTC+08:00) Perth',
      value: 'W. Australia Standard Time',
      localeValue: '(GMT+08:00) Perth',
      token: 'WAUSTRALIA_STANDARD_TIME',
      momentTimezone: 'Australia/Perth'),
  TimeZone(
      display: '(UTC+08:00) Taipei',
      value: 'Taipei Standard Time',
      localeValue: '(GMT+08:00) Taipei',
      token: 'TAIPEI_STANDARD_TIME',
      momentTimezone: 'Asia/Taipei'),
  TimeZone(
      display: '(UTC+08:00) Ulaanbaatar',
      value: 'Ulaanbaatar Standard Time',
      localeValue: '(GMT+08:00) Ulaanbaatar',
      token: 'ULAANBAATAR_STANDARD_TIME',
      momentTimezone: 'Asia/Ulaanbaatar'),
  TimeZone(
      display: '(UTC+09:00) Osaka, Sapporo, Tokyo',
      value: 'Tokyo Standard Time',
      localeValue: '(GMT+09:00) Osaka, Sapporo, Tokyo',
      token: 'TOKYO_STANDARD_TIME',
      momentTimezone: 'Asia/Tokyo'),
  TimeZone(
      display: '(UTC+09:00) Seoul',
      value: 'Korea Standard Time',
      localeValue: '(GMT+09:00) Seoul',
      token: 'KOREA_STANDARD_TIME',
      momentTimezone: 'Asia/Seoul'),
  TimeZone(
      display: '(UTC+09:00) Yakutsk (RTZ 8)',
      value: 'Russia TZ 8 Standard Time',
      localeValue: '(UTC+09:00) Yakutsk (RTZ 8)',
      token: 'RUSSIA_TZ8STANDARD_TIME',
      momentTimezone: 'Asia/Yakutsk'),
  TimeZone(
      display: '(UTC+09:30) Adelaide',
      value: 'Cen. Australia Standard Time',
      localeValue: '(GMT+09:30) Adelaide',
      token: 'CEN_AUSTRALIA_STANDARD_TIME',
      momentTimezone: 'Australia/Adelaide'),
  TimeZone(
      display: '(UTC+09:30) Darwin',
      value: 'AUS Central Standard Time',
      localeValue: '(GMT+09:30) Darwin',
      token: 'AUSCENTRAL_STANDARD_TIME',
      momentTimezone: 'Australia/Darwin'),
  TimeZone(
      display: '(UTC+10:00) Brisbane',
      value: 'E. Australia Standard Time',
      localeValue: '(GMT+10:00) Brisbane',
      token: 'EAUSTRALIA_STANDARD_TIME',
      momentTimezone: 'Australia/Brisbane'),
  TimeZone(
      display: '(UTC+10:00) Canberra, Melbourne, Sydney',
      value: 'AUS Eastern Standard Time',
      localeValue: '(GMT+10:00) Canberra, Melbourne, Sydney',
      token: 'AUSEASTERN_STANDARD_TIME',
      momentTimezone: 'Australia/Sydney'),
  TimeZone(
      display: '(UTC+10:00) Guam, Port Moresby',
      value: 'West Pacific Standard Time',
      localeValue: '(GMT+10:00) Guam, Port Moresby',
      token: 'WEST_PACIFIC_STANDARD_TIME',
      momentTimezone: 'Pacific/Port_Moresby'),
  TimeZone(
      display: '(UTC+10:00) Hobart',
      value: 'Tasmania Standard Time',
      localeValue: '(GMT+10:00) Hobart',
      token: 'TASMANIA_STANDARD_TIME',
      momentTimezone: 'Australia/Hobart'),
  TimeZone(
      display: '(UTC+10:00) Magadan',
      value: 'Magadan Standard Time',
      localeValue: '(GMT+12:00) Magadan',
      token: 'MAGADAN_STANDARD_TIME',
      momentTimezone: 'Asia/Magadan'),
  TimeZone(
      display: '(UTC+10:00) Vladivostok, Magadan (RTZ 9)',
      value: 'Russia TZ 9 Standard Time',
      localeValue: '(UTC+10:00) Vladivostok, Magadan (RTZ 9)',
      token: 'RUSSIA_TZ9STANDARD_TIME',
      momentTimezone: 'Asia/Vladivostok'),
  TimeZone(
      display: '(UTC+11:00) Chokurdakh (RTZ 10)',
      value: 'Russia TZ 10 Standard Time',
      localeValue: '(UTC+11:00) Chokurdakh (RTZ 10)',
      token: 'RUSSIA_TZ10STANDARD_TIME',
      momentTimezone: 'Asia/Srednekolymsk'),
  TimeZone(
      display: '(UTC+11:00) Solomon Is., New Caledonia',
      value: 'Central Pacific Standard Time',
      localeValue: '(GMT+11:00) Solomon Is., New Caledonia',
      token: 'CENTRAL_PACIFIC_STANDARD_TIME',
      momentTimezone: 'Pacific/Guadalcanal'),
  TimeZone(
      display: '(UTC+12:00) Anadyr, Petropavlovsk-Kamchatsky (RTZ 11)',
      value: 'Russia TZ 11 Standard Time',
      localeValue: '(UTC+12:00) Anadyr, Petropavlovsk-Kamchatsky (RTZ 11)',
      token: 'RUSSIA_TZ11STANDARD_TIME',
      momentTimezone: 'Asia/Anadyr'),
  TimeZone(
      display: '(UTC+12:00) Auckland, Wellington',
      value: 'New Zealand Standard Time',
      localeValue: '(GMT+12:00) Auckland, Wellington',
      token: 'NEW_ZEALAND_STANDARD_TIME',
      momentTimezone: 'Pacific/Auckland'),
  TimeZone(
      display: '(UTC+12:00) Coordinated Universal Time+12',
      value: 'UTC+12',
      localeValue: '(GMT+12:00) Coordinated Universal Time+12',
      token: 'UTC12',
      momentTimezone: 'Etc/GMT-12'),
  TimeZone(
      display: '(UTC+12:00) Fiji',
      value: 'Fiji Standard Time',
      localeValue: '(GMT+12:00) Fiji',
      token: 'FIJI_STANDARD_TIME',
      momentTimezone: 'Pacific/Fiji'),
  TimeZone(
      display: '(UTC+12:00) Petropavlovsk-Kamchatsky - Old',
      value: 'Kamchatka Standard Time',
      localeValue: '(GMT+12:00) Petropavlovsk-Kamchatsky',
      token: 'KAMCHATKA_STANDARD_TIME',
      momentTimezone: 'Asia/Kamchatka'),
  TimeZone(
      display: "(UTC+13:00) Nuku'alofa",
      value: 'Tonga Standard Time',
      localeValue: "(GMT+13:00) Nuku'alofa",
      token: 'TONGA_STANDARD_TIME',
      momentTimezone: 'Pacific/Tongatapu'),
  TimeZone(
      display: '(UTC+13:00) Samoa',
      value: 'Samoa Standard Time',
      localeValue: '(GMT+13:00) Samoa',
      token: 'SAMOA_STANDARD_TIME',
      momentTimezone: 'Pacific/Apia'),
  TimeZone(
      display: '(UTC+14:00) Kiritimati Island',
      value: 'Line Islands Standard Time',
      localeValue: '(UTC+14:00) Kiritimati Island',
      token: 'LINE_ISLANDS_STANDARD_TIME',
      momentTimezone: 'Pacific/Kiritimati'),
  TimeZone(
      display: '(UTC-01:00) Azores',
      value: 'Azores Standard Time',
      localeValue: '(GMT-01:00) Azores',
      token: 'AZORES_STANDARD_TIME',
      momentTimezone: 'Atlantic/Azores'),
  TimeZone(
      display: '(UTC-01:00) Cabo Verde Is.',
      value: 'Cabo Verde Standard Time',
      localeValue: '(UTC-01:00) Cabo Verde Is.',
      token: 'CABO_VERDE_STANDARD_TIME',
      momentTimezone: 'Atlantic/Cape_Verde'),
  TimeZone(
      display: '(UTC-02:00) Coordinated Universal Time-02',
      value: 'UTC-02',
      localeValue: '(GMT-02:00) Coordinated Universal Time-02',
      token: 'UTCHYPHEN02',
      momentTimezone: 'Etc/GMT+2'),
  TimeZone(
      display: '(UTC-03:00) Brasilia',
      value: 'E. South America Standard Time',
      localeValue: '(GMT-03:00) Brasilia',
      token: 'ESOUTH_AMERICA_STANDARD_TIME',
      momentTimezone: 'America/Sao_Paulo'),
  TimeZone(
      display: '(UTC-03:00) Buenos Aires',
      value: 'Argentina Standard Time',
      localeValue: '(GMT-03:00) Buenos Aires',
      token: 'ARGENTINA_STANDARD_TIME',
      momentTimezone: 'America/Buenos_Aires'),
  TimeZone(
      display: '(UTC-03:00) Cayenne, Fortaleza',
      value: 'SA Eastern Standard Time',
      localeValue: '(GMT-03:00) Cayenne, Fortaleza',
      token: 'SAEASTERN_STANDARD_TIME',
      momentTimezone: 'America/Cayenne'),
  TimeZone(
      display: '(UTC-03:00) Greenland',
      value: 'Greenland Standard Time',
      localeValue: '(GMT-03:00) Greenland',
      token: 'GREENLAND_STANDARD_TIME',
      momentTimezone: 'America/Godthab'),
  TimeZone(
      display: '(UTC-03:00) Montevideo',
      value: 'Montevideo Standard Time',
      localeValue: '(GMT-03:00) Montevideo',
      token: 'MONTEVIDEO_STANDARD_TIME',
      momentTimezone: 'America/Montevideo'),
  TimeZone(
      display: '(UTC-03:00) Salvador',
      value: 'Bahia Standard Time',
      localeValue: '(GMT-03:00) Salvador',
      token: 'BAHIA_STANDARD_TIME',
      momentTimezone: 'America/Bahia'),
  TimeZone(
      display: '(UTC-03:00) Santiago',
      value: 'Pacific SA Standard Time',
      localeValue: '(GMT-04:00) Santiago',
      token: 'PACIFIC_SASTANDARD_TIME',
      momentTimezone: 'America/Santiago'),
  TimeZone(
      display: '(UTC-03:30) Newfoundland',
      value: 'Newfoundland Standard Time',
      localeValue: '(GMT-03:30) Newfoundland',
      token: 'NEWFOUNDLAND_STANDARD_TIME',
      momentTimezone: 'America/St_Johns'),
  TimeZone(
      display: '(UTC-04:00) Asuncion',
      value: 'Paraguay Standard Time',
      localeValue: '(GMT-04:00) Asuncion',
      token: 'PARAGUAY_STANDARD_TIME',
      momentTimezone: 'America/Asuncion'),
  TimeZone(
      display: '(UTC-04:00) Atlantic Time (Canada)',
      value: 'Atlantic Standard Time',
      localeValue: '(GMT-04:00) Atlantic Time (Canada)',
      token: 'ATLANTIC_STANDARD_TIME',
      momentTimezone: 'America/Halifax'),
  TimeZone(
      display: '(UTC-04:00) Cuiaba',
      value: 'Central Brazilian Standard Time',
      localeValue: '(GMT-04:00) Cuiaba',
      token: 'CENTRAL_BRAZILIAN_STANDARD_TIME',
      momentTimezone: 'America/Cuiaba'),
  TimeZone(
      display: '(UTC-04:00) Georgetown, La Paz, Manaus, San Juan',
      value: 'SA Western Standard Time',
      localeValue: '(GMT-04:00) Georgetown, La Paz, Manaus, San Juan',
      token: 'SAWESTERN_STANDARD_TIME',
      momentTimezone: 'America/La_Paz'),
  TimeZone(
      display: '(UTC-04:30) Caracas',
      value: 'Venezuela Standard Time',
      localeValue: '(GMT-04:30) Caracas',
      token: 'VENEZUELA_STANDARD_TIME',
      momentTimezone: 'America/Caracas'),
  TimeZone(
      display: '(UTC-05:00) Bogota, Lima, Quito, Rio Branco',
      value: 'SA Pacific Standard Time',
      localeValue: '(GMT-05:00) Bogota, Lima, Quito',
      token: 'SAPACIFIC_STANDARD_TIME',
      momentTimezone: 'America/Bogota'),
  TimeZone(
      display: '(UTC-05:00) Chetumal',
      value: 'Eastern Standard Time (Mexico)',
      localeValue: '(UTC-05:00) Chetumal',
      token: 'EASTERN_STANDARD_TIME(MEXICO)',
      momentTimezone: 'America/Cancun'),
  TimeZone(
      display: '(UTC-05:00) Eastern Time (US & Canada)',
      value: 'Eastern Standard Time',
      localeValue: '(GMT-05:00) Eastern Time (US & Canada)',
      token: 'EASTERN_STANDARD_TIME',
      momentTimezone: 'America/New_York'),
  TimeZone(
      display: '(UTC-05:00) Indiana (East)',
      value: 'US Eastern Standard Time',
      localeValue: '(GMT-05:00) Indiana (East)',
      token: 'USEASTERN_STANDARD_TIME',
      momentTimezone: 'America/Indianapolis'),
  TimeZone(
      display: '(UTC-06:00) Central America',
      value: 'Central America Standard Time',
      localeValue: '(GMT-06:00) Central America',
      token: 'CENTRAL_AMERICA_STANDARD_TIME',
      momentTimezone: 'America/Costa_Rica'),
  TimeZone(
      display: '(UTC-06:00) Central Time (US & Canada)',
      value: 'Central Standard Time',
      localeValue: '(GMT-06:00) Central Time (US & Canada)',
      token: 'CENTRAL_STANDARD_TIME',
      momentTimezone: 'America/Chicago'),
  TimeZone(
      display: '(UTC-06:00) Guadalajara, Mexico City, Monterrey',
      value: 'Central Standard Time (Mexico)',
      localeValue: '(GMT-06:00) Guadalajara, Mexico City, Monterrey',
      token: 'CENTRAL_STANDARD_TIME(MEXICO)',
      momentTimezone: 'America/Mexico_City'),
  TimeZone(
      display: '(UTC-06:00) Saskatchewan',
      value: 'Canada Central Standard Time',
      localeValue: '(GMT-06:00) Saskatchewan',
      token: 'CANADA_CENTRAL_STANDARD_TIME',
      momentTimezone: 'America/Regina'),
  TimeZone(
      display: '(UTC-07:00) Arizona',
      value: 'US Mountain Standard Time',
      localeValue: '(GMT-07:00) Arizona',
      token: 'USMOUNTAIN_STANDARD_TIME',
      momentTimezone: 'America/Phoenix'),
  TimeZone(
      display: '(UTC-07:00) Chihuahua, La Paz, Mazatlan',
      value: 'Mountain Standard Time (Mexico)',
      localeValue: '(GMT-07:00) Chihuahua, La Paz, Mazatlan',
      token: 'MOUNTAIN_STANDARD_TIME(MEXICO)',
      momentTimezone: 'America/Chihuahua'),
  TimeZone(
      display: '(UTC-07:00) Mountain Time (US & Canada)',
      value: 'Mountain Standard Time',
      localeValue: '(GMT-07:00) Mountain Time (US & Canada)',
      token: 'MOUNTAIN_STANDARD_TIME',
      momentTimezone: 'America/Denver'),
  TimeZone(
      display: '(UTC-08:00) Baja California',
      value: 'Pacific Standard Time (Mexico)',
      localeValue: '(GMT-08:00) Baja California',
      token: 'PACIFIC_STANDARD_TIME(MEXICO)',
      momentTimezone: 'America/Tijuana'),
  TimeZone(
      display: '(UTC-08:00) Pacific Time (US & Canada)',
      value: 'Pacific Standard Time',
      localeValue: '(GMT-08:00) Pacific Time (US & Canada)',
      token: 'PACIFIC_STANDARD_TIME',
      momentTimezone: 'America/Los_Angeles'),
  TimeZone(
      display: '(UTC-09:00) Alaska',
      value: 'Alaskan Standard Time',
      localeValue: '(GMT-09:00) Alaska',
      token: 'ALASKAN_STANDARD_TIME',
      momentTimezone: 'America/Anchorage'),
  TimeZone(
      display: '(UTC-10:00) Hawaii',
      value: 'Hawaiian Standard Time',
      localeValue: '(GMT-10:00) Hawaii',
      token: 'HAWAIIAN_STANDARD_TIME',
      momentTimezone: 'Pacific/Honolulu'),
  TimeZone(
      display: '(UTC-11:00) Coordinated Universal Time-11',
      value: 'UTC-11',
      localeValue: '(GMT-11:00) Coordinated Universal Time-11',
      token: 'UTCHYPHEN11',
      momentTimezone: 'Pacific/Niue'),
  TimeZone(
      display: '(UTC-12:00) International Date Line West',
      value: 'Dateline Standard Time',
      localeValue: '(GMT-12:00) International Date Line West',
      token: 'DATELINE_STANDARD_TIME',
      momentTimezone: 'Etc/GMT+12')
];
