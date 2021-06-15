import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationListViewModel extends BaseViewModel {
  Logger log;
  var _assetUtilizationService = locator<AssetUtilizationService>();

  bool _loading = true;
  bool get loading => _loading;

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  List<AssetResult> _utilLizationList = [];
  List<AssetResult> get utilLizationList => _utilLizationList;

  String _startDate;
  set startDate(String startDate) {
    this._startDate = startDate;
  }

  String _endDate;
  set endDate(String endDate) {
    this._endDate = endDate;
  }

  SingleAssetUtilizationListViewModel(
      AssetDetail detail, String start, String end) {
    this._assetDetail = detail;
    this._startDate = start;
    this._endDate = end;
    _assetUtilizationService.setUp();
    getUtilList();
  }

  getUtilList() async {
    Logger().d("getUtilList");
    var result = await _assetUtilizationService.getUtilizationData(
      assetDetail.assetUid,
      _startDate,
      _endDate,
    );
    _utilLizationList = result;
    _loading = false;
    notifyListeners();
  }
}
