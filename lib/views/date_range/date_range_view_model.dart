import 'dart:async';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/date_range_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class DateRangeViewModel extends BaseViewModel {
  DateRangeService? _dateRangeService = locator<DateRangeService>();

  String? _startDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(Duration(days: DateTime.now().weekday)));
  set startDate(String? startDate) {
    this._startDate = startDate;
  }

  String? get startDate => _startDate;

  String? _endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  set endDate(String? endDate) {
    this._endDate = endDate;
  }

  String? get endDate => _endDate;

  DateRangeType get selectedDateRange => _selectedDateRange;

  DateRangeType _selectedDateRange = DateRangeType.currentWeek;
  set selectedDateRange(DateRangeType value) {
    this._selectedDateRange = value;
  }

  DateRangeType _dateType = DateRangeType.currentWeek;
  set dateType(DateRangeType dateType) {
    this._dateType = dateType;
  }

  DateRangeType get dateType => _dateType;

  DateRangeViewModel() {
    _dateRangeService?.setUp();
    getDateRangeFilterData();
  }

  updateDateRange(String? startDate, String? endDate, String? type) async {
    Logger().d("updateDateRange start date, end date, type",
        startDate! + " " + endDate! + " " + type!);
    FilterData data = FilterData(
        title: "Date Range",
        count: type,
        extras: [startDate, endDate, type],
        isSelected: true,
        type: FilterType.DATE_RANGE);
    await _dateRangeService!.updateDateFilter(data);
  }

  getDateRangeFilterData() async {
    Logger().d("getDateRangeFilterData");
    List<String?>? appliedFilters =
        await _dateRangeService?.getDateRangeFilters();
    Logger().d(appliedFilters?.length.toString());
    if (appliedFilters != null && appliedFilters.isNotEmpty) {
      startDate = appliedFilters[0];
      endDate = appliedFilters[1];
      Logger().d("start ", startDate);
      Logger().d("start ", endDate);
      Logger().d("label ", appliedFilters[2]);
      _selectedDateRange = getType(appliedFilters[2]);
      notifyListeners();
    } else {
      startDate = DateFormat('yyyy-MM-dd').format(
          DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)));
      endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  DateRangeType getType(value) {
    DateRangeType type = DateRangeType.currentWeek;
    Logger().e(value);
    switch (value) {
      case "currentMonth":
        type = DateRangeType.currentMonth;
        break;
      case "currentWeek":
        type = DateRangeType.currentWeek;
        break;
      case "custom":
        type = DateRangeType.custom;
        break;
      case "lastSevenDays":
        type = DateRangeType.lastSevenDays;
        break;
      case "lastThirtyDays":
        type = DateRangeType.lastThirtyDays;
        break;
      case "previousWeek":
        type = DateRangeType.previousWeek;
        break;
      case "today":
        type = DateRangeType.today;
        break;
      case "yesterday":
        type = DateRangeType.yesterday;
        break;
      case "previousMonth":
        type = DateRangeType.previousMonth;
        break;
      default:
    }
    return type;
  }
}
