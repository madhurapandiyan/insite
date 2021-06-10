import 'package:flutter/material.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/utilization_data.dart';
import 'package:insite/core/services/asset_utilization_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class UtilizationGraphViewModel extends BaseViewModel {
  Logger log;
  ScrollController scrollController;

  var _utilizationService = locator<AssetUtilizationService>();

  int pageNumber = 1;
  int pageCount = 50;

  bool _loading = true;
  bool get loading => _loading;
  set loading(bool loading) {
    this._loading = loading;
  }

  List<UtilizationData> _utilLizationList = [];
  List<UtilizationData> get utilLizationList => _utilLizationList;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  UtilizationGraphViewModel() {
    this.log = getLogger(this.runtimeType.toString());

    _utilizationService.setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
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
      // getUtilization();
    }
  }
}
