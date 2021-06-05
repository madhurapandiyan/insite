import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/cumulative.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/core/models/utilization_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:insite/core/services/utilization_graphs.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class UtilLizationViewModel extends InsiteViewModel {
  Logger log;
  var _utilizationService = locator<AssetUtilizationService>();
  var _navigationService = locator<NavigationService>();
  var _utilizationGraphService = locator<UtilizationGraphsService>();

  List<UtilizationData> _utilLizationList = [];
  List<UtilizationData> get utilLizationList => _utilLizationList;

  RunTimeCumulative _runTimeCumulative;
  RunTimeCumulative get runTimeCumulative => _runTimeCumulative;

  FuelBurnedCumulative _fuelBurnedCumulative;
  FuelBurnedCumulative get fuelBurnedCumulative => _fuelBurnedCumulative;

  int pageNumber = 1;
  int pageCount = 50;
  ScrollController scrollController;

  List<AssetResult> _utilLizationListData = [];
  List<AssetResult> get utilLizationListData => _utilLizationListData;

  bool _isMain = false;
  bool get isMain => _isMain;

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

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  UtilLizationViewModel(value) {
    _isMain = value;
    this.log = getLogger(this.runtimeType.toString());
    _utilizationService.setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      getUtilization();
    });
  }

  getUtilization() async {
    Logger().d("getUtilization");
    Utilization result = await _utilizationService.getUtilizationResult(
        _startDate, _endDate, '-RuntimeHours', pageNumber, pageCount);
    if (result != null) {
      if (result.assetResults.isNotEmpty) {
        _utilLizationListData.addAll(result.assetResults);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _utilLizationListData.addAll(result.assetResults);
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
    } else {
      _loading = false;
      _loadingMore = false;
      notifyListeners();
    }
  }

  getRunTimeCumulative() async {
    RunTimeCumulative result = await _utilizationGraphService
        .getRunTimeCumulative(_startDate, _endDate);
    _runTimeCumulative = result;
    notifyListeners();
  }

  getFuelBurnedCumulative() async {
    FuelBurnedCumulative result = await _utilizationGraphService
        .getFuelBurnedCumulative(_startDate, _endDate);
    _fuelBurnedCumulative = result;
    notifyListeners();
  }

  onDetailPageSelected(AssetResult fleet) {
    _navigationService.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
            fleet: Fleet(
                assetSerialNumber: fleet.assetSerialNumber,
                assetId: fleet.assetIdentifierSqluid,
                assetIdentifier: fleet.assetIdentifier)));
  }

  _loadMore() {
    Logger().i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore) {
      Logger().i("load more called");
      pageNumber++;
      _loadingMore = true;
      notifyListeners();
      getUtilization();
    }
  }
}
