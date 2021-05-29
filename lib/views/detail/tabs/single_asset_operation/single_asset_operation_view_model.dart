import 'package:insite/core/locator.dart';
import 'package:insite/core/models/single_asset_operation.dart';
import 'package:insite/core/services/single_asset_operation_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class SingleAssetOperationViewModel extends BaseViewModel {
  Logger log;

  var _singleAssetOperationService = locator<SingleAssetOperationService>();

  bool _loading = true;
  bool get loading => _loading;

  SingleAssetOperation _singleAssetOperation;
  SingleAssetOperation get singleAssetOperation => _singleAssetOperation;

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

  SingleAssetOperationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _singleAssetOperationService.setUp();
    getSingleAssetOperation();
  }

  getSingleAssetOperation() async {
    SingleAssetOperation result =
        await _singleAssetOperationService.getSingleAssetOperation(
            _startDate, _endDate, '9a3126b3-d8c1-11e7-80ff-060d7e00a6d1');
    _singleAssetOperation = result;
    _loading = false;
    notifyListeners();
  }
}
