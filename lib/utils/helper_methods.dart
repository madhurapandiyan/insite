import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_intervals/add_intervals_view_model.dart';
import 'package:insite/views/adminstration/asset_settings_configure/model/configure_grid_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../core/models/add_notification_payload.dart' as add;
import '../core/models/add_notification_payload.dart';
import '../core/models/maintenance_asset_india_stack.dart';
import '../core/models/manage_notifications.dart';
import '../widgets/dumb_widgets/maintenance_asset_list_item.dart';
import 'date.dart';

class Utils {
  var tatahitachi = [
    ConfigureGridViewModel(
        assetIconKey: 1038,
        modelName: 'EX130 SUPER PLUS',
        image: "assets/images/model/EX130.png"),
    ConfigureGridViewModel(
        assetIconKey: 1026,
        modelName: 'EX200LC',
        image: "assets/images/model/EX200.png"),
    ConfigureGridViewModel(
        assetIconKey: 1034,
        modelName: 'EX200LC SUPER PLUS',
        image: "assets/images/model/EX200.png"),
    ConfigureGridViewModel(
        assetIconKey: 1043,
        modelName: 'EX200 Super Plus',
        image: "assets/images/model/EX200.png"),
    ConfigureGridViewModel(
        assetIconKey: 1033,
        modelName: 'EX210 Super',
        image: "assets/images/model/EX210.png"),
    ConfigureGridViewModel(
        assetIconKey: 1037,
        modelName: 'EX210LC SUPER PLUS',
        image: "assets/images/model/EX210LC.png"),
    ConfigureGridViewModel(
        assetIconKey: 1030,
        modelName: 'EX70 PRIME',
        image: "assets/images/model/EX70.png"),
    ConfigureGridViewModel(
        assetIconKey: 1032,
        modelName: 'EX70 SUPER PLUS',
        image: "assets/images/model/EX70.png"),
    ConfigureGridViewModel(
        assetIconKey: 1042,
        modelName: 'EX70 SUPER BSIV',
        image: "assets/images/model/EX70.png"),
    ConfigureGridViewModel(
        assetIconKey: 1041,
        modelName: 'SHINRAI-PRO',
        image: "assets/images/model/SHINRAI.png"),
    ConfigureGridViewModel(
        assetIconKey: 1028,
        modelName: 'SHINRAI PRIME',
        image: "assets/images/model/SHINRAI.png"),
    ConfigureGridViewModel(
        assetIconKey: 1031,
        modelName: 'SHINRAI - BX80',
        image: "assets/images/model/SHINRAI.png"),
    ConfigureGridViewModel(
        assetIconKey: 1029,
        modelName: 'SHINRAI-BX80',
        image: "assets/images/model/SHINRAI.png"),
    ConfigureGridViewModel(
        assetIconKey: 1039,
        modelName: 'SHINRAI-BX80-BSIV',
        image: "assets/images/model/SHINRAI.png"),
    ConfigureGridViewModel(
        assetIconKey: 1035,
        modelName: 'TL340H Prime',
        image: "assets/images/model/TL340H.png"),
    ConfigureGridViewModel(
        assetIconKey: 1006,
        modelName: "TL360Z",
        image: "assets/images/model/TL360Z.png"),
    ConfigureGridViewModel(
        assetIconKey: 108,
        modelName: "EX110",
        image: "assets/images/model/EX110.png"),
    ConfigureGridViewModel(
        assetIconKey: 1001,
        modelName: "EX130",
        image: "assets/images/model/EX130.png"),
    ConfigureGridViewModel(
        assetIconKey: 107,
        modelName: "EX200",
        image: "assets/images/model/EX200.png"),
    ConfigureGridViewModel(
        assetIconKey: 1003,
        modelName: "EX210",
        image: "assets/images/model/EX210.png"),
    ConfigureGridViewModel(
        assetIconKey: 1004,
        modelName: "EX210LC",
        image: "assets/images/model/EX210LC.png"),
    ConfigureGridViewModel(
        assetIconKey: 109,
        modelName: "EX70",
        image: "assets/images/model/EX70.png"),
    ConfigureGridViewModel(
        assetIconKey: 185,
        modelName: "SHINRAI",
        image: "assets/images/model/SHINRAI.png"),
    ConfigureGridViewModel(
        assetIconKey: 105,
        modelName: "TH76",
        image: "assets/images/model/TH76.png"),
    ConfigureGridViewModel(
        assetIconKey: 106,
        modelName: "TH86",
        image: "assets/images/model/TH86.png"),
    ConfigureGridViewModel(
        assetIconKey: 1005,
        modelName: "TL340H",
        image: "assets/images/model/TL340H.png"),
    ConfigureGridViewModel(
        assetIconKey: 1006,
        modelName: "TL360Z",
        image: "assets/images/model/TL360Z.png"),
    ConfigureGridViewModel(
        assetIconKey: 181,
        modelName: "TMX20",
        image: "assets/images/model/TMX20.png")
  ];

  static String getLastReportedDate(date) {
    try {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String suceessRegistration =
      "Registration successful.Asset status may take a few minutes to check status, click Asset Status after 10 minutes";

  static dynamic getHrsValueeData(
      dynamic percentageValue, dynamic runTimeValue) {
    if (percentageValue == 0 && runTimeValue == 0) {
      return 0.0;
    }
    int hrsData = ((percentageValue! * runTimeValue!) * 1 / 100);
    return hrsData;
  }

  static String getPercentageValueData(runTimevalue, idleValue) {
    if (runTimevalue == 0 && idleValue == 0) {
      return "0";
    }
    double perData = ((idleValue! / runTimevalue!) * 100);
    var data = perData;

    return data.toString();
  }

  static String getLastReportedDateOne(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getLastReportedDateTwo(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd-MM-yyyy');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String? getLastReportedDateTwoFilter(DateTime date) {
    try {
      String dateTime = date.toIso8601String();
      int index = dateTime.indexOf(".");
      var lastindex = dateTime.length;
      var finalstring = dateTime.replaceRange(index, lastindex, "");
      return finalstring;
    } catch (e) {
      return null;
    }
  }

  static String? getLastReportedDateFilterData(DateTime date) {
    try {
      String dateTime = date.toIso8601String();
      int index = dateTime.indexOf("T");
      var lastindex = dateTime.length;
      var finalstring = dateTime.replaceRange(index, lastindex, "");
      return finalstring;
    } catch (e) {
      return null;
    }
  }

  static String getLastReportedDateUTC(date) {
    try {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String formatHHmm(s) {
    if (s <= 0) {
      return "-";
    } else {
      int? mins = ((s / 60) % 60).toInt();
      int? hours = ((s / 60) / 60).toInt();
      Logger().i("hours $hours");
      Logger().i("mins $mins");
      return "$hours hr : $mins min";
    }
  }

  static String getLastReportedDateOneUTC(date) {
    try {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toLocal().toString());
      var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getLastReportedDateOneLocalUTC(date) {
    try {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String formatCurrentSystemTime(date) {
    Logger().d("formatCurrentSystemTime $date");
    try {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd HH:mm:ss.zzzz").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateInFormatddMMyyyy(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd-MM-yyyy');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateInFormatyyyyMMddTHHmmss(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateInFormatyyyyMMddTHHmmssZ(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateInFormatyyyyMMddTHHmmssZStart(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toString())
          .subtract(Duration(days: 1))
          .add(Duration(hours: 18, minutes: 30));
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateInFormatyyyyMMddTHHmmssZStartFaultDate(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toString())
          .subtract(Duration(days: 1))
          .add(Duration(hours: 18, minutes: 30, seconds: 0));
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateInFormatyyyyMMddTHHmmssZStartDashboardFaultDate(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date, true);
      var inputDate =
          DateTime.parse(parseDate.toString()).subtract(Duration(days: 1));
      //.add(Duration(hours: 18, minutes: 30));
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateInFormatReportCardDate(date) {
    try {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toString())
          .subtract(Duration(days: 1))
          .add(Duration(hours: 18, minutes: 30));

      var outputFormat = DateFormat("dd-MM-yyyy hh:mm a");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String? maintenanceToDateFormate(String date) {
    try {
      DateTime parseDate = DateTime.parse(date);
      var data = parseDate.add(Duration(hours: 18, minutes: 29, seconds: 59));
      var formatedStringData = data.toString();
      return formatedStringData.replaceRange(19, formatedStringData.length, "");
    } catch (e) {
      return null;
    }
  }

  static String? maintenanceFromDateFormate(String date) {
    try {
      DateTime parseDate = DateTime.parse(date).subtract(Duration(days: 1));
      var data = parseDate.add(Duration(hours: 23, minutes: 59, seconds: 59));
      var formatedStringData = data.toString();
      return formatedStringData.replaceRange(19, formatedStringData.length, "");
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  static String? maintenanceFromDateFormateEndDate(String date) {
    try {
      DateTime parseDate = DateTime.parse(date);
      var data = parseDate.add(Duration(hours: 00, minutes: 00, seconds: 00));
      var formatedStringData = data.toString();
      return formatedStringData.replaceRange(19, formatedStringData.length, "");
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  static String? maintenanceFromDateNextWeekEndDate(String date) {
    try {
      DateTime parseDate = DateTime.parse(date).add(Duration(days: 6));
      var data = parseDate.add(Duration(hours: 23, minutes: 59, seconds: 59));
      var formatedStringData = data.toString();
      return formatedStringData.replaceRange(19, formatedStringData.length, "");
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  static String getDateInFormatMMddyyyy(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toString());
          // .subtract(Duration(days: 1))
          // .add(Duration(hours: 18, minutes: 30));
      var outputFormat = DateFormat("MM/dd/yyyy");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateInFormatyyyyMMddTHHmmssZEnd(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toString())
          .add(Duration(hours: 18, minutes: 29, seconds: 59));

      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateInFormatyyyyMMddTHHmmssZEndFaultDate(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toString())
          // .subtract(Duration(days: 1))
          .add(Duration(hours: 18, minutes: 29, seconds: 59));
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getLastDuration(date) {
    try {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('hh:mm');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getLastDurationOne(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('hh:mm');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getLastReportedTime(date) {
    try {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toLocal().toString());
      var outputFormat = DateFormat('hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateInFormatyyyyMMddTHHmmssZStartSingleAssetDay(date) {
    try {
      DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date, true);
      var inputDate = DateTime.parse(parseDate.toString())
          .subtract(Duration(days: 7))
          .add(Duration(hours: 18, minutes: 30));
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static String parseDate(DateTime dateTime) {
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }

  static String getDayOfMonthSuffix(final int n) {
    if (n >= 11 && n <= 13) {
      return "th";
    }
    switch (n % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  static String getIdlingWidgetLabel(data) {
    String title = data;
    String replaced = title.replaceAll("[", "").replaceAll("]", "");
    List<String> list = replaced.split(",");
    if (list[1].isEmpty) {
      title = ">" + list[0] + "%";
    } else {
      title = list[0] + "-" + list[1] + "%";
    }
    return title;
  }

  static String? getFuleLevelWidgetLabel(data, isForFilter) {
    String? title = data;
    Logger().i("getFuleLevelWidgetLabel $title");
    // if (title == "100") {
    //   title = "<=" + title + "%";
    // } else {
    //   title = "<" + title + "%";
    // }
    // if (isForFilter) {
    //   return "Fuel Level : " + title;
    // } else {
    //   return title;
    // }
    if (title == "25") {
      return "0-25%";
    } else if (title == "50") {
      return "26-50%";
    } else if (title == "75") {
      return "51-75%";
    } else if (title == "100") {
      return "76-100%";
    } else {
      return title;
    }
  }

  static String getPageTitle(ScreenType? type) {
    Logger().d("getPageTitle $type");
    String title = "";
    switch (type) {
      case ScreenType.DASHBOARD:
        title = "DASHBOARD";
        break;
      case ScreenType.FLEET:
        title = "FLEET";
        break;
      case ScreenType.UTILIZATION:
        title = "UTILIZATION";
        break;
      case ScreenType.ASSET_OPERATION:
        title = "ASSET OPERATION";
        break;
      case ScreenType.LOCATION:
        title = "LOCATION";
        break;
      case ScreenType.HEALTH:
        title = "HEALTH";
        break;
      case ScreenType.MAINTENANCE:
        title = "MAINTENANCE";
        break;
      case ScreenType.ADMINISTRATION:
        title = "ADMINISTRATION";
        break;
      case ScreenType.PLANT:
        title = "PLANT";
        break;
      case ScreenType.SUBSCRIPTION:
        title = "SUBSCRIPTION";
        break;
      case ScreenType.NOTIFICATIONS:
        title = "NOTIFICATIONS";
        break;
      case ScreenType.HOME:
        title = "HOME";
        break;
      case ScreenType.USER_MANAGEMENT:
        title = "USER";
        break;
      case ScreenType.MANAGE_NOTIFICATION:
        title = "MANAGE NOTIFICATION";
        break;
      case ScreenType.ADD_NOTIFICATION:
        title = "ADD NOTIFICATION";
        break;
      case ScreenType.EDIT_NOTIFICATION:
        title = "EDIT NOTIFICATION";
        break;
      case ScreenType.ADD_NEW_GROUP:
        title = "ADD NEW GROUP";
        break;
      case ScreenType.MANAGE_NEW_GROUP:
        title = "MANAGE GROUP";
        break;
      case ScreenType.ADD_REPORT:
        title = "ADD REPORT";
        break;
      case ScreenType.MANAGE_REPORT:
        title = "MANAGE REPORT";
        break;
      case ScreenType.ADD_GEOFENCE:
        title = "ADD GEOFENCE";
        break;
      case ScreenType.MANAGE_GEOFENCE:
        title = "MANAGE GEOFENCE";
        break;
      default:
    }
    return title;
  }

  static String getAdminModuleMenuTitle(AdminAssetsButtonType type) {
    Logger().d("getAdminModuleMenuTitle $type");
    String title = "";
    switch (type) {
      case AdminAssetsButtonType.ADDNEWUSER:
        title = "ADD NEW USER";
        break;
      case AdminAssetsButtonType.MANAGEUSER:
        title = "MANAGE USER";
        break;
      case AdminAssetsButtonType.ADDNEWGROUPS:
        title = "ADD NEW GROUP";
        break;
      case AdminAssetsButtonType.MANAGEGROUPS:
        title = "MANAGE GROUP";
        break;
      case AdminAssetsButtonType.ADDNEWGEOFENCES:
        title = "ADD NEW GEOFENCES";
        break;
      case AdminAssetsButtonType.MANAGEGEOFENCES:
        title = "MANAGE GEOFENCES";
        break;
      case AdminAssetsButtonType.MANAGEREPORTS:
        title = "MANAGE REPORTS";
        break;
      case AdminAssetsButtonType.ADDNEWREPORT:
        title = "ADD NEW REPORT";
        break;
      case AdminAssetsButtonType.VIEWDASHBOARD:
        title = "VIEW DASHBOARD";
        break;
      case AdminAssetsButtonType.VIEWREGISTRATION:
        title = "VIEW REGISTRATION";
        break;
      case AdminAssetsButtonType.VIEWFLEETSTATUS:
        title = "VIEW FLEET STATUS";
        break;
      case AdminAssetsButtonType.VIEWSMSMANAGEMENT:
        title = "VIEW SMS MANAGEMENT";
        break;
      case AdminAssetsButtonType.VIEWREPLACEMENT:
        title = "VIEW REPLACEMENT";
        break;
      case AdminAssetsButtonType.VIEWTRANSFERHISTORY:
        title = "VIEW TRANSFER HISTORY";
        break;
      case AdminAssetsButtonType.SINGLEASSETREG:
        title = "SINGLE ASSET REGISTRATION";
        break;
      case AdminAssetsButtonType.SINGLEASSETTRANSFER:
        title = "SINGLE ASSET TRANSFER";
        break;
      case AdminAssetsButtonType.MULTIPLEASSETREG:
        title = "MULTIPLE ASSET REGISTRATION";
        break;
      case AdminAssetsButtonType.MULTIPLEASSESTTRANSFER:
        title = "MULTIPLE ASSET TRANSFER";
        break;
      case AdminAssetsButtonType.VIEWHIERACHY:
        title = "VIEW HIERARCHY";
        break;
      case AdminAssetsButtonType.SMSSCHEDULEFORSINGLEASSET:
        title = "SMS SCHEDULE FOR SINGLE ASSET";
        break;
      case AdminAssetsButtonType.SMSSCHEDULEFORMUTLIPLEASSET:
        title = "SMS SCHEDULE FOR MUTLIPLE ASSET";
        break;
      case AdminAssetsButtonType.REPORTSUMMARYFORSMS:
        title = "REPORT SUMMARY FOR SMS";
        break;
      case AdminAssetsButtonType.DEVICEREPLACEMENT:
        title = "DEVICE REPLACEMENT";
        break;
      case AdminAssetsButtonType.REPLACEMENTSTATUS:
        title = "REPLACEMENT STATUS";
        break;
      case AdminAssetsButtonType.ADDNEWNOTIFICATION:
        title = "ADD NEW NOTIFICATION";
        break;
      case AdminAssetsButtonType.MANAGENOTIFICATION:
        title = "MANAGE NOTIFICATION";
        break;

      default:
    }
    return title;
  }

  static String generateCodeChallenge(String codeVerifier, bool isToSave) {
    final LocalService? _localService = locator<LocalService>();

    if (isToSave) {
      Logger().w(codeVerifier);
      _localService!.saveCodeVerfier(codeVerifier);
    }

    var bytes = utf8.encode(codeVerifier);
    var digest = sha256.convert(bytes);
    var codeChallenge = base64UrlEncode(digest.bytes);
    if (codeChallenge.endsWith('=')) {
      codeChallenge = codeChallenge.substring(0, codeChallenge.length - 1);
    }
    return codeChallenge;
  }

  static String generateCodeVerifier(String codeChallenge) {
    var codeVerifier = base64Decode(codeChallenge);
    return codeVerifier.toString();
  }

  static String getTitle(FilterType? type) {
    String title = "";
    switch (type) {
      case FilterType.PRODUCT_FAMILY:
        title = "PRODUCT FAMILY";
        break;
      case FilterType.MAKE:
        title = "MAKE";
        break;
      case FilterType.MODEL:
        title = "MODEL";
        break;
      case FilterType.MODEL_YEAR:
        title = "MODEL YEAR";
        break;
      case FilterType.LOCATION_SEARCH:
        title = "LOCATION SEARCH";
        break;
      case FilterType.APPLICATION:
        title = "APPLICATION";
        break;
      case FilterType.ASSET_COMMISION_DATE:
        title = "ASSET COMMISSIONING DATE";
        break;
      case FilterType.SUBSCRIPTION_DATE:
        title = "SUBSCRIPTION TYPE";
        break;
      case FilterType.DEVICE_TYPE:
        title = "DEVICE TYPE";
        break;
      case FilterType.ALL_ASSETS:
        title = "ASSET STATUS";
        break;
      case FilterType.FUEL_LEVEL:
        title = "FUEL LEVEL";
        break;
      case FilterType.IDLING_LEVEL:
        title = "IDLING LEVEL";
        break;
      case FilterType.DATE_RANGE:
        title = "DATE RANGE";
        break;
      case FilterType.CLUSTOR:
        title = "CLUSTOR";
        break;
      case FilterType.SEVERITY:
        title = "SEVERITY";
        break;
      case FilterType.USERTYPE:
        title = "USER TYPE";
        break;
      case FilterType.JOBTYPE:
        title = "JOB TYPE";
        break;
      case FilterType.FREQUENCYTYPE:
        title = "Frequency";
        break;
      case FilterType.REPORT_FORMAT:
        title = "Report Format";
        break;
      case FilterType.REPORT_TYPE:
        title = "Report Type";
        break;
      case FilterType.MANUFACTURER:
        title = "MANUFACTURER";
        break;
      case FilterType.SERVICE_TYPE:
        title = "SERVICE TYPE";
        break;
      case FilterType.SERVICE_STATUS:
        title = "SERVICE STATUS";
        break;
      case FilterType.ASSET_TYPE:
        title = "ASSET TYPE";
        break;

      default:
    }
    return title;
  }

  static double getDecimalFromTime(DateTime input) {
    int totalSeconds = (input.minute * 60) + input.second;
    double rep = totalSeconds / 3600;
    return (input.hour + rep);
  }

  static String? getFilterTitleForChipView(FilterData data) {
    String? title = data.title;
    if (data.type == FilterType.DATE_RANGE) {
      title = "Date " +
          "(" +
          getDateInFormatddMMyyyy(data.extras![0]) +
          " - " +
          getDateInFormatddMMyyyy(data.extras![1]) +
          ")";
    } else if (data.type == FilterType.IDLING_LEVEL) {
      if (data.extras![1]!.isEmpty) {
        title = "Idle %: " + ">" + data.extras![0]! + "%";
      } else {
        title = "Idle %: " + data.extras![0]! + "-" + data.extras![1]! + "%";
      }
    } else if (data.type == FilterType.FUEL_LEVEL) {
      Logger().wtf(title);
      if (title == "100") {
        title = "Fuel Level : " + " " + "76-100" + "%";
      } else if (title == "25") {
        title = "Fuel Level : " + "" + "0-25" + "%";
      } else if (title == "50") {
        title = "Fuel Level : " + "" + "26-50" + "%";
      } else if (title == "75") {
        title = "Fuel Level : " + "" + "51-75" + "%";
      }
    } else if (data.type == FilterType.SEVERITY) {
      title = Utils.getFaultLabel(data.title!);
    }
    return title;
  }

  static String? getFilterTitleForList(FilterData data) {
    String? title = data.title;
    if (data.type == FilterType.DATE_RANGE) {
      title = "Date " + data.extras![0]! + " " + data.extras![1]!;
    } else if (data.type == FilterType.IDLING_LEVEL) {
      if (data.extras![1]!.isEmpty) {
        title = ">" + data.extras![0]! + "%";
      } else {
        title = data.extras![0]! + "-" + data.extras![1]! + "%";
      }
    } else if (data.type == FilterType.FUEL_LEVEL) {
      title = getFuleLevelWidgetLabel(title, true);
    } else if (data.type == FilterType.SEVERITY) {
      title = Utils.getFaultLabel(data.title!);
    }
    return title;
  }

  static DateTime? getMinDate(List<DateTime?> inputDates) {
    DateTime? minDate = DateTime.now();

    for (DateTime? item in inputDates) {
      if (item == null) {
      } else if (minDate!.isBefore(item)) {
        minDate = item;
      }
    }

    return minDate;
  }

  static DateTime? getMaxDate(List<DateTime?> inputDates) {
    DateTime? maxDate = DateTime.now();
    for (DateTime? item in inputDates) {
      if (item == null) {
      } else if (maxDate!.isAfter(item)) {
        maxDate = item;
      }
    }
    return maxDate;
  }

  getImageWithAssetIconKey({dynamic assetIconKey, String? model}) {
    // if value string
    int? iconKey;
    if (assetIconKey.runtimeType == String) {
      iconKey = int.parse(assetIconKey);
    } else if (assetIconKey.runtimeType == double) {
      iconKey = (assetIconKey as double).toInt();
    } else {
      iconKey = assetIconKey;
    }
    if (tatahitachi.any((element) => element.modelName == model)) {
      if (tatahitachi.any((element) => element.assetIconKey == iconKey)) {
        Logger().i("icon key found");
        var data = tatahitachi
            .singleWhere((element) => element.assetIconKey == iconKey);
        if (data != null) {
          Logger().v("data");
          return data.image;
        } else {
          return "assets/images/0.png";
        }
      } else {
        return "assets/images/0.png";
      }
    } else {
      return "assets/images/0.png";
    }
  }

  getImageAssetConfiguration(
    dynamic assetIconKey,
  ) {
    int? iconKey;
    if (assetIconKey.runtimeType == String) {
      iconKey = int.parse(assetIconKey);
    } else {
      iconKey = assetIconKey;
    }
    switch (iconKey) {
      case 108:
        return "assets/images/model/EX110.png";
      case 109:
        return "assets/images/model/EX70.png";
      case 1001:
        return "assets/images/model/EX130.png";
      case 107:
        return "assets/images/model/EX200.png";
      case 1003:
        return "assets/images/model/EX210.png";
      case 1004:
        return "assets/images/model/EX210LC.png";
      case 185:
        return "assets/images/model/SHINRAI.png";
      case 105:
        return "assets/images/model/TH76.png";
      case 106:
        return "assets/images/model/TH86.png";
      case 1005:
        return "assets/images/model/TL340H.png";
      case 1006:
        return "assets/images/model/TL360Z.png";
      case 181:
        return "assets/images/model/TMX20.png";
      default:
        return "assets/images/0.png";
    }
  }

  imageData(String model) {
    switch (model) {
      case "EX200LC SUPER PLUS":
        return "assets/images/model/EX200.png";
      case "EX210LC SUPER PLUS":
        return "assets/images/model/EX210LC.png";
      case "EX70 SUPER PLUS":
        return "assets/images/model/EX70.png";
      case "EX130 SUPER PLUS":
        return "assets/images/model/EX130.png";
      case "EX215 SUPER PLUS":
        return "assets/images/model/EX200.png";
      case "EX70 PRIME":
        return "assets/images/model/EX70.png";
      case "TL340H PRIME":
        return "assets/images/model/TL340H.png";
      case "EX110":
        return "assets/images/model/EX110.png";
      case "EX200":
        return "assets/images/model/EX200.png";
      case "EX200LC":
        return "assets/images/model/EX200.png";
      case "EX70 PRIME":
        return "assets/images/model/EX70.png";
      case "SHINRAI-BX80":
        return "assets/images/model/SHINRAI.png";
      case "SHINRAI-BX80-BSIV":
        return "assets/images/model/SHINRAI.png";
      case "SHINRAI - BX80":
        return "assets/images/model/SHINRAI.png";
      case "SHINRAI PRIME":
        return "assets/images/model/SHINRAI.png";
      case "SHINRAI-PRO":
        return "assets/images/model/SHINRAI.png";
      case "TL340H":
        return "assets/images/model/TL340H.png";
      case "TH76":
        return "assets/images/model/TH76.png";
      case "5T WL":
        return "assets/images/wheel_loader.png";
      case "ZW225-6":
        return "assets/images/wheel_loader.png";
      default:
        return "assets/images/0.png";
    }
  }

  // imageData(String model) {
  //   //Excavator
  //   ifmodel == "EX70 SUPER PLUS" ||
  //        (model == "EX200LC SUPER PLUS" ||
  //       model == "EX210LC SUPER PLUS" ||
  //       model == "EX130 SUPER PLUS" ||
  //       model == "EX215 SUPER PLUS" ||
  //       model == "TL340H PRIME" ||
  //       model == "EX110" ||
  //       model == "EX200" ||
  //       model == "EX200LC" ||
  //       model == "PZX50" ||
  //       model == "EX70 PRIME") {
  //     return "assets/images/excavator.png";
  //   }
  //   //backhoe loader
  //   else if (model == "SHINRAI - BX80" ||
  //       model == "SHINRAI-BX80" ||
  //       model == "SHINRAI-BX80-BSIV" ||
  //       model == "SHINRAI PRIME" ||
  //       model == "SHINRAI-PRO" ||
  //       model == "TH76" ||
  //       model == "TL340H") {
  //     return "assets/images/backhoe_loader.png";
  //   } else if (model == "TL340H Prime" ||
  //       model == "TL340H" ||
  //       model == "5T WL" ||
  //       model == "ZW225-6") {
  //     return "assets/images/wheel_loader.png";
  //   } else {
  //     return "assets/images/0.png";
  //   }

  //   // if (model.contains("SHINRAI")) {
  //   //   return "assets/images/shinrai.png";
  //   // } else if (model.contains("EX130")) {
  //   //   return "assets/images/EX130.png";
  //   // } else if (model.contains("EX210")) {
  //   //   return "assets/images/EX210.png";
  //   // } else if (model.contains("EX210LC")) {
  //   //   return "assets/images/EX210LC.png";
  //   // } else if (model.contains("TH86")) {
  //   //   return "assets/images/TH86.png";
  //   // } else if (model.contains("TL340H")) {
  //   //   return "assets/images/TL340H.png";
  //   // } else {
  //   //   return "assets/images/EX210.png";
  //   // }
  // }

  static showInfo(BuildContext context, title, message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: InsiteInfoDialog(
            title: title,
            message: message,
            onOkClicked: () {
              Navigator.pop(context, true);
            },
          ),
        );
      },
    );
  }

  static double checkNull(double? value) {
    return value == null ? 0.0 : value;
  }

  static double? greatestOfThree(double a, double b, double? c) {
    return (a > b) ? (a > c! ? a : c) : (b > c! ? b : c);
  }

  static double findlargestNoFromList(List<double> list) {
    var listToSort = list;
    listToSort.sort();
    return listToSort.last;
  }

  static Color getFaultColor(text) {
    return text != null && text != null
        ? text.toLowerCase() == "red" || text.toLowerCase() == "high"
            ? buttonColorFive
            : text.toLowerCase() == "orange" || text.toLowerCase() == "medium"
                ? Colors.orange
                : text.toLowerCase() == "yellow" || text.toLowerCase() == "low"
                    ? Colors.yellow
                    : buttonColorFive
        : buttonColorFive;
  }

  static Color getMaintenanceColor(text) {
    return text != null && text != null
        ? text.toLowerCase() == "Overdue" || text.toLowerCase() == "Overdue"
            ? buttonColorFive
            : text.toLowerCase() == "orange" || text.toLowerCase() == "medium"
                ? Colors.orange
                : text.toLowerCase() == "upcoming" ||
                        text.toLowerCase() == "low"
                    ? Colors.yellow
                    : buttonColorFive
        : buttonColorFive;
  }

  static String getFaultLabel(String text) {
    return text.toLowerCase() == "red"
        ? "HIGH"
        : text.toLowerCase() == "orange"
            ? "MEDIUM"
            : text.toLowerCase() == "yellow"
                ? "LOW"
                : text;
  }

  static String getMakeTitle(String text) {
    if (text.toLowerCase() == "thc") {
      return "TATA HITACHI";
    } else {
      return text;
    }
  }

  static showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static String getUserId(String userId) {
    var splitList = userId.split("\"userID\":");
    var splitList2 = splitList[1].split(",\"UUID\"");
    return splitList2[0];
  }

  static List reportColumn(String value) {
    var splitList = value.split("\"");
    splitList.removeWhere((element) =>
        element == "\"" || element == "[" || element == "]" || element == ",");
    Logger().w(splitList);
    return splitList;
  }

  static String getCountValue(double value) {
    var _formattedNumber = NumberFormat.compact().format(value);
    return _formattedNumber;
  }

  static String getFilterData(
      List<FilterData?> appliedFilter, FilterType type) {
    String? filterDetails;
//Logger().w(appliedFilter.first?.toJson());
    if (appliedFilter.isNotEmpty) {
      for (var i = 0; i < appliedFilter.length; i++) {
        // if (type == FilterType.ASSET_STATUS) {
        //   filterDetails =
        //       "${filterDetails == null ? "" : "$filterDetails,"}${appliedFilter[i]!.title}";

        // } else if (type == FilterType.FUEL_LEVEL) {
        //   filterDetails =
        //       "${filterDetails == null ? "" : "$filterDetails,"}${appliedFilter[i]!.title}";

        // } else if (type == FilterType.PRODUCT_FAMILY) {
        //   filterDetails =
        //       "${filterDetails == null ? "" : "$filterDetails,"}${appliedFilter[i]!.title}";

        // } else if (type == FilterType.MODEL) {
        //   Logger().d(appliedFilter[i]!.title);
        //   filterDetails = "${filterDetails == null ? "" : "$filterDetails,"}${appliedFilter[i]!.title}";

        //  }
        filterDetails =
            "${filterDetails == null ? "" : "$filterDetails,"}${appliedFilter[i]!.title}";
      }
      filterDetails!.trimLeft();

      return filterDetails;
    } else {
      return "";
    }
  }

  static getStringListData(List<String> listData) {
    if (listData == null) {
      return null;
    } else {
      String doublequotes = "\"";
      List<dynamic> value = [];
      value.clear();
      listData.forEach((element) {
        if (value.any((data) => (data).contains(element))) {
        } else {
          value.add(doublequotes + element + doublequotes);
        }
      });
      Logger().w(value);
      return value;
    }
  }

  static String getNotificationCondition(ConfiguredAlerts? alert) {
    String? data;
    if (alert?.notificationTypeGroupID == 1) {
      data =
          "Asset Staus ${alert?.operands?.first.condition} ${alert?.operands?.first.operandName}";
      return data;
    } else if (alert?.notificationTypeGroupID == 8) {
      String faultCondition = "Fault Code";
      var OperandData = alert!.operands
          ?.where((element) => element.operandName == "Severity")
          .toList();
      if (OperandData!.length == 1) {
        if (OperandData.any((element) => element.value == "1")) {
          faultCondition = faultCondition + " High";
        }
        if (OperandData.any((element) => element.value == "2")) {
          faultCondition = faultCondition + " Medium";
        }
        if (OperandData.any((element) => element.value == "3")) {
          faultCondition = faultCondition + " Low";
        }
      } else if (OperandData.length >= 2) {
        if (OperandData.any((element) => element.value == "1")) {
          faultCondition = faultCondition + " High";
        }
        if (OperandData.any((element) => element.value == "2")) {
          faultCondition = faultCondition + " And Medium";
        }
        if (OperandData.any((element) => element.value == "3")) {
          faultCondition = faultCondition + " And Low";
        }
      } else {
        faultCondition = "Fault Code";
      }
      return faultCondition;
    } else if (alert?.notificationTypeGroupID == 5) {
      data =
          "Engine Hours ${alert?.operands?.first.condition}  ${alert?.operands?.first.value}${alert?.operands?.first.unit}";
      return data;
    } else if (alert?.notificationTypeGroupID == 3) {
      data =
          "Fuel ${alert?.operands?.first.condition} ${alert?.operands?.first.value}%";
      return data;
    } else if (alert?.notificationTypeGroupID == 15) {
      data =
          "Fuel Loss ${alert?.operands?.first.condition} ${alert?.operands?.first.value}%";
      return data;
    } else if (alert?.operands?.first.value == "1") {
      data = "Maintenance Interval Overdue";
      return data;
    } else if (alert?.operands?.first.value == "2") {
      data = "Maintenance Interval Upcoming";
      return data;
    } else {
      return "${alert?.operands?.first.condition} ${alert?.operands?.first.value}";
    }
  }

  static List<String>? getReportColumn(String value) {
    List<String>? list = [];
    if (value == "Asset Operation") {
      list = [
        "assetId",
        "assetSerialNumber",
        "lastEvent",
        "lastEventTime",
        "distanceTravelledKilometers",
        "lastKnownOperator",
        "totalDuration"
      ];
      return list;
    } else if (value == "Fleet Summary") {
      list = [
        "assetId",
        "assetSerialNumber",
        "model",
        "status",
        "hourMeter",
        "lastReportedLocation",
        "lastReportedTime",
        "fuelLevelLastReported",
        "fuelReportedTime",
        "notifications",
        "geofenceList",
        "isGpsRollOverAffected"
      ];
      return list;
    } else if (value == "Multi-Asset Utilization") {
      list = [
        "callouts",
        "assetId",
        "assetSerialNumber",
        "model",
        "latestUtzReport",
        "runtimeHours",
        "targetRuntime",
        "runtimeFuelConsumedLiters",
        "runtimeFuelConsumptionRate",
        "workingHours",
        "workingFuelConsumedLiters",
        "workingFuelConsumptionRate",
        "idleHours",
        "idleFuelConsumedLiters",
        "idleFuelConsumptionRate",
        "lastUtzLocation",
        "startDate",
        "endDate"
      ];
      return list;
    } else if (value == "Utilization Details") {
      list = [
        "callouts",
        "lastReportedTime",
        "lastRuntimeHourMeter",
        "runtimeHours",
        "lastRuntimeFuelConsumptionLitersMeter",
        "runtimeFuelConsumedLiters",
        "runtimeFuelConsumptionRate",
        "workingHours",
        "workingFuelConsumedLiters",
        "workingFuelConsumptionRate",
        "lastIdleHourMeter",
        "idleHours",
        "lastIdleFuelConsumptionLitersMeter",
        "idleFuelConsumedLiters",
        "idleFuelConsumptionRate",
        "startDate",
        "endDate"
      ];
      return list;
    } else if (value == "Fault Code Asset Details") {
      list = [
        "assetId",
        "assetSerialNumber",
        "model",
        "faultIdentifiers",
        "description",
        "source",
        "lastReportedTime",
        "severityLabel",
        "hourMeter",
        "lastReportedLocation"
      ];
      return list;
    } else if (value == "Fault Summary Faults List") {
      list = [
        "assetId",
        "serialNo",
        "model",
        "faultCode",
        "faultDate",
        "severityLabel",
        "source",
        "description",
        "currentLocation",
        "lastReportedDate",
        "hourMeter"
      ];
      return list;
    } else if (value == "Asset Location History") {
      list = [
        "assetName",
        "serialNumber",
        "locationEventLocalTime",
        "hourmeter",
        "odometer",
        "location",
        "assetStatus",
        "fromDate",
        "toDate",
        "latitude",
        "longitude"
      ];
      return list;
    } else if (value == "Backhoe Loader Operation") {
      Logger().w(list.length);
      list = [
        "assetSerialNumber",
        "lastReportedTime",
        "lastReportedTimeZoneAbbrev",
        "lastRuntimeHourMeter",
        "runtimeHours",
        "idleHours",
        "workingHours",
        "backhoeIdleHours",
        "backhoeWorkingHours",
        "backhoeRuntimeHours",
        "loaderIdleHours",
        "loaderWorkingHours",
        "loaderRuntimeHours",
      ];
      return list;
    } else if (value == "Excavator Usage") {
      list = [
        "assetSerialNumber",
        "lastReportedTime",
        "lastReportedTimeZoneAbbrev",
        "lastRuntimeHourMeter",
        "runtimeHours",
        "idleHours",
        "workingHours",
        "rockBreakerRuntimeHours",
        "distanceTravelledHours",
        "powerModeRuntimeHours",
        "standardModeRuntimeHours",
        "autoIdleRuntimeHours",
      ];
      return list;
    } else if (value == "Multi-Asset Backhoe Loader Operation") {
      list = [
        "assetSerialNumber",
        "latestUtzReport",
        "lastReportedTimeZoneAbbrev",
        "lastRuntimeHourMeter",
        "runtimeHours",
        "idleHours",
        "workingHours",
        "lastUtzLocation",
        "backhoeIdleHours",
        "backhoeWorkingHours",
        "backhoeRuntimeHours",
        "loaderIdleHours",
        "loaderWorkingHours",
        "loaderRuntimeHours",
      ];
      return list;
    } else if (value == "Multi-Asset Excavator Usage") {
      list = [
        "assetSerialNumber",
        "latestUtzReport",
        "lastReportedTimeZoneAbbrev",
        "runtimeHours",
        "idleHours",
        "workingHours",
        "lastUtzLocation",
        "rockBreakerRuntimeHours",
        "distanceTravelledHours",
        "powerModeRuntimeHours",
        "standardModeRuntimeHours",
        "autoIdleRuntimeHours",
      ];
      return list;
    }
    return null;
  }

  static String? getQueryUrl(
      String assetsDropDownValue, List<String>? associatedIdentifier) {
    String querUrl;
    switch (assetsDropDownValue) {
      case "Fleet Summary":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/FleetSummary/v5?sort=assetid";
        return querUrl;
      case "Multi-Asset Utilization":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/Utilization/v5?startDate=&endDate=&sort=-RuntimeHours";

        return querUrl;
      case "Utilization Details":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/api/v1/Utilization/Details?assetUid=${associatedIdentifier!.first}&startDate=&endDate=&sort=-RuntimeHours";

        return querUrl;
      case "Asset Operation":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/AssetOperation?startDate=&endDate=";
        return querUrl;
      case "Fault Summary Faults List":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fault/1.0/Health/Faults/Search?startDateTime=&endDateTime=&langDesc=en-US";
        return querUrl;
      case "Fault Code Asset Details":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fault/1.0/health/FaultDetails/v1?assetUid=${associatedIdentifier!.first}&startDateTime=&endDateTime=&langDesc=en-US";
        return querUrl;
      case "Backhoe Loader Operation":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/api/v5/Utilization/Details?AssetUid=347790bd-282e-11ec-82e0-0ae8ba8d3970&startDate=07%2F25%2F2022&endDate=07%2F25%2F2022&sort=-LastReportedUtilizationTime&includeNonReportedDays=true&includeOutsideLastReportedDay=false";
        return querUrl;
      case "Excavator Usage":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/api/v5/Utilization/Details?AssetUid=fba953c3-b251-11eb-82db-0ae8ba8d3970&startDate=&endDate=&includeNonReportedDays=true&includeOutsideLastReportedDay=false&sort=-LastReportedUtilizationTime";
        return querUrl;
      case "Multi-Asset Backhoe Loader Operation":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/UtilizationOperation/v5?startDate=&endDate=&sort=-RuntimeHours";
        return querUrl;
      case "Multi-Asset Excavator Usage":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/UtilizationOperation/v5?startDate=&endDate=&sort=-RuntimeHours";
        return querUrl;
    }
  }

  static String? getEditQueryUrl(
      String assetsDropDownValue, List<String>? associatedIdentifier) {
    String querUrl;

    switch (assetsDropDownValue) {
      case "FleetSummary":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/FleetSummary/v5?sort=assetid";
        return querUrl;
      case "MultiAssetUtilization":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/Utilization/v5?startDate=&endDate=&sort=-RuntimeHours";

        return querUrl;
      case "UtilizationDetails":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/Utilization?assetUid=${associatedIdentifier!.first}&startDate=&endDate=&sort=-RuntimeHours";

        return querUrl;
      case "AssetOperation":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/AssetOperation?startDate=&endDate=";
        return querUrl;
      case "FaultSummaryFaultsList":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fault/1.0/Health/Faults/Search?startDateTime=&endDateTime=&langDesc=en-US";
        return querUrl;
      case "FaultCodeAssetDetails":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fault/1.0/health/FaultDetails/v1?assetUid=${associatedIdentifier!.first}&startDateTime=&endDateTime=&langDesc=en-US";
        return querUrl;
      case "BackhoeLoaderOperation":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/api/v5/Utilization/Details?AssetUid=347790bd-282e-11ec-82e0-0ae8ba8d3970&startDate=07%2F25%2F2022&endDate=07%2F25%2F2022&sort=-LastReportedUtilizationTime&includeNonReportedDays=true&includeOutsideLastReportedDay=false";
        return querUrl;
      case "Excavator Usage":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/api/v5/Utilization/Details?AssetUid=fba953c3-b251-11eb-82db-0ae8ba8d3970&startDate=&endDate=&includeNonReportedDays=true&includeOutsideLastReportedDay=false&sort=-LastReportedUtilizationTime";
        return querUrl;

      case "Multi-AssetBackhoeLoaderOperation":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/UtilizationOperation/v5?startDate=&endDate=&sort=-RuntimeHours";
        return querUrl;
      case "Multi-AssetExcavatorUsage":
        querUrl =
            "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/UtilizationOperation/v5?startDate=&endDate=&sort=-RuntimeHours";
        return querUrl;
    }
  }

  static reportSvcBody(String? value, List<String>? assetIds) {
    Logger().i(value);
    if (value == "Asset Operation" || value == "AssetOperation") {
      return assetIds;
    } else if (value == "Fleet Summary" || value == "FleetSummary") {
      return assetIds;
    } else if (value == "Multi-Asset Utilization" ||
        value == "MultiAssetUtilization") {
      return assetIds;
    } else if (value == "Utilization Details" ||
        value == "UtilizationDetails") {
      return null;
    } else if (value == "Fault Code Asset Details" ||
        value == "FaultCodeAssetDetails") {
      return null;
    } else if (value == "Fault Summary Faults List" ||
        value == "FaultSummaryFaultsList") {
      return null;
    } else {
      return null;
    }
  }

  static String getSvcMethod(String? assetsDropDownValue) {
    if (assetsDropDownValue == "Utilization Details") {
      return "";
    } else if (assetsDropDownValue == "Fault Code Asset Details" ||
        assetsDropDownValue == "Backhoe Loader Operation") {
      return "GET";
    } else {
      return "POST";
    }
  }

  static getNotificationSchedule(List<add.Schedule> data) {
    List<Map<String, dynamic>> scheduleData = [];
    String doubleQuote = "\"";
    data.forEach((element) {
      Map<String, dynamic>? singleSchedule = null;
      singleSchedule = {
        "day": element.day,
        "startTime": doubleQuote + element.startTime! + doubleQuote,
        "endTime": doubleQuote + element.endTime! + doubleQuote,
      };
      scheduleData.add(singleSchedule);
    });
    return scheduleData;
  }

  static getOperand(List<add.Operand>? data) {
    List<Map<String, dynamic>> operandData = [];
    String doubleQuote = "\"";
    data?.forEach((element) {
      Map<String, dynamic>? singleOperand = null;
      singleOperand = {
        "operandID": element.operandID,
        "operatorId": element.operatorId,
        "value": doubleQuote + element.value! + doubleQuote
      };
      operandData.add(singleOperand);
    });
    return operandData;
  }

  static getNotificationSubscribers(NotificationSubscribers data) {
    Map<String, dynamic>? notificationSubscribers;
    var email = getStringListData(data.emailIds!);
    var phoneNo = getStringListData(data.phoneNumbers ?? []);
    notificationSubscribers = {"emailIds": email, "phoneNumbers": phoneNo};
    return notificationSubscribers;
  }

  static FilterData onFilterIdleDate(DateRangeType dateRangeType) {
    Logger().d(
        "on asset utilization filter selected ${describeEnum(dateRangeType)}");
    DateTime? fromDate, toDate;
    fromDate = DateUtil.calcFromDate(dateRangeType);
    toDate = DateTime.now();
    Logger().d("from date ${fromDate} to date ${toDate}");
    FilterData data = FilterData(
        title: "Date Range",
        count: describeEnum(dateRangeType),
        extras: [
          '${fromDate!.year}-${fromDate.month}-${fromDate.day}',
          '${toDate.year}-${toDate.month}-${toDate.day}',
          describeEnum(dateRangeType)
        ],
        isSelected: true,
        type: FilterType.DATE_RANGE);
    return data;
  }

  static hoursToPercentCalculate(dynamic value) {
    var data = (value ?? 0.0 / 100);
    if (data > 1.0) {
      data = data / 100;
    }
    return data;
  }

  static efficiencyToPercent(dynamic value) {
    //var data = value / 100;
    return value;
  }

  static List<String?>? getIdlingFilterData(String? value) {
    if (value != null) {
      List<String> data = [];
      switch (value) {
        case "[10,15]":
          data.addAll(["10", "15"]);
          break;
        case "[0,10]":
          data.addAll(["0", "10"]);
          break;
        case "[15,25]":
          data.addAll(["15", "25"]);
          break;
        case "[25,]":
          data.addAll(["25", ""]);
          break;
        default:
      }
      return data;
    } else {
      return null;
    }
  }

  static String getIdlingDateFormat(dynamic value) {
    var data = DateFormat('MM/dd/yyyy').format(value);
    return data;
  }

  static String getIdlingDateParse(dynamic value) {
    var data = DateFormat('yyyy-MM-dd').parse(value);
    var parsedDate = DateFormat('MM/dd/yyyy').format(data);
    return parsedDate;
  }

  static String getIdlingFleetDateParse(dynamic value) {
    var data = DateFormat('yyyy-MM-dd').parse(value);
    //.add(Duration(days: 1));
    var parsedDate = DateFormat('MM/dd/yyyy').format(data);
    return parsedDate;
  }

  static fleetLocationDateFormate(dynamic startDate) {
    var data = DateFormat("yyyy-MM-dd").parse(startDate);
    var formatDate = DateFormat("yyyy-MM-dd").format(data);
    return formatDate;
  }

  static fleetLocationSingleAssetStartDateFormate(dynamic startDate) {
    var data = DateFormat("yyyy-MM-dd")
        .parse(startDate)
        .add(Duration(hours: 0, minutes: 0, seconds: 0));
    var formatDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(data);
    return formatDate;
  }

  static fleetLocationSingleAssetEndDateFormate(dynamic startDate) {
    var data = DateFormat("yyyy-MM-dd")
        .parse(startDate)
        .add(Duration(hours: 23, minutes: 59, seconds: 59));
    var formatDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(data);
    return formatDate;
  }

  static getFaultDateFormatStartDate(DateTime? value) {
    try {
      var parseDate = DateFormat("yyyy-MM-dd").format(value!);

      var inputDate = DateTime.parse(parseDate)
          .add(Duration(hours: 00, seconds: 00, minutes: 00));
      //.subtract(Duration(days: 1));
      Logger().e(inputDate);
      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static getFaultDateFormatEndDate(DateTime? value) {
    try {
      var parseDate = DateFormat("yyyy-MM-dd").format(value!);

      var inputDate = DateTime.parse(parseDate)
          .add(Duration(hours: 23, seconds: 59, minutes: 59));
      //.subtract(Duration(days: 1))

      var outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return "";
    }
  }

  static List<String>? getAssetIdentifier(String? value) {
    if (value!.isEmpty) {
      return null;
    } else {
      List<String> listData = [];
      List<String> formatedList = [];
      var correctedString = value.replaceAll(r'\', r'\\');
      var splitedList = correctedString.split(",");
      splitedList.forEach((element) {
        if (element.contains("[")) {
          var first = element.replaceAll("[", "");
          listData.add(first);
        } else if (element.contains("]")) {
          var last = element.replaceAll("]", "");
          listData.add(last);
        } else {
          listData.add(element);
        }
      });
      listData.forEach((element) {
        String? data;
        if (element.contains("]")) {
          data = element.replaceAll("]", "");
          var assetId = data.replaceAll("\"", "");
          formatedList.add(assetId.trimLeft().trimRight());
        } else if (element.contains("[")) {
          data = element.replaceAll("[", "");
          var assetId = data.replaceAll("\"", "");
          formatedList.add(assetId.trimLeft().trimRight());
        } else {
          data = element;
          var assetId = data.replaceAll("\"", "");
          formatedList.add(assetId.trimLeft().trimRight());
        }
      });
      Logger().i(formatedList);
      return formatedList;
    }
  }

  static String? getAssetIdentifierFromUrl(String? value) {
    var data = value?.split("assetUid=");
    var assetIdentifierList = data![1].split("&");
    Logger().i(assetIdentifierList.first);
    return assetIdentifierList.first;
  }

  static List<String>? getAssetIdentifierForFaultSummaryType(String? value) {
    if (value!.isEmpty) {
      return null;
    } else {
      List<String> formatedList = [];
      List<String> testListData = [];
      List<String> correctedListData = [];
      var data = value.replaceAll(r'\', r'\\');
      var list = data.split("\"assetuids\":");
      var listData = list[1].replaceAll("}", "").split(",");
      listData.forEach((element) {
        if (element.contains("[")) {
          var first = element.replaceAll("[", "");
          testListData.add(first);
        } else if (element.contains("]")) {
          var last = element.replaceAll("]", "");
          testListData.add(last);
        } else {
          testListData.add(element);
        }
      });
      testListData.forEach((element) {
        formatedList.add(element.replaceAll("\"", ""));
      });

      formatedList.forEach((element) {
        if (element.contains("]")) {
          var data = element.replaceAll("]", "");
          correctedListData.add(data);
        } else {
          correctedListData.add(element);
        }
      });

      Logger().i(correctedListData);
      return correctedListData;
    }
  }

  static String? getAssetDropdownValue(String value) {
    if (value == "Asset Operation" || value == "AssetOperation") {
      return "Asset Operation";
    } else if (value == "Fleet Summary" || value == "FleetSummary") {
      return "Fleet Summary";
    } else if (value == "Multi-Asset Utilization" ||
        value == "MultiAssetUtilization") {
      return "Multi-Asset Utilization";
    } else if (value == "Utilization Details" ||
        value == "UtilizationDetails") {
      return "Utilization Details";
    } else if (value == "Fault Code Asset Details" ||
        value == "FaultCodeAssetDetails") {
      return "Fault Code Asset Details";
    } else if (value == "Fault Summary Faults List" ||
        value == "FaultSummaryFaultsList") {
      return "Fault Summary Faults List";
    } else if (value == "MultiAssetExcavatorUsageReport" ||
        value == "Multi-Asset Excavator Usage Report") {
      return "Multi-Asset Excavator Usage Report";
    } else if (value == "BackhoeLoaderOperation") {
      return "BackhoeLoaderOperation";
    } else if (value == "ExcavatorUsage") {
      return "ExcavatorUsage";
    } else if (value == "MultiAssetExcavatorUsage") {
      return "Multi-Asset Excavator Usage";
    } else {
      return null;
    }
  }

  static getImage(String value) {
    switch (value) {
      case "10001":
        return "assets/images/10001.png";
      case "10002":
        return "assets/images/10002.png";
      default:
        return "assets/images/0.png";
    }
  }

  static double parseStringToDouble(String value) {
    return double.parse(value);
  }

  static String dateFormat(String value) {
    var inputDate = DateFormat("yyyy-MM-dd").parse(value);
    return DateFormat("yyyy-MM-dd").format(inputDate);
  }

  static findMaxAndMinvalues(List<AssetResult> data) {
    List<double> minMax = [];
    if (data.any((element) => element.idleEfficiency != null)) {
      data.sort((a, b) {
        return a.idleEfficiency!.compareTo(b.idleEfficiency ?? 0.0);
      });
    }
    Logger().w(data.first.idleEfficiency!);
    Logger().wtf(data.last.idleEfficiency!);
    minMax.addAll([data.first.idleEfficiency!, data.last.idleEfficiency!]);
    return minMax;
  }
  // static getSvcBody(List<String> value) {
  //   List<String> data = [];
  //   value.forEach((element) {
  //     data = element.split("\",\"");
  //   });
  //   data.forEach((element) {
  //     element.replaceAll("", replace);
  //   });
  // }

  static getEstimatedPercentValue(idle, runtime) {
    var data = (runtime / idle) * 100;
    return data;
  }

  static getEstimatedTargetRuntimePercentValue(idle, runtime) {
    var data = (idle / 100) * runtime as double;
    return data.roundToDouble();
  }

  static String tokenExpiresTime(int expireSec) {
    DateTime currentTime = DateTime.now();
    var tokenExpireTime = currentTime.add(Duration(seconds: expireSec));
    Logger().i("Token Valid Upto $tokenExpireTime");
    return tokenExpireTime.toString();
  }

  static List<MaitenanceTotal> getMaintenanceCount(
      List<MaintenanceTotals>? value) {
    List<MaitenanceTotal> maintenanceTotal = [
      MaitenanceTotal(count: 0, total: MAINTENANCETOTAL.UPCOMING),
      MaitenanceTotal(count: 0, total: MAINTENANCETOTAL.OVERDUE)
    ];

    for (var item in value!) {
      if (item.name == "Upcoming" && item.count != 0) {
        maintenanceTotal.first.count = item.count!;
      } else if (item.name == "Overdue" && item.count != 0) {
        maintenanceTotal.last.count = item.count!;
      }
    }
    //Logger().d(maintenanceTotal.length);
    // Logger().d(maintenanceTotal.first);
    // Logger().d(maintenanceTotal.last);
    // return "";
    return maintenanceTotal;
  }

  static List<Map<String, dynamic>>? addMaintenanceIntervals(
      List<MaintenanceCheckList> data) {
    try {
      List<Map<String, dynamic>> checkList = [];

      for (var check in data) {
        Map<String, dynamic> checkData = {
          "checkListName": check.checkName,
          "partList": []
        };
        for (var part in check.partList!) {
          Map<String, dynamic> partsData = {
            "partName": part.partName,
            "partNo": part.partNo,
            "quantity": part.quantiy
          };
          var partList = checkData["partList"] as List<dynamic>;
          partList.add(partsData);
        }
        checkList.add(checkData);
      }
      Logger().w(checkList);
      return checkList;
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  static List<Map<String, dynamic>>? updateMaintenanceIntervals(
      MaintenanceIntervalData? mainInterval) {
    List<Map<String, dynamic>> intervalList = [];
    Map<String, dynamic> data = {
      "intervalID": mainInterval!.intervalId,
      "intervalDescription": mainInterval.intervalDescription!.isEmpty
          ? "\"" + "\""
          : mainInterval.intervalDescription,
      "firstOccurrences": mainInterval.initialOccurence,
      "intervalName": mainInterval.intervalName
    };

    intervalList.add(data);
    Logger().wtf(intervalList.length);
    return intervalList;
  }

  static List<Map<String, dynamic>>? updateMaintenanceCheckList(
      List<MaintenanceCheckList>? data, int intervalId) {
    try {
      List<Map<String, dynamic>> checkList = [];
      if (data != null && data.isNotEmpty) {
        for (var check in data) {
          Map<String, dynamic> checkData = {
            "ChecklistName": check.checkName,
            "partList": []
          };
          for (var part in check.partList!) {
            Map<String, dynamic> partsData = {
              "partName": part.partName,
              "partNo": part.partNo,
              "quantity": part.quantiy,
            };
            var partList = checkData["partList"] as List<dynamic>;
            partList.add(partsData);
          }
          checkList.add(checkData);
        }
        Logger().w(checkList);
        return checkList;
      } else {
        return null;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  static String fuelFilterQuery(String? fuelLevelPercentLt) {
    if (fuelLevelPercentLt == "25") {
      return "0%-25%";
    } else if (fuelLevelPercentLt == "50") {
      return "26%-50%";
    } else if (fuelLevelPercentLt == "75") {
      return "51%-75%";
    } else if (fuelLevelPercentLt == "100") {
      return "76%-100%";
    } else {
      return "";
    }
  }
}
