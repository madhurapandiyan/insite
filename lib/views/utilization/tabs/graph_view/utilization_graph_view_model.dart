import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/utils/enums.dart';

import 'package:logger/logger.dart';

class UtilizationGraphViewModel extends InsiteViewModel {
  Logger? log;

  UtilizationGraphViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetService!.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetCount();
    });
  }
  AssetStatusService? _assetService = locator<AssetStatusService>();

  int _totalCount = 0;
  int get totalCount => _totalCount;

  int _count = 0;
  int get count => _count;

  getAssetCount() async {
    await getDateRangeFilterData();
    await getSelectedFilterData();
    // Logger().d("getAssetCount");
    // AssetCount? result = await _assetService!.getAssetCount(
    //     null, FilterType.ASSET_STATUS, graphqlSchemaService!.assetStatusCount);
    // if (result != null) {
    //   if (result.countData!.isNotEmpty && result.countData![0].count != null) {
    //     _totalCount = result.countData![0].count!.toInt();
    //   }
    //   Logger().d("result ${result.countData?.first.toJson()}");
    // }
    // _count = 0;
    // notifyListeners();
    Logger().d("getUtilizationCount");
    AssetCount? assetCount = await _assetService!.getAssetCountByFilter(
        startDate,
        endDate,
        "-RuntimeHours",
        ScreenType.UTILIZATION,
        appliedFilters,
        graphqlSchemaService!.utilizationToatlCount(startDate!, endDate!));
    if (assetCount != null) {
      if (assetCount.countData!.isNotEmpty &&
          assetCount.countData![0].count != null) {
        _totalCount = assetCount.countData![0].count!.toInt();
      }
      Logger().wtf("result ${assetCount.toJson()}");
    }
    notifyListeners();
  }

  updateDateView() async {
    Logger().d("updateDateView");
    await getDateRangeFilterData();
    notifyListeners();
  }

  updateCurrentCount(value) {
    _count = value;
    notifyListeners();
  }
}
