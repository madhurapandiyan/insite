import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:logger/logger.dart';

import '../logger.dart';

class BaseService {
  Logger? log;
  bool isVisionLink = false;
  bool enableGraphQl = false;

  BaseService({String? title}) {
   
    log = getLogger(title ?? this.runtimeType.toString());
    try {
      if (AppConfig.instance!.apiFlavor == "visionlink") {
        isVisionLink = true;
      }
      if (AppConfig.instance!.enableGraphql == true) {
         Logger().i("flavor");
        enableGraphQl = true;
      }

      // PackageInfo.fromPlatform().then((PackageInfo packageInfo) => {
      //       if ("com.trimble.insite.visionlink" == packageInfo.packageName ||
      //           "com.trimble.insite.trimble" == packageInfo.packageName)
      //         {isVisionLink = true}
      //     });
    } catch (e) {}
  }

  String convertFilterToCommaSeparatedString(List<FilterData> appliedFilters) {
    List<String?> stringList = [];
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
