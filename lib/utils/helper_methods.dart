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
}
