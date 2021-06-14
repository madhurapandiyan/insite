import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationGraphViewModel extends BaseViewModel {
  Logger log;
  var _assetUtilizationService = locator<AssetUtilizationService>();

  bool _loading = true;
  bool get loading => _loading;

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  SingleAssetUtilization _singleAssetUtilization;
  SingleAssetUtilization get singleAssetUtilization => _singleAssetUtilization;

  String _startDate;
  set startDate(String startDate) {
    this._startDate = startDate;
  }

  String _endDate;
  set endDate(String endDate) {
    this._endDate = endDate;
  }

  SingleAssetUtilizationGraphViewModel(
      AssetDetail detail, String start, String end) {
    this._assetDetail = detail;
    this._startDate = start;
    this._endDate = end;
    _assetUtilizationService.setUp();
    getSingleAssetUtilization();
  }

  getSingleAssetUtilization() async {
    Logger().d("getSingleAssetUtilization");
    SingleAssetUtilization result =
        await _assetUtilizationService.getSingleAssetUtilizationResult(
      assetDetail.assetUid,
      '-LastReportedUtilizationTime',
      _startDate,
      _endDate,
    );
    _singleAssetUtilization = result;
    _loading = false;
    notifyListeners();
  }
}
