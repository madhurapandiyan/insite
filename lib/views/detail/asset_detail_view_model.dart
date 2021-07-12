import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/services/asset_service.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class AssetDetailViewModel extends InsiteViewModel {
  var _assetService = locator<AssetService>();
  Logger log;
  Fleet fleet;
  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;
  bool _loading = true;
  bool get loading => _loading;

  AssetDetailViewModel(this.fleet) {
    this.log = getLogger(this.runtimeType.toString());
    setUp();
    _assetService.setUp();
    try {
      Logger().i("asset choosen assetSerialNumber " + fleet.assetSerialNumber);
      Logger().i("asset choosen assetIdentifier " + fleet.assetIdentifier);
      Logger().i("asset choosen assetId " + fleet.assetId);
    } catch (e) {
      Logger().e(e);
    }
    Future.delayed(Duration(seconds: 1), () {
      getAssetDetail();
    });
  }

  getAssetDetail() async {
    AssetDetail assetDetail =
        await _assetService.getAssetDetail(fleet.assetIdentifier);
    _assetDetail = assetDetail;
    _loading = false;
    notifyListeners();
  }
}
