import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/repository/db.dart';
import 'package:logger/logger.dart';

class FilterService extends DataBaseService {
  clearFromSelectedFilter() {}

  Future clearFilterDatabase() async {
    try {
      return await filterBox.clear();
    } catch (e) {
      Logger().e("clearFilterDatabase $e");
    }
  }

  //removes filters of particular type
  clearFilterOfTypeInDb(FilterType type) async {
    try {
      int size = filterBox.values.length;
      print("filter size before clear");
      print(filterBox.values.length);
      print("FilterType " + type.toString());
      for (var i = 0; i < size; i++) {
        FilterData data = filterBox.getAt(i);
        Logger().d("current filter data on loop ", data);
        if (data.type == type) {
          await filterBox.deleteAt(i);
        }
      }
      print("filter size after clear");
      print(filterBox.values.length);
    } catch (e) {
      Logger().e(e);
    }
  }

  updateFilterInDb(List<FilterData> list) {
    try {
      Logger().d("updateFilterInDb list size ${list.length}");
      clearFilterDatabase().then((value) => {
            for (FilterData data in list) {addFilter(data)}
          });
      Logger().d("filter size after update");
      print(filterBox.values.length);
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<List<FilterData>> getSelectedFilters() async {
    try {
      Logger().d("getSelectedFilters");
      print(filterBox.values.length);
      return await filterBox.values.toList();
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  //removes a particular filter
  removeFilter(FilterData value) {
    try {
      int size = filterBox.values.length;
      Logger().d("removeFilter service " + size.toString());
      if (size > 0) {
        for (var i = 0; i < size; i++) {
          FilterData data = filterBox.getAt(i);
          Logger().d("current filter data on loop ", data);
          if (data.title == value.title && data.type == value.type) {
            Logger().d("delete filter ${data.title.toString()}");
            filterBox.deleteAt(i);
            break;
          }
        }
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  addFilter(FilterData value) async {
    int size = filterBox.values.length;
    if (size == 0) {
      filterBox.add(value);
    } else {
      bool shouldAdd = true;
      for (var i = 0; i < size; i++) {
        FilterData data = filterBox.getAt(i);
        if (data.title == value.title) {
          shouldAdd = false;
          break;
        }
      }
      if (shouldAdd) {
        Logger().d("add filter ${value.title.toString()}");
        await filterBox.add(value);
      }
    }
  }

  updateFilter(FilterData value) async {
    int size = filterBox.values.length;
    if (size == 0) {
      filterBox.add(value);
    } else {
      bool shouldUpdate = false;
      int index = 0;
      for (var i = 0; i < size; i++) {
        FilterData data = filterBox.getAt(i);
        if (data.title == value.title) {
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
