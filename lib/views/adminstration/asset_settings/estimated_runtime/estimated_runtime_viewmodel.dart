import 'dart:math';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_settings_data.dart';
import 'package:insite/core/models/estimated_asset_setting.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/model/increment_decrement_model.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class EstimatedRuntimeViewModel extends InsiteViewModel {
  Logger? log;

  TextEditingController fulltargetTimeController = TextEditingController();
  TextEditingController fullIdleTimeController = TextEditingController();

  List<String?>? _assetUid;
  List<String?>? get assetUId => _assetUid;
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

  AssetAdminManagerUserService? _manageUserService = locator<AssetAdminManagerUserService>();

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
        runTimecount: 8, runtimeDays: "Mon", idleCount: 1, percentCount: 0),
    IncrementDecrementValue(
        runTimecount: 8, runtimeDays: "Tue", idleCount: 1, percentCount: 0),
    IncrementDecrementValue(
        runTimecount: 8, runtimeDays: "Wed", idleCount: 1, percentCount: 0),
    IncrementDecrementValue(
        runTimecount: 8, runtimeDays: "Thu", idleCount: 1, percentCount: 0),
    IncrementDecrementValue(
        runTimecount: 8, runtimeDays: "Fri", idleCount: 1, percentCount: 0),
    IncrementDecrementValue(
        runTimecount: 0, runtimeDays: "Sat", idleCount: 0, percentCount: 0),
  ];

  List<IncrementDecrementValue> createdCountValue = [];

  EstimatedRuntimeViewModel(List<String?>? assetUidList) {
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
            String countValue =
                Utils.getPercentageValueData(data.idleCount, data.runTimecount);
            data.idleCount = double.parse(countValue);
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
          String countValue =
              Utils.getPercentageValueData(data.runTimecount, data.idleCount);

          data.percentCount = double.parse(countValue);
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
          String countValue =
              Utils.getPercentageValueData(data.runTimecount, data.idleCount);

          data.percentCount = double.parse(countValue);
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
        data.runTimecount = double.parse(value);
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
        data.idleCount = double.parse(value);
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
        startDate,
        endDate,
        Idle(
            sunday: double.parse(
              countValue[0].idleCount.toString(),
            ),
            monday: double.parse(countValue[1].idleCount.toString()),
            tuesday: double.parse(countValue[2].idleCount.toString()),
            wednesday: double.parse(countValue[3].idleCount.toString()),
            thursday: double.parse(countValue[4].idleCount.toString()),
            friday: double.parse(countValue[5].idleCount.toString()),
            saturday: double.parse(countValue[6].idleCount.toString())),
        Runtime(
            sunday: double.parse(countValue[0].runTimecount.toString()),
            monday: double.parse(countValue[1].runTimecount.toString()),
            tuesday: double.parse(countValue[2].runTimecount.toString()),
            wednesday: double.parse(countValue[3].runTimecount.toString()),
            thursday: double.parse(countValue[4].runTimecount.toString()),
            friday: double.parse(countValue[5].runTimecount.toString()),
            saturday: double.parse(countValue[6].runTimecount.toString())));

    Logger().e(result);
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
      result =
          await _manageUserService!.getEstimatedTargetSettingListData(assetUId);

      if (result != null) {
        for (var i = 0; i < result!.assetTargetSettings!.length; i++) {
          final data = result!.assetTargetSettings![i];
          var sun = IncrementDecrementValue(
              idleCount: data.idle!.sunday!.toDouble(),
              runTimecount: data.runtime!.sunday!.toDouble(),
              runtimeDays: "Sun");
          var mon = IncrementDecrementValue(
              idleCount: data.idle!.monday!.toDouble(),
              runTimecount: data.runtime!.monday!.toDouble(),
              runtimeDays: "Mon");
          var tue = IncrementDecrementValue(
              idleCount: data.idle!.tuesday!.toDouble(),
              runTimecount: data.runtime!.tuesday!.toDouble(),
              runtimeDays: "Tue");
          var wed = IncrementDecrementValue(
              idleCount: data.idle!.wednesday!.toDouble(),
              runTimecount: data.runtime!.wednesday!.toDouble(),
              runtimeDays: "Wed");
          var thu = IncrementDecrementValue(
              idleCount: data.idle!.thursday!.toDouble(),
              runTimecount: data.runtime!.thursday!.toDouble(),
              runtimeDays: "Thu");
          var fri = IncrementDecrementValue(
              idleCount: data.idle!.friday!.toDouble(),
              runTimecount: data.runtime!.friday!.toDouble(),
              runtimeDays: "Fri");
          var sat = IncrementDecrementValue(
              idleCount: data.idle!.saturday!.toDouble(),
              runTimecount: data.runtime!.saturday!.toDouble(),
              runtimeDays: "Sat");
          dateFilterUpdateListValue.addAll([sun, mon, tue, wed, thu, fri, sat]);
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
          idleCount: dateFilterIdleValue!.sunday!.toDouble(),
          runTimecount: dateFilterRuntimeValue!.sunday!.toDouble(),
          runtimeDays: "Sun");
      var monT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.monday!.toDouble(),
          runTimecount: dateFilterRuntimeValue!.monday!.toDouble(),
          runtimeDays: "Mon");
      var tueT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.tuesday!.toDouble(),
          runTimecount: dateFilterRuntimeValue!.tuesday!.toDouble(),
          runtimeDays: "Tue");
      var wedT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.wednesday!.toDouble(),
          runTimecount: dateFilterRuntimeValue!.wednesday!.toDouble(),
          runtimeDays: "Wed");
      var thuT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.thursday!.toDouble(),
          runTimecount: dateFilterRuntimeValue!.thursday!.toDouble(),
          runtimeDays: "Thu");
      var friT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.friday!.toDouble(),
          runTimecount: dateFilterRuntimeValue!.friday!.toDouble(),
          runtimeDays: "Fri");
      var satT = IncrementDecrementValue(
          idleCount: dateFilterIdleValue!.saturday!.toDouble(),
          runTimecount: dateFilterRuntimeValue!.saturday!.toDouble(),
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
