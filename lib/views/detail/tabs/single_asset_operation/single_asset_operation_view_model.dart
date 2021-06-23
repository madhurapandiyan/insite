import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/single_asset_operation.dart';
import 'package:insite/core/models/single_asset_operation_chart_data.dart';
import 'package:insite/core/services/single_asset_operation_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class SingleAssetOperationViewModel extends BaseViewModel {
  Logger log;

  var _singleAssetOperationService = locator<SingleAssetOperationService>();

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  List<DateTime> _assetOperationDates = [];
  List<DateTime> get assetOperationDates => _assetOperationDates;

  List<SingleAssetOperationChartData> _chartData;
  List<SingleAssetOperationChartData> get chartData => _chartData;

  DateTime _minDate;
  DateTime get minDate => _minDate;

  DateTime _maxDate;
  DateTime get maxDate => _maxDate;

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

  SingleAssetOperationViewModel(AssetDetail detail) {
    this._assetDetail = detail;
    this.log = getLogger(this.runtimeType.toString());
    _singleAssetOperationService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getSingleAssetOperation();
    });
  }

  getSingleAssetOperation() async {
    Logger().d("single asset operation " + _assetDetail.assetUid);
    SingleAssetOperation result = await _singleAssetOperationService
        .getSingleAssetOperation(_startDate, _endDate, _assetDetail.assetUid);
    _singleAssetOperation = result;
    setRequiredDates();
    _loading = false;
    notifyListeners();
  }

  setRequiredDates() {
    for (Asset asset in _singleAssetOperation.assetOperations.assets) {
      for (AssetLocalDate assetLocalDate in asset.assetLocalDates) {
        for (Segment segment in assetLocalDate.segments) {
          _assetOperationDates.add(segment.startTimeUtc);
          _assetOperationDates.add(segment.endTimeUtc);
          _chartData.add(
            SingleAssetOperationChartData(
              Utils.getDecimalFromTime(segment.startTimeUtc),
              Utils.getDecimalFromTime(segment.endTimeUtc),
              DateFormat('MMM dd').format(assetLocalDate.assetLocalDate),
            ),
          );
        }
      }
    }

    if (_assetOperationDates.isEmpty) return;

    _minDate = Utils.getMinDate(_assetOperationDates);
    _maxDate = Utils.getMaxDate(_assetOperationDates);

    print('@@@ $_minDate');
  }
}
