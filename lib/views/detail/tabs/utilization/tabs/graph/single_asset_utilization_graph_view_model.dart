import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:logger/logger.dart';

class SingleAssetUtilizationGraphViewModel extends InsiteViewModel {
  Logger log;
  var _assetUtilizationService = locator<AssetUtilizationService>();

  bool _loading = true;
  bool get loading => _loading;

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  SingleAssetUtilization _singleAssetUtilization;
  SingleAssetUtilization get singleAssetUtilization => _singleAssetUtilization;

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

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  SingleAssetUtilizationGraphViewModel(AssetDetail detail) {
    this._assetDetail = detail;
    setUp();
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

  refresh() async {
    _refreshing = true;
    notifyListeners();
    SingleAssetUtilization result =
        await _assetUtilizationService.getSingleAssetUtilizationResult(
      assetDetail.assetUid,
      '-LastReportedUtilizationTime',
      _startDate,
      _endDate,
    );

    if (result != null) {
      _singleAssetUtilization = result;
      _refreshing = false;
      notifyListeners();
    } else {
      _refreshing = false;
      notifyListeners();
    }
  }
}
