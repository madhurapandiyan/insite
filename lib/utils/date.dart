import 'package:insite/views/preference/model/time_zone.dart';

import 'enums.dart';
import 'package:timezone/timezone.dart' as tzo;
import 'package:timezone/data/latest_all.dart' as tz;

class DateUtil {
  static DateTime? calcFromDate(DateRangeType defaultDateRange) {
    switch (defaultDateRange) {
      case DateRangeType.today:
        return DateTime.now();
      case DateRangeType.yesterday:
        return (DateTime.now().subtract(Duration(days: 1)));
      case DateRangeType.currentWeek:
        return (DateTime.now()
            .subtract(Duration(days: DateTime.now().weekday - 1)));
      case DateRangeType.lastSevenDays:
        return (DateTime.now().subtract(Duration(days: 6)));
      case DateRangeType.lastThirtyDays:
        return (DateTime.now().subtract(Duration(days: 29)));
      case DateRangeType.currentMonth:
        return (DateTime.utc(DateTime.now().year, DateTime.now().month, 1));
      default:
        return null;
    }
  }

  static bool isBothDateSame(DateTime one, DateTime two) {
    if (one.year == two.year && one.month == two.month && one.day == two.day) {
      return true;
    } else {
      return false;
    }
  }

  static DateTime? calcDateFromZone(
      DateRangeType defaultDateRange, UserPreferedData? prefData) {
    tz.initializeTimeZones();
    final location = tzo.getLocation(prefData!.zone!.momentTimezone);
    switch (defaultDateRange) {
      case DateRangeType.today:
        return tzo.TZDateTime.now(location);
      case DateRangeType.yesterday:
        return (tzo.TZDateTime.now(location).subtract(Duration(days: 1)));
      case DateRangeType.currentWeek:
        return (tzo.TZDateTime.now(location).subtract(
            Duration(days: tzo.TZDateTime.now(location).weekday - 1)));
      case DateRangeType.lastSevenDays:
        return (tzo.TZDateTime.now(location).subtract(Duration(days: 6)));
      case DateRangeType.lastThirtyDays:
        return (tzo.TZDateTime.now(location).subtract(Duration(days: 29)));
      case DateRangeType.currentMonth:
        return (DateTime.utc(
            tzo.TZDateTime.now(location).year, DateTime.now().month, 1));
      default:
        return null;
    }
  }
  static DateTime? calcIdlingFromDate(DateRangeType defaultDateRange) {
    switch (defaultDateRange) {
      case DateRangeType.today:
        return DateTime.now();
      case DateRangeType.yesterday:
        return (DateTime.now().subtract(Duration(days: 1)));
      case DateRangeType.currentWeek:
        return (DateTime.now()
            .subtract(Duration(days: DateTime.now().weekday )));
      case DateRangeType.lastSevenDays:
        return (DateTime.now().subtract(Duration(days: 6)));
      case DateRangeType.lastThirtyDays:
        return (DateTime.now().subtract(Duration(days: 29)));
      case DateRangeType.currentMonth:
        return (DateTime.utc(DateTime.now().year, DateTime.now().month, 1));
      default:
        return null;
    }
  }
}
