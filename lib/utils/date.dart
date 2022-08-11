import 'enums.dart';

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
        return (DateTime.now().subtract(Duration(days: 30)));
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
}
