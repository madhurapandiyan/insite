import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/model/incremet_decrement_payload.dart';
import 'package:logger/logger.dart';

class TargetCycleVolumePayloadViewModel extends InsiteViewModel {
  Logger log;

  bool _isChangeCycleState = false;
  bool get isChangeCycleState => _isChangeCycleState;

  bool _isChangeVolumeState = false;
  bool get isChangeVolumeState => _isChangeVolumeState;

  bool _isChangePayLoadState = false;
  bool get isChangePayLoadSate => _isChangePayLoadState;

  TextEditingController cycleController = new TextEditingController();

  TextEditingController volumeController = new TextEditingController();

  TextEditingController payLoadController = new TextEditingController();

  List<IncrementDecrementPayload> countValue = [
    IncrementDecrementPayload(
        runTimeDays: "Sun",
        targetCyclesCount: "",
        targetVolumesCount: "",
        targetPayloadCount: ""),
    IncrementDecrementPayload(
        runTimeDays: "Mon",
        targetCyclesCount: "",
        targetVolumesCount: "",
        targetPayloadCount: ""),
    IncrementDecrementPayload(
        runTimeDays: "Tue",
        targetCyclesCount: "",
        targetVolumesCount: "",
        targetPayloadCount: ""),
    IncrementDecrementPayload(
        runTimeDays: "Wed",
        targetCyclesCount: "",
        targetVolumesCount: "",
        targetPayloadCount: ""),
    IncrementDecrementPayload(
        runTimeDays: "Thu",
        targetCyclesCount: "",
        targetVolumesCount: "",
        targetPayloadCount: ""),
    IncrementDecrementPayload(
        runTimeDays: "Fri",
        targetCyclesCount: "",
        targetVolumesCount: "",
        targetPayloadCount: ""),
    IncrementDecrementPayload(
        runTimeDays: "Sat",
        targetCyclesCount: "",
        targetVolumesCount: "",
        targetPayloadCount: ""),
  ];

  TargetCycleVolumePayloadViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    cycleController.text = "0";
    volumeController.text = "0";
    payLoadController.text = "0";
  }

  getChangeCycleState() {
    _isChangeCycleState = !_isChangeCycleState;
    notifyListeners();
  }

  getChangeVolumeState() {
    _isChangeVolumeState = !isChangeVolumeState;
    notifyListeners();
  }

  getChangePayloadState() {
    _isChangePayLoadState = !isChangePayLoadSate;
    notifyListeners();
  }

  getIncrementCycleValue() {
    int currentValue = int.parse(cycleController.text);
    currentValue++;
    cycleController.text = (currentValue).toString();
    getFullWeekCycleData(cycleController.text);
    notifyListeners();
  }

  getDecrementCycleValue() {
    int currentValue = int.parse(cycleController.text);
    currentValue--;
    cycleController.text = (currentValue > 0 ? currentValue : 0).toString();
    getFullWeekCycleData(cycleController.text);
    notifyListeners();
  }

  getIncrementVolumeValue() {
    int currentValue = int.parse(volumeController.text);

    currentValue++;
    volumeController.text = (currentValue).toString();
    getFullWeekVolumeData(volumeController.text);
    notifyListeners();
  }

  getDecrementVolumeValue() {
    int currentValue = int.parse(volumeController.text);
    currentValue--;
    volumeController.text = (currentValue > 0 ? currentValue : 0).toString();
    getFullWeekVolumeData(volumeController.text);
    notifyListeners();
  }

  getIncrementPayLoadValue() {
    int currentValue = int.parse(payLoadController.text);

    currentValue++;
    payLoadController.text = (currentValue).toString();
    getFullWeekPayLoadData(payLoadController.text);
    notifyListeners();
  }

  getDecrementPayLoadValue() {
    int currentValue = int.parse(payLoadController.text);

    currentValue--;
    payLoadController.text = (currentValue).toString();
    getFullWeekPayLoadData(payLoadController.text);
    notifyListeners();
  }

  getSingleItemCycleData(String value, int index) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[index];
      if (data != null) {
        data.targetCyclesCount = value;
        // print("data:${data.count}");
      }
      notifyListeners();
    }
  }

  onClickCycleApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      print(i.toString() + " " + "runTimeValue:" + "${data.targetCyclesCount}");
    }
    notifyListeners();
  }

  getFullWeekCycleData(String text) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      if (data != null) {
        data.targetCyclesCount = text;
      }
    }
    notifyListeners();
  }

  getFullWeekTCycleDataApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      print(i.toString() +
          " " +
          "fullWeekTargetvalue : ${data.targetCyclesCount}");
    }
    notifyListeners();
  }

  getSingleVolumeItemData(String value, int index) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[index];
      if (data != null) {
        data.targetVolumesCount = value;
      }
    }
    notifyListeners();
  }

  onClickVolumeApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      if (data != null) {
        print(i.toString() +
            " " +
            "volume Value :" +
            "${data.targetVolumesCount}");
      }
    }
  }

  getFullWeekVolumeData(String text) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      if (data != null) {
        data.targetVolumesCount = text;
      }
    }
    notifyListeners();
  }

  getFullWeekVolumeDataApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      print(i.toString() +
          " " +
          "fullWeekVoumevalue : ${data.targetVolumesCount}");
    }
    notifyListeners();
  }

  getSingleItemPayLoadData(String value, int index) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[index];
      if (data != null) {
        data.targetPayloadCount = value;
      }
    }
    notifyListeners();
  }

  onClickPayLoadApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      if (data != null) {
        print(i.toString() + " " + "PayLoad :" + "${data.targetVolumesCount}");
      }
    }
  }

  getFullWeekPayLoadData(String text) {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      if (data != null) {
        data.targetPayloadCount = text;
      }
    }
    notifyListeners();
  }

  getFullWeekPayLoadDataApply() {
    for (int i = 0; i < countValue.length; i++) {
      var data = countValue[i];
      print(i.toString() +
          " " +
          "fullWeekPayLoadvalue : ${data.targetPayloadCount}");
    }
    notifyListeners();
  }
}
