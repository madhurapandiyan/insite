import 'package:insite/core/models/filter_data.dart';
import 'package:logger/logger.dart';

import '../logger.dart';

class BaseService {
  Logger log;
  BaseService({String title}) {
    log = getLogger(title ?? this.runtimeType.toString());
  }

  String convertFilterToCommaSeparatedString(List<FilterData> appliedFilters) {
    List<String> stringList = [];
    for (FilterData data in appliedFilters) {
      stringList.add(data.title);
    }
    return stringList.join(",");
  }

  String constructQuery(key, value, isFirst) {
    if (isFirst) {
      return "?" + key + "=" + value;
    } else {
      return "&" + key + "=" + value;
    }
  }
}
