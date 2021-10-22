import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/single_asset_operation.dart';
import 'package:insite/core/models/single_asset_operation_chart_data.dart';
import 'package:insite/core/services/single_asset_operation_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class SingleAssetOperationViewModel extends InsiteViewModel {
  Logger log;

  var _singleAssetOperationService = locator<SingleAssetOperationService>();

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  List<DateTime> _assetOperationDates = [];
  List<DateTime> get assetOperationDates => _assetOperationDates;

  List<SingleAssetOperationChartData> _chartData = [];
  List<SingleAssetOperationChartData> get chartData => _chartData;

  DateTime _minDate;
  DateTime get minDate => _minDate;

  DateTime _maxDate;
  DateTime get maxDate => _maxDate;

  bool _loading = true;
  bool get loading => _loading;
  bool _refreshing = false;
  bool get refreshing => _refreshing;

  SingleAssetOperation _singleAssetOperation;
  SingleAssetOperation get singleAssetOperation => _singleAssetOperation;

  SingleAssetOperationViewModel(AssetDetail detail) {
    this._assetDetail = detail;
    setUp();
    this.log = getLogger(this.runtimeType.toString());
    _singleAssetOperationService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getSingleAssetOperation();
    });
    Logger().i(
        "single asset operation view start date, end date ${startDate} ${endDate}");
  }

  getSingleAssetOperation() async {
    await getDateRangeFilterData();
    Logger().d("single asset operation " + _assetDetail.assetUid);
    SingleAssetOperation result = await _singleAssetOperationService
        .getSingleAssetOperation(startDate, endDate, _assetDetail.assetUid);
    _singleAssetOperation = result;
    if (_singleAssetOperation != null) setRequiredDates();
    _loading = false;
    notifyListeners();
  }

  refresh() async {
    await getDateRangeFilterData();
    _refreshing = true;
    notifyListeners();
    Logger().d("single asset operation " + _assetDetail.assetUid);
    SingleAssetOperation result = await _singleAssetOperationService
        .getSingleAssetOperation(startDate, endDate, _assetDetail.assetUid);
    _singleAssetOperation = result;
    if (_singleAssetOperation != null) setRequiredDates();
    _loading = false;
    _refreshing = false;
    notifyListeners();
  }

  setRequiredDates() {
    _chartData.clear();
    for (Asset asset in _singleAssetOperation.assetOperations.assets) {
      for (AssetLocalDate assetLocalDate in asset.assetLocalDates) {
        for (Segment segment in assetLocalDate.segments) {
          _assetOperationDates.add(segment.startTimeUtc);
          _assetOperationDates.add(segment.endTimeUtc);
          Logger().d(
              "segment data ${segment.startTimeUtc} ${segment.endTimeUtc} ${segment.segmentType}");
          _chartData.add(
            SingleAssetOperationChartData(
                segment.startTimeUtc,
                segment.endTimeUtc,
                segment.segmentType,
                segment.durationSeconds),
          );
        }
      }
    }

    if (_assetOperationDates.isEmpty) return;
    _minDate = Utils.getMinDate(_assetOperationDates);
    _maxDate = Utils.getMaxDate(_assetOperationDates);
  }
}
