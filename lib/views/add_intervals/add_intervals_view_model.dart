import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/edit_interval_response.dart';
import 'package:insite/core/models/maintenance_checkList.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/add_new_notifications_view_model.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class AddIntervalsViewModel extends InsiteViewModel {
  Logger? log;

  MaintenanceService? _maintenanceService = locator<MaintenanceService>();
  GraphqlSchemaService? _graphqlSchemaService = locator<GraphqlSchemaService>();

  int pageNo = 1;
  bool isLoading = true;
  String? assetUid;
  AssetDetail? singleAssetDetail;
  PageController? pageController = PageController();
  TextEditingController controller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<CheckAndPartList> checkListData = [];
  List<MaintenanceCheckList> maintenanceCheckList = [];
  MaintenanceIntervalData? maintenanceInterval;
  MaintenanceIntervals? maintenanceIntervalsData;
  List<SwitchState> switchState = [];
  AddMaintenanceIntervalPayload? maitenanceCheckListData;
  Timer? deBounce;
  IntervalList? selectedIntervals;
  List<int> intervalId = [];
  List<int> checkListId = [];
  List<int> partListId = [];
  bool isEditing = false;
  bool isValidating = false;

  AddIntervalsViewModel({AssetDetail? assetDetail}) {
    this.log = getLogger(this.runtimeType.toString());
    singleAssetDetail = assetDetail;
    assetUid = assetDetail!.assetUid;
    getMaintenanceIntervals();
  }

  onSwitchTaped(int i) {
    switchState[i].state = !switchState[i].state!;
    var intervalName = switchState[i].suffixTitle;
    if (switchState[i].state!) {
      selectedIntervals =
          maintenanceIntervalsData!.intervalList!.singleWhere((element) {
        Logger().v(element.intervalID.toString() == intervalName);
        return element.intervalID.toString() == intervalName;
      });
    } else {
      selectedIntervals = null;
    }

    notifyListeners();
  }

  onAddingIntervals() {
    clearAllValue();
    isEditing = false;
    pageController!.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  onClickingBackInAddInterval() {
    pageController!.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  onSelectall() {
    switchState.forEach((element) {
      element.state = true;
    });
    selectedIntervals = null;
    notifyListeners();
  }

  onSearching() async {
    try {
      if (deBounce?.isActive ?? false) {
        deBounce!.cancel();
      } else {
        deBounce = Timer(Duration(seconds: 1), () async {
          switchState.clear();
          await getMaintenanceIntervals();
        });
      }
    } catch (e) {
      hideLoadingDialog();
    }
  }

  getMaintenanceIntervals() async {
    try {
      maintenanceIntervalsData = await _maintenanceService!
          .getMaintenanceIntervals(_graphqlSchemaService!.maintenanceInterval(
              assetId: assetUid, pageNo: pageNo, searchWord: controller.text));

      if (maintenanceIntervalsData != null &&
          maintenanceIntervalsData!.intervalList!.isNotEmpty) {
        for (var item in maintenanceIntervalsData!.intervalList!) {
          SwitchState data = SwitchState(
              text: item.intervalName,
              state: false,
              suffixTitle: item.intervalID.toString());
          switchState.add(data);
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onCheckListAdded() {
    checkListData.add(CheckAndPartList(
        checkListName: TextEditingController(),
        partListData: [],
        expansionState: false));
    notifyListeners();
  }

  onPartListAdded(int i) {
    var data = checkListData[i];
    data.partListData!.add(PartListDataClass(
        part: TextEditingController(),
        partName: TextEditingController(),
        quantity: TextEditingController()));
    Logger().w(data.partListData!.length);
    notifyListeners();
  }

  onTileExpanded(int i) {
    checkListData[i].expansionState = !checkListData[i].expansionState!;
    notifyListeners();
  }

  onPartListDeleted(int checkListIndex, int partListIndex) {
    var data =
        checkListData[checkListIndex].partListData!.removeAt(partListIndex);
    notifyListeners();
  }

  onPartUnitChanged(int checkListIndex, int partListIndex, String value) {
    checkListData[checkListIndex].partListData![partListIndex].value = value;
    notifyListeners();
  }

  onCheckListDelete(int i) {
    checkListData.removeAt(i);
    notifyListeners();
  }

  int? value;
  getIncrementFrequencyValue() {
    value = int.parse(
        frequencyController.text.isEmpty ? "0" : frequencyController.text);
    value = value! + 1;
    frequencyController.text = value.toString();
  }

  getDecrementFrequencyValue() {
    if (frequencyController.text == "0") {
      return;
    }
    if (frequencyController.text == "") {
      return;
    }
    value = int.parse(
        frequencyController.text.isEmpty ? "0" : frequencyController.text);
    value = value! - 1;
    frequencyController.text = value.toString();
  }

  gettingUserData() {
    try {
      if (checkListData.isNotEmpty) {
        maintenanceCheckList.clear();
        for (var checkList in checkListData) {
          MaintenanceCheckList mainCheckList = MaintenanceCheckList(
              checkName: checkList.checkListName!.text,
              checkListId: checkList.checkListId,
              partList: []);
          print("checkList created");
          if (checkList.partListData != null &&
              checkList.partListData!.isNotEmpty) {
            for (var partList in checkList.partListData!) {
              MaintenancePartList mainPartList = MaintenancePartList(
                  partId: partList.partId,
                  units: partList.value,
                  partNo: partList.part!.text,
                  partName: partList.partName!.text,
                  quantiy: int.parse(partList.quantity!.text.isEmpty
                      ? "0"
                      : partList.quantity!.text));

              mainCheckList.partList?.add(mainPartList);
            }
          }
          print("partList created");

          maintenanceCheckList.add(mainCheckList);
        }
        print("maintenance interval created");
      }
      maintenanceInterval = MaintenanceIntervalData(
          intervalDescription: selectedIntervals?.intervalDescription != null
              ? (selectedIntervals!.intervalDescription!)
              : "",
          intervalId: selectedIntervals?.intervalID ?? null,
          assetId: singleAssetDetail!.assetUid!,
          description: descriptionController.text,
          initialOccurence: int.parse(frequencyController.text),
          intervalName: namecontroller.text,
          make: singleAssetDetail!.makeCode!,
          model: singleAssetDetail!.model!,
          serialno: singleAssetDetail!.assetSerialNumber!,
          currentHrmeter: singleAssetDetail?.hourMeter?.toDouble() ?? null,
          checkList: maintenanceCheckList);
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  clearAllValue() {
    namecontroller.clear();
    frequencyController.clear();
    descriptionController.clear();
    checkListData.clear();
    maintenanceCheckList.clear();

    notifyListeners();
  }

  onIntervalSaved() async {
    try {
      if (namecontroller.text.isEmpty) {
        snackbarService!.showSnackbar(message: "Please Enter Interval Name");
        return;
      }
      print("validation 1");
      if (frequencyController.text.isEmpty) {
        snackbarService!
            .showSnackbar(message: "Please Enter Checklist Frequency");
        return;
      }
      print("validation 2");
      if (checkListData.isNotEmpty &&
          checkListData.any((element) => element.checkListName!.text.isEmpty)) {
        snackbarService!.showSnackbar(message: "Please Enter Checklist Name");
        return;
      }
      print("validation 3");
      if (checkListData.any((element) =>
          element.partListData != null && element.partListData!.isNotEmpty)) {
        if (checkListData.any((element) => element.partListData!.any(
            (element) =>
                element.part!.text.isEmpty ||
                element.partName!.text.isEmpty ||
                element.quantity!.text.isEmpty))) {
          snackbarService!
              .showSnackbar(message: "Please Fill The Parts Details");
          return;
        }
      }
      print("validation 4");

      showLoadingDialog();
      await gettingUserData();
      var data;
      Logger().w(maintenanceInterval!.intervalId);
      maitenanceCheckListData = AddMaintenanceIntervalPayload(
          assetId: maintenanceInterval!.assetId,
          currentHourMeter: maintenanceInterval!.currentHrmeter,
          description: maintenanceInterval!.description,
          initialOccurence: maintenanceInterval!.initialOccurence,
          intervalName: maintenanceInterval!.intervalName,
          make: maintenanceInterval!.make,
          model: maintenanceInterval!.model,
          serialNumber: maintenanceInterval!.serialno,
          checklist: maintenanceInterval!.checkList!.isEmpty
              ? null
              : maintenanceInterval!.checkList!
                  .map((e) => MaitenanceCheckListDataPayLoad(
                      checkListName: e.checkName,
                      partList: e.partList!
                          .map((part) => PartListDataPayLoad(
                              partName: part.partName,
                              partNo: part.partNo,
                              quantity: part.quantiy,
                              units: part.units!.toLowerCase()))
                          .toList()))
                  .toList());
      Logger().w(maitenanceCheckListData!.toJson());
      if (isEditing) {
        // EditIntervalResponse? data = await _maintenanceService!
        //     .updateMaintenanceIntervals(_graphqlSchemaService!
        //         .updateMaintenanceIntervals(maintenanceInterval));
        // if (data != null) {
        //   Logger().w(data.updateMaintenanceIntervals!.message);
        // }
      } else {
        data = await _maintenanceService!.addMaintenanceIntervals(
            _graphqlSchemaService!.addMaintenanceIntervals(),
            maitenanceCheckListData);
      }

      snackbarService!.showSnackbar(message: data["message"]);
      if (data["status"] == "failure") {
        hideLoadingDialog();
      } else {
        hideLoadingDialog();
        goToManage();
        clearAllValue();
      }
    } catch (e) {
      hideLoadingDialog();
      Logger().e(e.toString());
    }
  }

  editInterval() async {
    try {
      showLoadingDialog();
      await gettingUserData();
      Map<String, dynamic> updateInterval = {
        "intervalList": Utils.updateMaintenanceIntervals(maintenanceInterval),
        "checkList":
            Utils.updateMaintenanceCheckList(maintenanceInterval!.checkList)
      };
      //EditIntervalResponse?
      EditIntervalResponse intervalData = await _maintenanceService!
          .updateMaintenanceIntervals(
              _graphqlSchemaService!.updateMaintenanceIntervals(), updateInterval);
      if (intervalData != null) {
        // Logger().wtf(intervalData.updateMaintenanceIntervals!.message);
        snackbarService!.showSnackbar(
            message: "Interval/Checklist/Partlist Updated Successfully!!!");
        hideLoadingDialog();
        goToManage();
      }
    } catch (e) {
      hideLoadingDialog();
      Logger().e(e.toString());
    }
  }

  goToManage() async {
    isLoading = true;
    switchState.clear();
    notifyListeners();
    onClickingBackInAddInterval();
    await getMaintenanceIntervals();
  }

  onEditIntervalsinManage() async {
    namecontroller.text = selectedIntervals?.intervalName ?? "";
    frequencyController.text =
        selectedIntervals?.firstOccurrences.toString() ?? "";
    descriptionController.text = selectedIntervals?.intervalDescription ?? "";
    checkListData.clear();
    if (selectedIntervals!.checkList != null &&
        selectedIntervals!.checkList!.isNotEmpty) {
      for (var checkData in selectedIntervals!.checkList!) {
        Logger().w(checkData.checkListID);
        CheckAndPartList editedCheckData = CheckAndPartList(
            checkListName: TextEditingController(text: checkData.checkListName),
            partListData: [],
            checkListId: checkData.checkListID,
            intervalId: selectedIntervals!.intervalID,
            expansionState: false);
        for (var partData in checkData.partList!) {
          PartListDataClass editedPartData = PartListDataClass(
              part: TextEditingController(text: partData.partNo),
              partName: TextEditingController(text: partData.partName),
              partId: partData.partId,
              quantity:
                  TextEditingController(text: partData.quantity.toString()));
          editedCheckData.partListData?.add(editedPartData);
        }
        checkListData.add(editedCheckData);
      }
    }
    isEditing = true;
    notifyListeners();
    pageController!.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  onDeletingIntervals() async {
    intervalId.clear();
    partListId.clear();
    checkListId.clear();
    selectedIntervals = null;
    var selectedIntervalList =
        switchState.where((element) => element.state == true).toList();
    var data = maintenanceIntervalsData!.intervalList!
        .where((intervalist) => selectedIntervalList
            .any((element) => element.text == intervalist.intervalName))
        .toList();
    for (var interval in data) {
      intervalId.add(interval.intervalID!);
      for (var checkList in interval.checkList!) {
        checkListId.add(checkList.checkListID!);
        for (var partList in checkList.partList!) {
          partListId.add(partList.partId!);
        }
      }
    }
    showLoadingDialog();
    var deleteData = await _maintenanceService!.deletMaintenanceIntervals(
        graphqlSchemaService!.deletingMaintenanceIntervals(
            assetId: assetUid,
            check: checkListId,
            interval: intervalId,
            parts: partListId));
    switchState.removeWhere((ele) => ele.state == true);
    hideLoadingDialog();
    notifyListeners();
  }
}

class CheckAndPartList {
  final TextEditingController? checkListName;
  bool? expansionState;
  final List<PartListDataClass>? partListData;
  int? checkListId;
  int? intervalId;

  CheckAndPartList(
      {this.checkListName,
      this.partListData,
      this.expansionState = false,
      this.checkListId,
      this.intervalId});
}

class PartListDataClass {
  final TextEditingController? partName;
  final TextEditingController? part;
  final TextEditingController? quantity;
  List<String>? items;
  String? value;
  int? partId;
  PartListDataClass({
    this.part,
    this.partName,
    this.quantity,
    this.partId,
    this.value,
    this.items = const ["Kg", "Gallon", "None"],
  });
}

class MaintenanceIntervalData {
  String? intervalName;
  int? initialOccurence;
  String? description;
  String? assetId;
  String? serialno;
  String? make;
  String? model;
  double? currentHrmeter;
  int? intervalId;
  String? intervalDescription;
  List<MaintenanceCheckList>? checkList;
  List<MaintenanceIntervalList>? intervalList;
  MaintenanceIntervalData(
      {this.assetId,
      this.checkList,
      this.currentHrmeter,
      this.description,
      this.initialOccurence,
      this.intervalName,
      this.make,
      this.model,
      this.serialno,
      this.intervalDescription,
      this.intervalId});
}

class MaintenanceCheckList {
  String? checkName;
  int? checkListId;
  List<MaintenancePartList>? partList;
  MaintenanceCheckList({this.checkName, this.partList, this.checkListId});
}

class MaintenanceIntervalList {
  String? intervalName;
  int? intervalID;
  int? firstOccurences;
  String? intervalDescription;
  MaintenanceIntervalList(
      {this.firstOccurences,
      this.intervalDescription,
      this.intervalID,
      this.intervalName});
}

class MaintenancePartList {
  String? description;
  String? units;
  String? partName;
  String? partNo;
  int? quantiy;
  int? partId;
  MaintenancePartList(
      {this.description,
      this.partName,
      this.partNo,
      this.quantiy,
      this.units,
      this.partId});
}
