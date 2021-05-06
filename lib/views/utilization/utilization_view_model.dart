import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/utilization_data.dart';

import 'package:insite/core/services/utilization_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class UtilLizationViewModel extends BaseViewModel {
  Logger log;
  var _utilService = locator<AssetUtilService>();

  List<UtilizationData> _utilLizationList = [];

  List<UtilizationData> get utilLizationList => _utilLizationList;

  bool _loading = true;
  bool get loading => _loading;

  UtilLizationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _utilService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getUtilList();
    });
  }

  getUtilList() async {
    var result = await _utilService.getUtilizationData();
    _utilLizationList = result;

    print('result:$result');

    _loading = false;
    notifyListeners();
  }
}
