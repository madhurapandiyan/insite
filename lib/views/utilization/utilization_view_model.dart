import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/models/utilization_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_utilization_service.dart';

import 'package:insite/core/services/utilization_service.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class UtilLizationViewModel extends InsiteViewModel {
  Logger log;
  var _utilService = locator<AssetUtilService>();
  var _utilizationService = locator<AssetUtilizationService>();
  var _navigationService = locator<NavigationService>();

  List<UtilizationData> _utilLizationList = [];
  List<UtilizationData> get utilLizationList => _utilLizationList;
  int pageNumber = 1;
  int pageCount = 50;
  Utilization _utilization;
  Utilization get utilization => _utilization;

  List<AssetResult> _utilLizationListData = [];
  List<AssetResult> get utilLizationListData => _utilLizationListData;

  bool _isMain = false;
  bool get isMain => _isMain;

  String _startDate =
      '${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).month}/${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).day}/${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).year}';
  set startDate(String startDate) {
    this._startDate = startDate;
  }

  String _endDate =
      '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';
  set endDate(String endDate) {
    this._endDate = endDate;
  }

  bool _loading = true;
  bool get loading => _loading;

  UtilLizationViewModel(value) {
    _isMain = value;
    this.log = getLogger(this.runtimeType.toString());
    _utilService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getUtilization();
      getUtilList();
    });
  }

  getUtilList() async {
    var result = await _utilService.getUtilizationData();
    _utilLizationList = result;
    print('result:$result');
  }

  getUtilization() async {
    Utilization result = await _utilizationService.getUtilizationResult(
        _startDate, _endDate, '-RuntimeHours');
    _utilLizationListData = result.assetResults;
    _loading = false;
    notifyListeners();
  }

  onDetailPageSelected(AssetResult fleet) {
    _navigationService.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
            fleet: Fleet(
                assetSerialNumber: fleet.assetSerialNumber,
                assetId: fleet.assetIdentifierSqluid,
                assetIdentifier: fleet.assetIdentifier)));
  }
}
