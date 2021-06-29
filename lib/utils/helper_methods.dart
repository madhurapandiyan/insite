import 'package:insite/core/models/filter_data.dart';
import 'package:intl/intl.dart';

class Utils {
  static String getLastReportedDate(date) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getLastReportedDateOne(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getLastDuration(date) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getLastReportedDateFleet(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String parseDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
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
        title = "SUBSCRIPTION DATE";
        break;
      case FilterType.DEVICE_TYPE:
        title = "DEVICE TYPE";
        break;
      case FilterType.ALL_ASSETS:
        title = "ALL ASSETS";
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
    if (data.type == FilterType.IDLING_LEVEL) {
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
    if (data.type == FilterType.IDLING_LEVEL) {
      if (data.extras[1].isEmpty) {
        title = ">" + data.extras[0] + "%";
      } else {
        title = data.extras[0] + "-" + data.extras[1] + "%";
      }
    } else if (data.type == FilterType.FUEL_LEVEL) {
      if (title == "100") {
        title = "<=" + title + "%";
      } else {
        title = "<" + title + "%";
      }
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
}
