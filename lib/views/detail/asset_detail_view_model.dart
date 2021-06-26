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
    _assetService.setUp();
    setUp();
    Logger().i("asset choosen " + fleet.assetSerialNumber);
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
