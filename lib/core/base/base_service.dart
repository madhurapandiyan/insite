import 'package:insite/core/models/filter_data.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';

import '../logger.dart';

class BaseService {
  Logger log;
  bool isVisionLink = false;
  BaseService({String title}) {
    log = getLogger(title ?? this.runtimeType.toString());
    try {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) => {
            if ("com.trimble.insite.visionlink" == packageInfo.packageName ||
                "com.trimble.insite.trimble" == packageInfo.packageName)
              {isVisionLink = true}
          });
    } catch (e) {}
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
