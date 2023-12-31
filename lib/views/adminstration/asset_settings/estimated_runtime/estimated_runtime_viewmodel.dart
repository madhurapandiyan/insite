import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/estimated_asset_setting.dart';
import 'package:insite/core/models/estimated_response.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/model/increment_decrement_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class EstimatedRuntimeViewModel extends InsiteViewModel {
  Logger? log;

  TextEditingController fulltargetTimeController = TextEditingController();
  TextEditingController fullIdleTimeController = TextEditingController();

  List<String>? _assetUid;
  List<String>? get assetUId => _assetUid;
  String? percentData;

  List<dynamic>? dummydata;

  bool _isSelectedFullWeekTarget = false;
  bool get isSelectedFullWeekTarget => _isSelectedFullWeekTarget;

  bool _isSelectedFullWeekIdle = false;
  bool get isSelectedFullWeekIdle => _isSelectedFullWeekIdle;

  double? _percentageData;
  double? get percentageData => _percentageData;

  TextEditingController startDateController = new TextEditingController();

  TextEditingController endDateController = new TextEditingController();

  SnackbarService? _snackBarService = locator<SnackbarService>();

  List<double> getPercenData = [];

  Runtime? dateFilterRuntimeValue;
  Idle? dateFilterIdleValue;

  List<double> getIdleData = [];

  bool isChangingState = false;
  bool get changedState => isChangingState;

  AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();

  getStartDateData(String formattedDate) {
    startDateController.text = formattedDate;
    notifyListeners();
  }

  getEndDateData(String formattedDate) {
    endDateController.text = formattedDate;
    notifyListeners();
  }

  List<IncrementDecrementValue> countValue = [
    IncrementDecrementValue(
      runTimecount: 0,
      runtimeDays: "Sun",
      idleCount: 0,
      percentCount: 0,
    ),
    IncrementDecrementValue(
        runTimecount: 8,
        runtimeDays: "Mon",
        idleCount: 1.6,
        percentCount: Utils.getEstimatedPercentValue(8, 1.6)),
    IncrementDecrementValue(
        runTimecount: 8,
        runtimeDays: "Tue",
        idleCount: 1.6,
        percentCount: Utils.getEstimatedPercentValue(8, 1.6)),
    IncrementDecrementValue(
        runTimecount: 8,
        runtimeDays: "Wed",
        idleCount: 1.6,
        percentCount: Utils.getEstimatedPercentValue(8, 1.6)),
    IncrementDecrementValue(
        runTimecount: 8,
        runtimeDays: "Thu",
        idleCount: 1.6,
        percentCount: Utils.getEstimatedPercentValue(8, 1.6)),
    IncrementDecrementValue(
        runTimecount: 8,
        runtimeDays: "Fri",
        idleCount: 1.6,
        percentCount: Utils.getEstimatedPercentValue(8, 1.6)),
    IncrementDecrementValue(
        runTimecount: 0, runtimeDays: "Sat", idleCount: 0, percentCount: 0),
  ];

  List<IncrementDecrementValue> createdCountValue = [];

  EstimatedRuntimeViewModel(List<String>? assetUidList) {
    Logger().i("viewModel:$assetUidList");
    _assetUid = assetUidList;
    this.log = getLogger(this.runtimeType.toString());
    getEstimatedTargetSettingsData();
    fulltargetTimeController.text = "0";
    fullIdleTimeController.text = "0";
  }
  onChangeStateRuntime() {
    _isSelectedFullWeekTarget = !_isSelectedFullWeekTarget;
    notifyListeners();
  }

  onChangeStateIdle() {
    _isSelectedFullWeekIdle = !isSelectedFullWeekIdle;
    notifyListeners();
  }

  onChangeStateValue() {
    isChangingState = !isChangingState;
    notifyListeners();
  }

  getPercentCountValue(String value, int index) {
    try {
      for (int i = 0; i < countValue.length; i++) {
        var data = countValue[index];
        if (data != null) {
          data.percentCount = double.parse(value);
          if (isChangingState == true) {
            data.idleCount =
                Utils.getHrsValueeData(data.idleCount, data.runTimecount);
            Logger().e(data.idleCount);
          } else {
            num countValue =
                Utils.getPercentageValueData(data.idleCount, data.runTimecount);
            data.idleCount = countValue;
          }
        }
      }
    } catch (e) {
      Logger().e(e.toString());
    }

    notifyListeners();
  }

  onClickValuePercentApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      print(i.toString() + " " + "percentValue:${data.percentCount}");
    }
    notifyListeners();
  }

  getRuntimeListValueData(String value, int index) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[index];
      if (data != null) {
        data.runTimecount = double.parse(value);
        if (isChangingState == true) {
          data.idleCount =
              Utils.getHrsValueeData(data.percentCount, data.runTimecount);    
        } else {
          num countValue =
              Utils.getPercentageValueData(data.runTimecount, data.idleCount);

          data.percentCount = countValue;
        }
      }
    }
    notifyListeners();
  }

  getRuntimeAllValueData() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      if (data != null) {
        // data.runTimecount = double.parse(value);
        if (isChangingState == true) {
          data.idleCount =
              Utils.getHrsValueeData(data.percentCount, data.runTimecount);
        } else {
          num countValue =
              Utils.getPercentageValueData(data.runTimecount, data.idleCount);

          data.percentCount = countValue;
        }
      }
    }
    notifyListeners();
  }

  onClickValueRunTimeApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      print(i.toString() + " " + "runTimeValue:${data.runTimecount}");
    }
    notifyListeners();
  }

  getIdleListValue(String value, index) {
    try {
      for (int i = 0; i < countValue.length; i++) {
        var data = countValue[index];
        if (data != null) {
          data.idleCount = double.parse(value);
          if (isChangingState == true) {
            data.idleCount =
                Utils.getHrsValueeData(data.idleCount, data.runTimecount);
            Logger().w(data.percentCount);
          }
          num countValue =
              Utils.getPercentageValueData(data.runTimecount, data.idleCount);

          // data.percentCount = double.parse(countValue);
          data.percentCount = countValue;
        }
      }
    } catch (e) {
      Logger().e(e.toString());
    }

    notifyListeners();
  }

  getIdleAllValue() {
    try {
      for (int i = 0; i < countValue.length; i++) {
        var data = countValue[i];
        if (data != null) {
          //data.idleCount = double.parse(value);
          if (isChangingState == true) {
            data.idleCount =
                Utils.getHrsValueeData(data.idleCount, data.runTimecount);
            Logger().w(data.percentCount);
          }
          num countValue =
              Utils.getPercentageValueData(data.runTimecount, data.idleCount);

          data.percentCount = countValue;
        }
      }
    } catch (e) {
      Logger().e(e.toString());
    }

    notifyListeners();
  }

  onIdleClickValueApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      print(i.toString() + " " + "idleValue:${data.idleCount}");
    }
    notifyListeners();
  }

  getFullWeekTargetData(String value) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      if (data != null) {
        data.runTimecount = int.parse(value);
        data.percentCount = Utils.getEstimatedTargetRuntimePercentValue(
            data.idleCount, data.runTimecount);
      }
      notifyListeners();
    }
  }

  getFullWeekTargetDataApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      print(i.toString() + " " + "fullWeekTargetvalue  ${data.runTimecount}");
    }
    notifyListeners();
  }

  getFullWeekIdleData(String value) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      if (data != null) {
        data.idleCount = int.parse(value);
      }
      notifyListeners();
    }
  }

  getFullWeekIdleDataApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      print(i.toString() + " " + "fullWeekIdlevalue  ${data.idleCount}");
    }
    notifyListeners();
  }

  getIncrementRuntimeValue() {
    int currentValue = int.parse(fulltargetTimeController.text);
    currentValue++;
    fulltargetTimeController.text = (currentValue).toString();
    getFullWeekTargetData(fulltargetTimeController.text);
    notifyListeners();
  }

  getDecrementRuntimeValue() {
    int currentValue = int.parse(fulltargetTimeController.text);
    currentValue--;
    fulltargetTimeController.text =
        (currentValue > 0 ? currentValue : 0).toString();
    getFullWeekTargetData(fulltargetTimeController.text);
    notifyListeners();
  }

  getIncrementIdleValue() {
    int currentValue = int.parse(fullIdleTimeController.text);
    currentValue++;
    fullIdleTimeController.text = (currentValue).toString();
    getFullWeekIdleData(fullIdleTimeController.text);
    notifyListeners();
  }

  getDecrementIdleValue() {
    int currentValue = int.parse(fullIdleTimeController.text);
    currentValue--;
    fullIdleTimeController.text =
        (currentValue > 0 ? currentValue : 0).toString();
    getFullWeekIdleData(fullIdleTimeController.text);
    notifyListeners();
  }

  getAssetSettingTargetData(
      DateTime? startDate, DateTime? endDate, BuildContext context) async {
    if (startDate == null) {
      _snackBarService!.showSnackbar(message: "StartDate must not be  null");
      return;
    } else if (endDate == null) {
      _snackBarService!.showSnackbar(message: "EndDate must not be  null");
      return;
    }

    var result = await _manageUserService!.getAssetTargetSettingsData(
      assetUId!,
      Utils.getFaultDateFormatStartDate(startDate),
      Utils.getFaultDateFormatEndDate(endDate),
      Idle(
          sunday: countValue[0].idleCount!.toInt(),
          monday: countValue[1].idleCount!.toInt(),
          tuesday: countValue[2].idleCount!.toInt(),
          wednesday: countValue[3].idleCount!.toInt(),
          thursday: countValue[4].idleCount!.toInt(),
          friday: countValue[5].idleCount!.toInt(),
          saturday: countValue[6].idleCount!.toInt()),
      Runtime(
          sunday: countValue[0].runTimecount!.toInt(),
          monday: countValue[1].runTimecount!.toInt(),
          tuesday: countValue[2].runTimecount!.toInt(),
          wednesday: countValue[3].runTimecount!.toInt(),
          thursday: countValue[4].runTimecount!.toInt(),
          friday: countValue[5].runTimecount!.toInt(),
          saturday: countValue[6].runTimecount!.toInt()),
    );

    // Logger().e(result!.data!.updateAssetTargetSettings!.assetUIDs);

    if (result != null) {
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(false);
    }
    notifyListeners();
  }

  EstimatedAssetSetting? result;
  List<IncrementDecrementValue> dateFilterUpdateListValue = [];

  getEstimatedTargetSettingsData() async {
    try {
      String? startdate = Utils.getLastReportedDateFilterData(
          DateTime.utc(2022, DateTime.january, 02));
      String? endDate = Utils.getLastReportedDateFilterData(
          DateTime.utc(2022, DateTime.may, 28));
      result = await _manageUserService!.getEstimatedTargetSettingListData(
          assetUId,
          graphqlSchemaService!
              .getAssetTargetSettingsData(startdate, endDate, assetUId));
      if (result != null) {
        if (result!.assetTargetSettings!.isNotEmpty) {
          for (var i = 0; i < result!.assetTargetSettings!.length; i++) {
            final data = result!.assetTargetSettings![i];
            var sun = IncrementDecrementValue(
                idleCount: data.idle!.sunday!,
                runTimecount: data.runtime!.sunday!,
                runtimeDays: "Sun");
            var mon = IncrementDecrementValue(
                idleCount: data.idle!.monday!,
                runTimecount: data.runtime!.monday!,
                runtimeDays: "Mon");
            var tue = IncrementDecrementValue(
                idleCount: data.idle!.tuesday!,
                runTimecount: data.runtime!.tuesday!,
                runtimeDays: "Tue");
            var wed = IncrementDecrementValue(
                idleCount: data.idle!.wednesday!,
                runTimecount: data.runtime!.wednesday!,
                runtimeDays: "Wed");
            var thu = IncrementDecrementValue(
                idleCount: data.idle!.thursday!,
                runTimecount: data.runtime!.thursday!,
                runtimeDays: "Thu");
            var fri = IncrementDecrementValue(
                idleCount: data.idle!.friday!,
                runTimecount: data.runtime!.friday!,
                runtimeDays: "Fri");
            var sat = IncrementDecrementValue(
                idleCount: data.idle!.saturday!,
                runTimecount: data.runtime!.saturday!,
                runtimeDays: "Sat");
            dateFilterUpdateListValue
                .addAll([sun, mon, tue, wed, thu, fri, sat]);
            countValue = dateFilterUpdateListValue;
          }
        }

        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  getDateFilter(DateTime startDate, DateTime endDate) {
    dateFilterRuntimeValue = Runtime(
        sunday: 0,
        monday: 0,
        tuesday: 0,
        wednesday: 0,
        thursday: 0,
        friday: 0,
        saturday: 0);
    dateFilterIdleValue = Idle(
        sunday: 0,
        monday: 0,
        tuesday: 0,
        wednesday: 0,
        thursday: 0,
        friday: 0,
        saturday: 0);
    dateFilterUpdateListValue = [];
    try {
      var startDateString = Utils.getLastReportedDateTwoFilter(startDate);
      var endDateString = Utils.getLastReportedDateTwoFilter(endDate);
      result!.assetTargetSettings!.forEach((element) {
        if (element.startDate == startDateString &&
            element.endDate == endDateString) {
          dateFilterRuntimeValue = element.runtime;
          dateFilterIdleValue = element.idle;
        }
      });

      var sunT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.sunday!,
          runTimecount: dateFilterRuntimeValue!.sunday!,
          runtimeDays: "Sun");
      var monT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.monday!,
          runTimecount: dateFilterRuntimeValue!.monday!,
          runtimeDays: "Mon");
      var tueT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.tuesday!,
          runTimecount: dateFilterRuntimeValue!.tuesday!,
          runtimeDays: "Tue");
      var wedT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.wednesday!,
          runTimecount: dateFilterRuntimeValue!.wednesday!,
          runtimeDays: "Wed");
      var thuT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.thursday!,
          runTimecount: dateFilterRuntimeValue!.thursday!,
          runtimeDays: "Thu");
      var friT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.friday!,
          runTimecount: dateFilterRuntimeValue!.friday!,
          runtimeDays: "Fri");
      var satT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.saturday!,
          runTimecount: dateFilterRuntimeValue!.saturday!,
          runtimeDays: "Sat");
      dateFilterUpdateListValue
          .addAll([sunT, monT, tueT, wedT, thuT, friT, satT]);

      if (dateFilterIdleValue == null && dateFilterRuntimeValue == null) {
        return countValue;
      } else {
        countValue = dateFilterUpdateListValue;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }

    notifyListeners();
  }
}
