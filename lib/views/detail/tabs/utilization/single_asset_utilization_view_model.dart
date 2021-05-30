import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class SingleAssetUtilizationViewModel extends InsiteViewModel {
  Logger log;
  var _assetUtilizationService = locator<AssetUtilizationService>();

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  SingleAssetUtilization _singleAssetUtilization;
  SingleAssetUtilization get singleAssetUtilization => _singleAssetUtilization;

  List<AssetResult> _utilLizationList = [];
  List<AssetResult> get utilLizationList => _utilLizationList;

  bool _loading = true;
  bool get loading => _loading;

  // String _startDate =
  //     '${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).year}-${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).month}-${DateTime.now().subtract(Duration(days: DateTime.now().weekday)).day}';
  String _startDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(Duration(days: DateTime.now().weekday)));
  set startDate(String startDate) {
    this._startDate = startDate;
  }

  String get startDate => _startDate;

  // String _endDate =
  //     '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  String _endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  set endDate(String endDate) {
    this._endDate = endDate;
  }

  SingleAssetUtilizationViewModel(AssetDetail detail) {
    this._assetDetail = detail;
    _assetUtilizationService.setUp();
    getSingleAssetUtilization();
    getUtilList();
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
