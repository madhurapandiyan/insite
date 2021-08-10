import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class Utils {
  static String getLastReportedDate(date) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getLastReportedDateOne(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getLastReportedDateTwo(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getLastReportedDateUTC(date) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getLastReportedDateOneUTC(date) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true);
    var inputDate = DateTime.parse(parseDate.toLocal().toString());
    var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getLastReportedDateOneLocalUTC(date) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String formatCurrentSystemTime(date) {
    Logger().d("formatCurrentSystemTime $date");
    DateTime parseDate = new DateFormat("yyyy-MM-dd HH:mm:ss.zzzz").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
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
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getLastDurationOne(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getLastReportedTime(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm").parse(date, true);
    var inputDate = DateTime.parse(parseDate.toLocal().toString());
    var outputFormat = DateFormat('hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
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
    if (title == "100") {
      title = "<=" + title + "%";
    } else {
      title = "<" + title + "%";
    }
    if (isForFilter) {
      return "Fuel Level : " + title;
    } else {
      return title;
    }
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
            : text.toLowerCase() == "green" || text.toLowerCase() == "medium"
                ? Colors.green
                : text.toLowerCase() == "yellow" || text.toLowerCase() == "low"
                    ? Colors.yellow
                    : buttonColorFive
        : buttonColorFive;
  }

  static String getMakeTitle(String text) {
    if (text.toLowerCase() == "thc") {
      return "TATA HITACHI";
    } else {
      return text;
    }
  }
}
