import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/model/increment_decrement_model.dart';
import 'package:logger/logger.dart';

class EstimatedRuntimeViewModel extends InsiteViewModel {
  Logger log;

  TextEditingController fulltargetTimeController = TextEditingController();
  TextEditingController fullIdleTimeController = TextEditingController();

  bool _isSelectedFullWeekTarget = false;
  bool get isSelectedFullWeekTarget => _isSelectedFullWeekTarget;

  bool _isSelectedFullWeekIdle = false;
  bool get isSelectedFullWeekIdle => _isSelectedFullWeekIdle;

  List<IncrementDecrementValue> countValue = [
    IncrementDecrementValue(
        runTimecount: "", runtimeDays: "Sun", idleCount: ""),
    IncrementDecrementValue(
        runTimecount: "", runtimeDays: "Mon", idleCount: ""),
    IncrementDecrementValue(
        runTimecount: "", runtimeDays: "Tue", idleCount: ""),
    IncrementDecrementValue(
        runTimecount: "", runtimeDays: "Wed", idleCount: ""),
    IncrementDecrementValue(
        runTimecount: "", runtimeDays: "Thu", idleCount: ""),
    IncrementDecrementValue(
        runTimecount: "", runtimeDays: "Fri", idleCount: ""),
    IncrementDecrementValue(
        runTimecount: "", runtimeDays: "Sat", idleCount: ""),
  ];

  EstimatedRuntimeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
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

  getRuntimeListValueData(String value, int index) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[index];
      if (data != null) {
        data.runTimecount = value;
        // print("data:${data.count}");
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

  getIdleListValue(String value, int index) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[index];
      if (data != null) {
        data.idleCount = value;
        // print("data:${data.count}");
      }
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
        data.runTimecount = value;
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
        data.idleCount = value;
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

  double getPercentageData() {
    double percentageData = double.parse(fullIdleTimeController.text) / 10;
    return percentageData;
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
}
