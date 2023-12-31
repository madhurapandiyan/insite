import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/fault_service.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';

class FaultListItemViewModel extends InsiteViewModel {
  FaultService? _faultService = locator<FaultService>();

  Fault? _fault;
  Fault? get fault => _fault;

  bool _loaded = false;
  bool get loaded => _loaded;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  List<AssetFault> _faults = [];
  List<AssetFault> get faults => _faults;

  int? totalCount = 0;

  ScrollController? scrollController;
  int pageNumber = 1;
  int pageSize = 20;

   String? faultid;

  FaultListItemViewModel(AssetFault fault) {
    Logger().wtf("FaultListItemViewModel ${fault.asset!.uid}");
    setUp();
    this.faultid=fault.asset!.uid;

    _faultService!.setUp();
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        if (faults.length != faults.length) {
          _loadMore();
        }
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
    Logger().d("start date " + startDate!);
    Logger().d("end date " + endDate!);
    AssetFaultSummaryResponse? result = await _faultService!
        .getAssetViewDetailSummaryList(
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
            Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
            pageSize,
            pageNumber,
            appliedFilters,
           faultid,
            graphqlSchemaService!.getFaultSingleData(
                faultsId: faultid,
                startDate:
                    Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
                endDate: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
                langeDesc: "en-US",
                limit: pageSize,
                pageSize: pageNumber));
    if (result != null && result.assetFaults != null) {
      // totalCount =result.faults.first.countData! ;

      if (result.assetFaults!.isNotEmpty) {
        // _faults.addAll(result.faults!);

        if (appliedFilters!.isNotEmpty) {
          if (appliedFilters![0]!.title == 'Yellow' ||
              appliedFilters![0]!.title == 'Orange') {
            for (int i = 0; i <= result.assetFaults!.length - 1; i++) {
              if (result.assetFaults![i].asset!.basic!.severityLabel == 'High') {
                continue;
              } else {
                _faults.add(result.assetFaults!.elementAt(i));
              }
            }
          } else {
            _faults.addAll(result.assetFaults!);
          }
        } else {
          _faults.addAll(result.assetFaults!);
        }

        _refreshing = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        //_faults.addAll(result.faults!);
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
