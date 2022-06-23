import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_detail.dart';
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
  Timer? deBounce;
  IntervalList? selectedIntervals;
  List<int> intervalId = [];
  List<int> checkListId = [];
  List<int> partListId = [];
  bool isEditing = false;
  bool isValidating = false;

  String doubleQuote = "\"";
  AddIntervalsViewModel({AssetDetail? assetDetail}) {
    this.log = getLogger(this.runtimeType.toString());
    singleAssetDetail = assetDetail;
    assetUid = assetDetail!.assetUid;
    getMaintenanceIntervals();
  }

  onSwitchTaped(int i) {
    switchState[i].state = !switchState[i].state!;
    var intervalName = switchState[i].text;
    Logger().w(intervalName);
    selectedIntervals = maintenanceIntervalsData!.intervalList!
        .singleWhere((element) => element.intervalName == intervalName);

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
    notifyListeners();
  }

  onSearching() async {
    try {
      if (deBounce!.isActive) {
        deBounce!.cancel();
      } else {
        deBounce = Timer(Duration(seconds: 2), () async {
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
          SwitchState data = SwitchState(text: item.intervalName, state: false);
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
    data.partListData!.add(PartListData(
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
    value = int.parse(
        frequencyController.text.isEmpty ? "0" : frequencyController.text);
    value = value! - 1;
    frequencyController.text = value.toString();
  }

  gettingUserData() {
    try {
      if (checkListData.isNotEmpty) {
        maintenanceCheckList.clear();
        List<MaintenancePartList> maintenancePartList = [];
        for (var checkList in checkListData) {
          MaintenanceCheckList mainCheckList = MaintenanceCheckList(
              checkName:
                  doubleQuote + checkList.checkListName!.text + doubleQuote,
              checkListId: checkList.checkListId,
              partList: []);

          for (var partList in checkList.partListData!) {
            MaintenancePartList mainPartList = MaintenancePartList(
                partId: partList.partId,
                partNo: doubleQuote + partList.part!.text + doubleQuote,
                partName: doubleQuote + partList.partName!.text + doubleQuote,
                quantiy: int.parse(partList.quantity!.text.isEmpty
                    ? "0"
                    : partList.quantity!.text));

            mainCheckList.partList?.add(mainPartList);
          }
          maintenanceCheckList.add(mainCheckList);
        }
        print("mappi");
        maintenanceInterval = MaintenanceIntervalData(
            intervalDescription: selectedIntervals?.intervalDescription != null
                ? (doubleQuote +
                    selectedIntervals!.intervalDescription! +
                    doubleQuote)
                : "",
            intervalId: selectedIntervals?.intervalID ?? null,
            assetId: doubleQuote + singleAssetDetail!.assetUid! + doubleQuote,
            description: doubleQuote + descriptionController.text + doubleQuote,
            initialOccurence: int.parse(frequencyController.text),
            intervalName: doubleQuote + namecontroller.text + doubleQuote,
            make: doubleQuote + singleAssetDetail!.makeCode! + doubleQuote,
            model: doubleQuote + singleAssetDetail!.model! + doubleQuote,
            serialno: doubleQuote +
                singleAssetDetail!.assetSerialNumber! +
                doubleQuote,
            currentHrmeter: null,
            checkList: maintenanceCheckList);
      }
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
      if (frequencyController.text.isEmpty) {
        snackbarService!
            .showSnackbar(message: "Please Enter Checklist Frequency");
        return;
      }
      if (checkListData.isNotEmpty &&
          checkListData.any((element) => element.checkListName!.text.isEmpty)) {
        snackbarService!.showSnackbar(message: "Please Enter Checklist Name");
        return;
      }
      if (checkListData.any((element) => element.partListData!.any((element) =>
          element.part!.text.isEmpty ||
          element.partName!.text.isEmpty ||
          element.quantity!.text.isEmpty))) {
        snackbarService!.showSnackbar(message: "Please Fill The Parts Details");
        return;
      }
      showLoadingDialog();
      await gettingUserData();
      var data;
      Logger().w(maintenanceInterval!.intervalId);
      if (isEditing) {
        data = await _maintenanceService!.updateMaintenanceIntervals(
            _graphqlSchemaService!
                .updateMaintenanceIntervals(maintenanceInterval));
      } else {
        data = await _maintenanceService!.addMaintenanceIntervals(
            _graphqlSchemaService!
                .addMaintenanceIntervals(maintenanceInterval));
      }

      snackbarService!.showSnackbar(message: data["message"]);
      if (data["status"] == "failure") {
        hideLoadingDialog();
      } else {
        goToManage();
        clearAllValue();
      }
    } catch (e) {
      hideLoadingDialog();
      Logger().e(e.toString());
    }
  }

  goToManage() async {
    switchState.clear();
    await getMaintenanceIntervals();
    onClickingBackInAddInterval();
    hideLoadingDialog();
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
          PartListData editedPartData = PartListData(
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
  final List<PartListData>? partListData;
  int? checkListId;
  int? intervalId;
  CheckAndPartList(
      {this.checkListName,
      this.partListData,
      this.expansionState = false,
      this.checkListId,
      this.intervalId});
}

class PartListData {
  final TextEditingController? partName;
  final TextEditingController? part;
  final TextEditingController? quantity;
  int? partId;
  PartListData({this.part, this.partName, this.quantity, this.partId});
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
