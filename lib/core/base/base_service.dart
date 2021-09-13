import 'package:insite/core/models/filter_data.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';

import '../logger.dart';

class BaseService {
  Logger log;
  String packageName;
  BaseService({String title}) {
    log = getLogger(title ?? this.runtimeType.toString());
    PackageInfo.fromPlatform().then(
        (PackageInfo packageInfo) => {packageName = packageInfo.packageName});
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
