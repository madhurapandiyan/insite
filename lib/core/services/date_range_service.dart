import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/repository/db.dart';
import 'package:logger/logger.dart';

class DateRangeService extends DataBaseService {
  Future<List<String?>?> getDateRangeFilters() async {
    try {
      int size = await filterBox.values.length;
      Logger().d("getDateRangeFilters " + size.toString());
      if (size > 0) {
        int index = -1;
        for (var i = 0; i < size; i++) {
          FilterData data = filterBox.getAt(i);
          if (data.type == FilterType.DATE_RANGE) {
            print("matching date filter " + data.title.toString());
            index = i;
            break;
          }
        }
        if (index != -1) {
          FilterData filterData = await filterBox.getAt(index);
          return filterData.extras;
        }
        return [];
      }
      return [];
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  updateDateFilter(FilterData value) async {
    int? size = filterBox.values.length;
    if (size == 0) {
      filterBox.add(value);
    } else {
      bool shouldUpdate = false;
      int index = -1;
      for (var i = 0; i < size!; i++) {
        FilterData data = filterBox.getAt(i);
        if (data.type == value.type) {
          shouldUpdate = true;
          index = i;
          break;
        }
      }
      if (shouldUpdate) {
        print("update date filter index and value" +
            index.toString() +
            " " +
            value.title.toString());
        await filterBox.putAt(index, value);
      } else {
        print("add date filter and value" + value.title.toString());
        await filterBox.add(value);
      }
    }
  }
}
