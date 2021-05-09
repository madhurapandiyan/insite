import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:intl/intl.dart';

class AssetListViewModel extends InsiteViewModel {
  var _assetService = locator<AssetService>();
  List<Asset> _assets = [];
  List<Asset> get assets => _assets;

  bool _loading = true;
  bool get loading => _loading;

  AssetListViewModel() {
    _assetService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetSummaryList();
    });
  }

  getAssetSummaryList() async {
    DateTime current = DateTime.now().toLocal();
    DateTime previous = DateTime.now().toLocal().subtract(Duration(days: 30));
    String endDate = DateFormat("y-MM-dd").format(current);
    String start = DateFormat("y-MM-dd").format(previous);
    List<Asset> result =
        await _assetService.getAssetSummaryList(start, endDate);
    _assets = result;
    _loading = false;
    notifyListeners();
  }
}
