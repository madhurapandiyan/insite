import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Utils {
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
      int mins = ((s / 60) % 60).toInt();
      int hours = ((s / 60) / 60).toInt();
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

  static String getFuleLevelWidgetLabel(data, isForFilter) {
    String title = data;
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
      return "25-50%";
    } else if (title == "75") {
      return "50-75%";
    } else if (title == "100") {
      return "75-100%";
    } else {
      return title;
    }
  }

  static String getPageTitle(ScreenType type) {
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
        title = "OPERATION";
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
      case ScreenType.NOTIFICATION:
        title = "NOTIFICATION";
        break;
      case ScreenType.HOME:
        title = "HOME";
        break;
      case ScreenType.USER_MANAGEMENT:
        title = "USER";
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
        title = "ADD NEW GROUPS";
        break;
      case AdminAssetsButtonType.MANAGEGROUPS:
        title = "MANAGER NEW GROUPS";
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

      default:
    }
    return title;
  }

  static String generateCodeChallenge(String codeVerifier) {
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

  static String getTitle(FilterType type) {
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
      default:
    }
    return title;
  }

  static double getDecimalFromTime(DateTime input) {
    int totalSeconds = (input.minute * 60) + input.second;
    double rep = totalSeconds / 3600;
    return (input.hour + rep);
  }

  static String getFilterTitleForChipView(FilterData data) {
    String title = data.title;
    if (data.type == FilterType.DATE_RANGE) {
      title = "Date " +
          "(" +
          getDateInFormatddMMyyyy(data.extras[0]) +
          " - " +
          getDateInFormatddMMyyyy(data.extras[1]) +
          ")";
    } else if (data.type == FilterType.IDLING_LEVEL) {
      if (data.extras[1].isEmpty) {
        title = "Idle %: " + ">" + data.extras[0] + "%";
      } else {
        title = "Idle %: " + data.extras[0] + "-" + data.extras[1] + "%";
      }
    } else if (data.type == FilterType.FUEL_LEVEL) {
      if (title == "100") {
        title = "Fuel Level : " + "<=" + title + "%";
      } else {
        title = "Fuel Level : " + "<" + title + "%";
      }
    } else if (data.type == FilterType.SEVERITY) {
      title = Utils.getFaultLabel(data.title);
    }
    return title;
  }

  static String getFilterTitleForList(FilterData data) {
    String title = data.title;
    if (data.type == FilterType.DATE_RANGE) {
      title = "Date " + data.extras[0] + " " + data.extras[1];
    } else if (data.type == FilterType.IDLING_LEVEL) {
      if (data.extras[1].isEmpty) {
        title = ">" + data.extras[0] + "%";
      } else {
        title = data.extras[0] + "-" + data.extras[1] + "%";
      }
    } else if (data.type == FilterType.FUEL_LEVEL) {
      title = getFuleLevelWidgetLabel(title, true);
    } else if (data.type == FilterType.SEVERITY) {
      title = Utils.getFaultLabel(data.title);
    }
    return title;
  }

  static DateTime getMinDate(List<DateTime> inputDates) {
    DateTime minDate;
    for (DateTime item in inputDates) {
      if (minDate == null)
        minDate = item;
      else if (item.isBefore(minDate)) minDate = item;
    }
    return minDate;
  }

  static DateTime getMaxDate(List<DateTime> inputDates) {
    DateTime maxDate;
    for (DateTime item in inputDates) {
      if (maxDate == null)
        maxDate = item;
      else if (item.isAfter(maxDate)) maxDate = item;
    }
    return maxDate;
  }

  imageData(String model) {
    if (model.contains("SHINRAI")) {
      return "assets/images/shinrai.png";
    } else if (model.contains("EX130")) {
      return "assets/images/EX130.png";
    } else if (model.contains("EX210")) {
      return "assets/images/EX210.png";
    } else if (model.contains("EX210LC")) {
      return "assets/images/EX210LC.png";
    } else if (model.contains("TH86")) {
      return "assets/images/TH86.png";
    } else if (model.contains("TL340H")) {
      return "assets/images/TL340H.png";
    } else {
      return "assets/images/EX210.png";
    }
  }

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

  static double checkNull(double value) {
    return value == null ? 0.0 : value;
  }

  static double greatestOfThree(double a, double b, double c) {
    return (a > b) ? (a > c ? a : c) : (b > c ? b : c);
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
}
