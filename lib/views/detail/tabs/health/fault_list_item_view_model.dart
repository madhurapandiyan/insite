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

  List<Fault> _faults = [];
  List<Fault> get faults => _faults;

  FaultListItemViewModel(this._fault) {
    Logger().d("FaultListItemViewModel ${fault.asset["uid"]}");
    setUp();
    _faultService.setUp();
  }

  getFaultListItemData() async {
    Logger().d("getFaultViewList");
    if (loaded) {
      return;
    }
    await getSelectedFilterData();
    await getDateRangeFilterData();
    _refreshing = true;
    notifyListeners();
    Logger().d("start date " + startDate);
    Logger().d("end date " + endDate);
    FaultSummaryResponse result =
        await _faultService.getAssetViewDetailSummaryList(
            Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
            Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
            5,
            1,
            appliedFilters,
            fault.asset["uid"]);
    if (result != null && result.faults != null) {
      if (result.faults.isNotEmpty) {
        _faults.addAll(result.faults);
        _refreshing = false;
        notifyListeners();
      } else {
        _faults.addAll(result.faults);
        _refreshing = false;
        notifyListeners();
      }
    } else {
      _refreshing = false;
      notifyListeners();
    }
    _loaded = true;
    notifyListeners();
  }

  void onExpanded() {
    Logger().d("onExpanded");
    getFaultListItemData();
  }
}
