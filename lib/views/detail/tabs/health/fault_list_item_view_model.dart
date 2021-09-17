import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/services/fault_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';

class FaultListItemViewModel extends InsiteViewModel {
  var _faultService = locator<FaultService>();

  Fault _fault;
  Fault get fault => _fault;

  bool _loaded = false;
  bool get loaded => _loaded;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  List<Fault> _faults = [];
  List<Fault> get faults => _faults;

  ScrollController scrollController;
  int pageNumber = 1;
  int pageSize = 20;

  FaultListItemViewModel(this._fault) {
    Logger().d("FaultListItemViewModel ${fault.asset["uid"]}");
    setUp();
    _faultService.setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      _faults.clear();
      _loaded = false;
      notifyListeners();
    });
  }

  getFaultListItemData() async {
    Logger().d("getFaultViewList");
    await getSelectedFilterData();
    await getDateRangeFilterData();
    Logger().d("start date " + startDate);
    Logger().d("end date " + endDate);
    FaultSummaryResponse result =
        await _faultService.getAssetViewDetailSummaryList(
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
            Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
            pageSize,
            pageNumber,
            appliedFilters,
            fault.asset["uid"]);
    if (result != null && result.faults != null) {
      if (result.faults.isNotEmpty) {
        _faults.addAll(result.faults);
        _refreshing = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _faults.addAll(result.faults);
        _refreshing = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
    } else {
      _refreshing = false;
      notifyListeners();
    }
    _loaded = true;
    notifyListeners();
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
      getFaultListItemData();
    }
  }

  void onExpanded() {
    Logger().d("onExpanded");
    if (loaded) {
      return;
    }
    _refreshing = true;
    notifyListeners();
    getFaultListItemData();
  }
}
