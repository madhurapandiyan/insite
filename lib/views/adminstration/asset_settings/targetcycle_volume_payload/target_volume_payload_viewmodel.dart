import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';

import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/models/asset_settings_data.dart';
import 'package:insite/core/models/estimated_cycle_volume_payload.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/model/incremet_decrement_payload.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TargetCycleVolumePayloadViewModel extends InsiteViewModel {
  Logger? log;

  List<String>? _assetUId;
  List<String>? get assetUid => _assetUId;

  bool _isChangeCycleState = false;
  bool get isChangeCycleState => _isChangeCycleState;

  bool _isChangeVolumeState = false;
  bool get isChangeVolumeState => _isChangeVolumeState;

  bool _isChangePayLoadState = false;
  bool get isChangePayLoadSate => _isChangePayLoadState;

  TextEditingController cycleController = new TextEditingController();

  TextEditingController volumeController = new TextEditingController();

  TextEditingController payLoadController = new TextEditingController();

  TextEditingController startDateInput = new TextEditingController();

  TextEditingController endDateInput = new TextEditingController();

  AssetAdminManagerUserService? _manageUserService = locator<AssetAdminManagerUserService>();
  SnackbarService? _snackBarService = locator<SnackbarService>();

  EstimatedCycleVolumePayLoad? result;
  Cycles? dateFilterTargetValue;
  Volumes? dateFilterVolumeValue;
  PayLoad? dateFilterPayLoadValue;
  List<IncrementDecrementPayload> countValue = [
    IncrementDecrementPayload(
        runTimeDays: "Sun",
        targetCyclesCount: 0,
        targetVolumesCount: 0,
        targetPayloadCount: 0),
    IncrementDecrementPayload(
        runTimeDays: "Mon",
        targetCyclesCount: 0,
        targetVolumesCount: 0,
        targetPayloadCount: 0),
    IncrementDecrementPayload(
        runTimeDays: "Tue",
        targetCyclesCount: 0,
        targetVolumesCount: 0,
        targetPayloadCount: 0),
    IncrementDecrementPayload(
        runTimeDays: "Wed",
        targetCyclesCount: 0,
        targetVolumesCount: 0,
        targetPayloadCount: 0),
    IncrementDecrementPayload(
        runTimeDays: "Thu",
        targetCyclesCount: 0,
        targetVolumesCount: 0,
        targetPayloadCount: 0),
    IncrementDecrementPayload(
        runTimeDays: "Fri",
        targetCyclesCount: 0,
        targetVolumesCount: 0,
        targetPayloadCount: 0),
    IncrementDecrementPayload(
        runTimeDays: "Sat",
        targetCyclesCount: 0,
        targetVolumesCount: 0,
        targetPayloadCount: 0),
  ];

  TargetCycleVolumePayloadViewModel(List<String>? assetUIdList) {
    _assetUId = assetUIdList;
    this.log = getLogger(this.runtimeType.toString());
    getEstimatedCycleVoumePayLoadListData();
    cycleController.text = "0";
    volumeController.text = "0";
    payLoadController.text = "0";
  }

  getStartTextState(String value) {
    startDateInput.text = value;
    notifyListeners();
  }

  getEndTextState(String value) {
    endDateInput.text = value;
    notifyListeners();
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
        data.targetCyclesCount = double.parse(value);
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
        data.targetCyclesCount = double.parse(text);
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
        data.targetVolumesCount = double.parse(value);
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
        data.targetVolumesCount = double.parse(text);
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
        data.targetPayloadCount = double.parse(value);
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
        data.targetPayloadCount = double.parse(text);
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

  getEstimatedCycleVolumePayLoad(
      DateTime? startDate, DateTime? endDate, BuildContext context) async {
    // if (!endDate.isAfter(startDate)) {
    //   _snackBarService.showSnackbar(
    //       message: "EndDate should be greter than StartDate");
    //   return;
    // }
    if (startDate == null) {
      _snackBarService!.showSnackbar(message: "StartDate must not be  null");
      return;
    } else if (endDate == null) {
      _snackBarService!.showSnackbar(message: "EndDate must not be  null");
      return;
    }
    EstimatedCycleVolumePayLoad? result =
        await _manageUserService!.getEstimatedCycleVolumePayLoad(
            assetUid!,
            Cycles(
              sunday: double.parse(countValue[0].targetCyclesCount.toString()),
              monday: double.parse(countValue[1].targetCyclesCount.toString()),
              tuesday: double.parse(countValue[2].targetCyclesCount.toString()),
              wednesday:
                  double.parse(countValue[3].targetCyclesCount.toString()),
              thursday:
                  double.parse(countValue[4].targetCyclesCount.toString()),
              friday: double.parse(countValue[5].targetCyclesCount.toString()),
              saturday:
                  double.parse(countValue[6].targetCyclesCount.toString()),
            ),
            Volumes(
                sunday:
                    double.parse(countValue[0].targetVolumesCount.toString()),
                monday:
                    double.parse(countValue[1].targetVolumesCount.toString()),
                tuesday:
                    double.parse(countValue[2].targetVolumesCount.toString()),
                wednesday:
                    double.parse(countValue[3].targetVolumesCount.toString()),
                thursday:
                    double.parse(countValue[4].targetVolumesCount.toString()),
                friday:
                    double.parse(countValue[5].targetVolumesCount.toString()),
                saturday:
                    double.parse(countValue[6].targetVolumesCount.toString())),
            PayLoad(
              sunday: double.parse(countValue[0].targetPayloadCount.toString()),
              monday: double.parse(countValue[1].targetPayloadCount.toString()),
              tuesday:
                  double.parse(countValue[2].targetPayloadCount.toString()),
              wednesday:
                  double.parse(countValue[3].targetPayloadCount.toString()),
              thursday:
                  double.parse(countValue[4].targetPayloadCount.toString()),
              friday: double.parse(countValue[5].targetPayloadCount.toString()),
              saturday:
                  double.parse(countValue[6].targetPayloadCount.toString()),
            ),
            startDate.toString(),
            endDate.toString());
    print("result:$result");
    if (result != null) {
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(false);
    }
    notifyListeners();
  }

  getEstimatedCycleVoumePayLoadListData() async {
    result = await _manageUserService!
        .getEstimatedCycleVolumePayLoadListData(assetUid);
    print("result:$result");
    notifyListeners();
  }

  getDateFilter(DateTime startDate, DateTime endDate) {
    dateFilterTargetValue = Cycles(
        sunday: 0,
        monday: 0,
        tuesday: 0,
        wednesday: 0,
        thursday: 0,
        friday: 0,
        saturday: 0);
    dateFilterVolumeValue = Volumes(
        sunday: 0,
        monday: 0,
        tuesday: 0,
        wednesday: 0,
        thursday: 0,
        friday: 0,
        saturday: 0);
    dateFilterPayLoadValue = PayLoad(
        sunday: 0,
        monday: 0,
        tuesday: 0,
        wednesday: 0,
        thursday: 0,
        friday: 0,
        saturday: 0);

    List<IncrementDecrementPayload> dateFilterUpdateListValue = [];

    try {
      var startDateString = Utils.getLastReportedDateTwoFilter(startDate);
      var endDateString = Utils.getLastReportedDateTwoFilter(endDate);
      result!.assetProductivitySettings!.forEach((element) {
        if (element.startDate == startDateString &&
            element.endDate == endDateString) {
          dateFilterTargetValue = element.cycles;
          dateFilterVolumeValue = element.volumes;
          dateFilterPayLoadValue = element.payload;
        }
      });

      var sunT = IncrementDecrementPayload(
          targetCyclesCount: dateFilterTargetValue!.sunday,
          targetVolumesCount: dateFilterVolumeValue!.sunday,
          targetPayloadCount: dateFilterPayLoadValue!.sunday,
          runTimeDays: "Sun");
      var monT = IncrementDecrementPayload(
          targetCyclesCount: dateFilterTargetValue!.monday,
          targetVolumesCount: dateFilterVolumeValue!.monday,
          targetPayloadCount: dateFilterPayLoadValue!.monday,
          runTimeDays: "Mon");
      var tueT = IncrementDecrementPayload(
          targetCyclesCount: dateFilterTargetValue!.tuesday,
          targetVolumesCount: dateFilterVolumeValue!.tuesday,
          targetPayloadCount: dateFilterPayLoadValue!.tuesday,
          runTimeDays: "Tue");
      var wedT = IncrementDecrementPayload(
          targetCyclesCount: dateFilterTargetValue!.wednesday,
          targetVolumesCount: dateFilterVolumeValue!.wednesday,
          targetPayloadCount: dateFilterPayLoadValue!.wednesday,
          runTimeDays: "Wed");
      var thuT = IncrementDecrementPayload(
          targetCyclesCount: dateFilterTargetValue!.thursday,
          targetVolumesCount: dateFilterVolumeValue!.thursday,
          targetPayloadCount: dateFilterPayLoadValue!.thursday,
          runTimeDays: "Thu");
      var friT = IncrementDecrementPayload(
          targetCyclesCount: dateFilterTargetValue!.friday,
          targetVolumesCount: dateFilterVolumeValue!.friday,
          targetPayloadCount: dateFilterPayLoadValue!.friday,
          runTimeDays: "Fri");
      var satT = IncrementDecrementPayload(
          targetCyclesCount: dateFilterTargetValue!.sunday,
          targetVolumesCount: dateFilterVolumeValue!.sunday,
          targetPayloadCount: dateFilterPayLoadValue!.sunday,
          runTimeDays: "Sun");
      dateFilterUpdateListValue
          .addAll([sunT, monT, tueT, wedT, thuT, friT, satT]);

      if (dateFilterTargetValue == null &&
          dateFilterVolumeValue == null &&
          dateFilterPayLoadValue == null) {
        notifyListeners();
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
