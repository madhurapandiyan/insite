import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class AssetDashboardViewModel extends BaseViewModel {
  Logger log;
  var _assetSingleHistoryService = locator<AssetService>();
  AssetDetail _assetDetail;

  AssetDetail get assetDetail => _assetDetail;
  bool _loading = true;
  bool get loading => _loading;

  AssetDashboardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetSingleHistoryService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetLocationHistory();
    });
  }

  getAssetLocationHistory() async {
    AssetDetail result = await _assetSingleHistoryService
        .getAssetDetail("64be6463-d8c1-11e7-80fc-065f15eda309");

    _assetDetail = result;
    print('result:$result');

    _loading = false;
    notifyListeners();
  }
}
