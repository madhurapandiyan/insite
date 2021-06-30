import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:logger/logger.dart';

class SingleAssetUtilizationListViewModel extends InsiteViewModel {
  Logger log;
  var _assetUtilizationService = locator<AssetUtilizationService>();

  bool _loading = true;
  bool get loading => _loading;

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  List<AssetResult> _utilLizationList = [];
  List<AssetResult> get utilLizationList => _utilLizationList;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  SingleAssetUtilizationListViewModel(AssetDetail detail) {
    this._assetDetail = detail;
    setUp();
    _assetUtilizationService.setUp();
    getUtilList();
  }

  getUtilList() async {
    Logger().d("getUtilList");
    await getDateRangeFilterData();
    var result = await _assetUtilizationService.getUtilizationData(
      assetDetail.assetUid,
      startDate,
      endDate,
    );
    _utilLizationList = result;
    _loading = false;
    notifyListeners();
  }

  refresh() async {
    await getDateRangeFilterData();
    _refreshing = true;
    notifyListeners();
    var result = await _assetUtilizationService.getUtilizationData(
      assetDetail.assetUid,
      startDate,
      endDate,
    );
    if (result != null) {
      _utilLizationList.clear();
      _utilLizationList.addAll(result);
      _refreshing = false;
      notifyListeners();
    } else {
      _refreshing = false;
      notifyListeners();
    }
  }
}
