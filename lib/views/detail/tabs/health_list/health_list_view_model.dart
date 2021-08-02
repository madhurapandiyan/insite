import 'package:insite/core/locator.dart';
import 'package:insite/core/models/health_list_response.dart';

import 'package:insite/core/services/health_list_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class HealthListViewModel extends BaseViewModel {
  Logger log;
  var _healthListService = locator<HealthListService>();

  List<Fault> _faults=[];
  List<Fault> get faults=>_faults;

 

  bool _healthListDataLoding = true;
  bool get healthListDataLoading => _healthListDataLoding;

  HealthListViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _healthListService.setUp();
   Future.delayed(Duration(seconds: 1), () {
     getHealthListData();
    });
  }

  getHealthListData() async {
    HealthListResponse result = await _healthListService.getHealthListData();
    _faults = result.assetData.faults;
    _healthListDataLoding = false;
    notifyListeners();
  }
}
