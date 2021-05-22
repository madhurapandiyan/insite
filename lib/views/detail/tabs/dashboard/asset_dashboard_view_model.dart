import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/asset_utilization.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:logger/logger.dart';

class AssetDashboardViewModel extends InsiteViewModel {
  Logger log;
  var _assetSingleHistoryService = locator<AssetService>();
  var _assetUtilizationService = locator<AssetUtilizationService>();

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  AssetUtilization _assetUtilization;
  AssetUtilization get assetUtilization => _assetUtilization;

  bool _loading = true;
  bool get loading => _loading;

  AssetDashboardViewModel(AssetDetail detail) {
    this._assetDetail = detail;
    this.log = getLogger(this.runtimeType.toString());
    _assetSingleHistoryService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetLocationHistory();
      getAssetUtilData();
    });
  }

  getAssetUtilData() async {
    AssetUtilization result = await _assetUtilizationService.getAssetUtilGraphDate(
        assetDetail.assetUid,
        '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}');
    _assetUtilization = result;
    notifyListeners();
  }

  getAssetLocationHistory() async {
    AssetDetail result =
        await _assetSingleHistoryService.getAssetDetail(assetDetail.assetUid);
    _assetDetail = result;
    _loading = false;
    notifyListeners();
  }
}
