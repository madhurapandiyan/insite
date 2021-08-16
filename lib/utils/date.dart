import 'enums.dart';

class DateUtil {
  static DateTime calcFromDate(DateRangeType defaultDateRange) {
    switch (defaultDateRange) {
      case DateRangeType.today:
        return DateTime.now();
        break;
      case DateRangeType.yesterday:
        return (DateTime.now().subtract(Duration(days: 1)));
        break;
      case DateRangeType.currentWeek:
        return (DateTime.now()
            .subtract(Duration(days: DateTime.now().weekday - 1)));
        break;
      case DateRangeType.lastSevenDays:
        return (DateTime.now().subtract(Duration(days: 6)));
        break;
      case DateRangeType.lastThirtyDays:
        return (DateTime.now().subtract(Duration(days: 29)));
        break;
      case DateRangeType.currentMonth:
        return (DateTime.utc(DateTime.now().year, DateTime.now().month, 1));
        break;
      default:
        return null;
        break;
    }
  }
}
