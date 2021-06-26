import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/repository/db.dart';
import 'package:logger/logger.dart';

class DateRangeService extends DataBaseService {
  Future<List<String>> getDateRangeFilters() async {
    try {
      int size = await box.values.length;
      Logger().d("getDateRangeFilters " + size.toString());
      if (size > 0) {
        int index = -1;
        for (var i = 0; i <= size; i++) {
          FilterData data = box.getAt(i);
          if (data.type == FilterType.DATE_RANGE) {
            print("matching date filter " + data.title.toString());
            index = i;
            break;
          }
        }
        FilterData filterData = await box.getAt(index);
        return filterData.extras;
      }
      return [];
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  updateDateFilter(FilterData value) async {
    int size = box.values.length;
    if (size == 0) {
      box.add(value);
    } else {
      bool shouldUpdate = false;
      int index = -1;
      for (var i = 0; i < size; i++) {
        FilterData data = box.getAt(i);
        if (data.type == value.type) {
          shouldUpdate = true;
          index = i;
          return;
        }
      }
      if (shouldUpdate) {
        print("update date filter index and value" +
            index.toString() +
            " " +
            value.title.toString());
        await box.putAt(index, value);
      } else {
        print("add date filter and value" + value.title.toString());
        await box.add(value);
      }
    }
  }
}
