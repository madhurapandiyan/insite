import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';

class SingleAssetUtilizationGraphViewModel extends InsiteViewModel {
  Logger? log;
  AssetUtilizationService? _assetUtilizationService =
      locator<AssetUtilizationService>();

  bool _loading = true;
  bool get loading => _loading;

  AssetDetail? _assetDetail;
  AssetDetail? get assetDetail => _assetDetail;

  SingleAssetUtilization? _singleAssetUtilization;
  SingleAssetUtilization? get singleAssetUtilization => _singleAssetUtilization;
  double? idleDay;
  double? idleWeek;
  double? idleMonth;
  List<double?> listIdleDay = [];
  List<double?> listWeekDay = [];
  List<double?> listMonthDay = [];

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  SingleAssetUtilizationGraphViewModel(AssetDetail? detail) {
    this._assetDetail = detail;
    setUp();
    _assetUtilizationService!.setUp();
    getSingleAssetUtilization();
  }

  getSingleAssetUtilization() async {
    Logger().d("getSingleAssetUtilization");
    SingleAssetUtilization? result =
        await _assetUtilizationService!.getSingleAssetUtilizationResult(
      assetDetail!.assetUid,
      '-LastReportedUtilizationTime',
      startDate,
      endDate,
    );
    if (result != null) {
      _singleAssetUtilization = result;
      for (Range data in _singleAssetUtilization!.daily!) {
        //listIdleDay.add(Utils.parseStringToDouble(data.data!.idleHours!));
        listWeekDay.add(data.data!.idleHours.runtimeType == String
            ? Utils.parseStringToDouble(data.data!.idleHours!)
            : data.data!.idleHours);
      }
      for (Range data in _singleAssetUtilization!.weekly!) {
        Logger().w(data.data!.idleHours!.runtimeType);
        //listWeekDay.add(Utils.parseStringToDouble(data.data!.idleHours!));
        listWeekDay.add(data.data!.idleHours!);
      }
      for (Range data in _singleAssetUtilization!.monthly!) {
        // listMonthDay.add(Utils.parseStringToDouble(data.data!.idleHours!));
        listWeekDay.add(data.data!.idleHours!);
      }
      Logger().d("listIdleDay ${listIdleDay.length}");
      Logger().d("listWeekDay ${listWeekDay.length}");
      Logger().d("listMonthDay ${listMonthDay.length}");
    }
    _loading = false;
    notifyListeners();
  }

  refresh() async {
    Logger().d("refresh getSingleAssetUtilization");
    await getDateRangeFilterData();
    _refreshing = true;
    notifyListeners();
    SingleAssetUtilization? result =
        await _assetUtilizationService!.getSingleAssetUtilizationResult(
      assetDetail!.assetUid,
      '-LastReportedUtilizationTime',
      startDate,
      endDate,
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
