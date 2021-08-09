import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/core/services/fault_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class HealthListViewModel extends InsiteViewModel {
  Logger log;
  var _faultService = locator<FaultService>();

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  List<Fault> _faults = [];
  List<Fault> get faults => _faults;
  int page = 1;
  int limit = 20;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _healthListDataLoding = true;
  bool get healthListDataLoading => _healthListDataLoding;

  ScrollController scrollController;
  HealthListViewModel(AssetDetail assetDetail) {
    this._assetDetail = assetDetail;
    this.log = getLogger(this.runtimeType.toString());
    _faultService.setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      getHealthListData();
    });
  }

  getHealthListData() async {
    HealthListResponse result = await _faultService.getHealthListData(
        _assetDetail.assetUid,
        Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
        limit,
        page,
        Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate));
    _faults = result.assetData.faults;
    _healthListDataLoding = false;
    notifyListeners();
  }

  refresh() async {
    await getDateRangeFilterData();
    _refreshing = true;
    notifyListeners();
    HealthListResponse result = await _faultService.getHealthListData(
        _assetDetail.assetUid,
        Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
        limit,
        page,
        Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate));
    if (result != null) {
      _faults.clear();
      _faults.addAll(result.assetData.faults);
      _refreshing = false;
      notifyListeners();
    } else {
      _refreshing = false;
      notifyListeners();
    }
  }

  _loadMore() {
    Logger().i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore) {
      Logger().i("load more called");
      page++;
      _loadingMore = true;
      notifyListeners();
      getHealthListData();
    }
  }
}
