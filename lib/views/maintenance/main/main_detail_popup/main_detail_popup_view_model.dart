import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/complete.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_checkList.dart';
import 'package:insite/core/models/maintenance_list_india_stack.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/models/serviceItem.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/maintenance/asset/asset/detail_popup/detail_popup_view.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class MainDetailPopupViewModel extends InsiteViewModel {
  Logger? log;
  ScrollController? scrollController;
  MaintenanceService? _maintenanceService = locator<MaintenanceService>();
  NavigationService? _navigationService = locator<NavigationService>();

  String? _serviceName = "";
  String? get serviceName => _serviceName;

  String? _performedBy = "";
  String? get performedBy => _performedBy;

  String? _serviceNotes = "";
  String? get serviceNotes => _serviceNotes;

  String? _assetId = "";
  String? get assetId => _assetId;
  String? _serialNo = "";
  String? get serialNo => _serialNo;
  String? _makeCode = "";
  String? get makecode => _makeCode;
  String? _assetUid = "";
  String? get assetUid => _assetUid;
  String? _model = "";
  String? get model => _model;

  String? _serviceId = "0";
  String? get serviceId => _serviceId;

  num? _occurenceId = 0;
  num? get occurenceId => _occurenceId;

  // List<Checklists>? _checkLists = [];
  // List<Checklists>? get checkLists => _checkLists;

  List<MaitenanceCheckListDataPop>? _checkLists = [];
  List<MaitenanceCheckListDataPop>? get checkLists => _checkLists;

  updatePerformedValue(String? value) {
    _performedBy = value;
    notifyListeners();
  }

  // updateWorkOrder(String? value) {
  //   _workOrder = value;
  //   notifyListeners();
  // }

  updateServiceNotes(String? value) {
    _serviceNotes = value;
    notifyListeners();
  }

  List<String?>? _serviceList = [];
  List<String?>? get serviceList => _serviceList;

  MainPopViewDropDown? initialValue;
  List<MainPopViewDropDown>? dropDown = [];
  //List<Dummy> dummyDrop =;
  Dummy intdata = Dummy(data: "api");
  MainPopViewData? mainPopViewData;
  int pageNumber = 1;
  int pageSize = 20;
  int selectedIndex = 0;

  MainDetailPopupViewModel({AssetData? assetDataValue, int? serviceNo}) {
    this.log = getLogger(this.runtimeType.toString());
    scrollController = ScrollController();
    _maintenanceService!.setUp();
    // services!.forEach((element) {
    //   if (serviceList!.contains(element!.serviceName)) {
    //   } else {
    //     serviceList!.add(element.serviceName);
    //   }
    // });
    serviceNumber = serviceNo;
    Future.delayed(Duration.zero, () async {
      await getMaintenanceCheckList(serviceNo);
      await mainPopview(assetData: assetDataValue);
    });

    // _occurenceId = serviceItem.dueInfo!.occurrenceId;

    // _assetId = assetDataValue.assetID == null
    //     ? summaryData.assetID
    //     : assetDataValue.assetID;
    // _serialNo = assetDataValue.assetSerialNumber == null
    //     ? summaryData.assetSerialNumber
    //     : assetDataValue.assetSerialNumber;
    // _makeCode = assetDataValue.makeCode == null
    //     ? summaryData.makeCode
    //     : assetDataValue.makeCode;
    // _model =
    //     assetDataValue.model == null ? summaryData.model : assetDataValue.model;
  }

  //Todo: change initial value to true once api integration is done.
  bool _loading = true;
  bool get loading => _loading;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _isCheckList = false;
  bool get isCheckList => _isCheckList;

  bool _isinitialCheckList = true;
  bool get isinitialCheckList => _isinitialCheckList;

  int? serviceNumber;

  TextEditingController workOrderDateController =
      TextEditingController(text: "");
  TextEditingController hourMeterDateController =
      TextEditingController(text: "");
  TextEditingController workHourController = TextEditingController(text: "");
  TextEditingController performedByController = TextEditingController(text: "");
  TextEditingController serviceMeterController =
      TextEditingController(text: "");
  TextEditingController serviceNoteController = TextEditingController(text: "");
  MaintenanceCheckListModelPop? serviceCheckList;
  String? hourMeterDate;
  getSelectedDate(DateTime? newDate) {
    hourMeterDateController.text =Utils.getDateFormatForDatePicker(newDate.toString(),userPref);
        //Utils.getDateInFormatddMMyyyy(newDate.toString());
    hourMeterDate = newDate!.toLocal().toIso8601String();
    notifyListeners();
  }

  onTabChange(int i) {
    selectedIndex = i;
    notifyListeners();
  }

  updateModelValue(MainPopViewDropDown? onchangedValue) async {
    try {
      showLoadingDialog();
      await getMaintenanceCheckList(onchangedValue!.serviceNo);
      initialValue = onchangedValue;
      // if (serviceCheckList!.maintenanceCheckList!
      //     .any((element) => element.checkListID == null)) {
      //   _checkLists!.clear();
      // } else {
      _checkLists = serviceCheckList?.maintenanceCheckList;
      // }

      hideLoadingDialog();
      notifyListeners();
    } catch (e) {}
  }

  getMaintenanceCheckList(int? serviceId) async {
    serviceCheckList = await _maintenanceService!
        .getMaintenanceServiceItemCheckList(
            query: graphqlSchemaService!
                .getMaitenanceCheckList(serviceNo: serviceId));
  }

  mainPopview({AssetData? assetData}) async {
    await getSelectedFilterData();
    await getDateRangeFilterData();
    MaintenanceListData? maintenanceListData = await _maintenanceService!
        .getMaintenanceListData(
            startTime: Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
            endTime: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
            limit: pageSize,
            page: pageNumber,
            query: await graphqlSchemaService!.getMaintenanceListData(
                assetId: assetData!.assetID,
                startDate:
                    Utils.maintenanceFromDateFormate(maintenanceStartDate!),
                endDate: Utils.maintenanceToDateFormate(maintenanceEndDate!),
                limit: pageSize,
                pageNo: pageNumber));
    dropDown!.clear();
    var singleMaintenanceList = maintenanceListData!.maintenanceList!
        .singleWhere((element) => element.serviceNumber == serviceNumber);
    initialValue = MainPopViewDropDown(
        serviceNo: singleMaintenanceList.serviceNumber,
        initialValue: singleMaintenanceList.serviceName,
        partList: serviceCheckList?.maintenanceCheckList);
    _checkLists = initialValue?.partList;
    dropDown!.add(initialValue!);

    serviceMeterController.text =
        maintenanceListData.maintenanceList!.first.currentHourMeter.toString();
    mainPopViewData = MainPopViewData(
        dueAt: maintenanceListData.maintenanceList!.first.dueAt,
        dueDate: maintenanceListData.maintenanceList!.first.dueDate,
        hourmeter: maintenanceListData.maintenanceList!.first.currentHourMeter
            .toString(),
        odometer:
            maintenanceListData.maintenanceList!.first.odometer.toString(),
        overdueBy:
            maintenanceListData.maintenanceList!.first.dueInOverdueBy!.toInt(),
        prodfamily: maintenanceListData.maintenanceList!.first.productFamily,
        make: maintenanceListData.maintenanceList!.first.make,
        model: maintenanceListData.maintenanceList!.first.model,
        serialNo: maintenanceListData.maintenanceList!.first.serialNumber);
    serviceCheckList?.maintenanceServiceList?.forEach((serviceList) {
      if (serviceList.serviceId == serviceNumber) {
      } else {
        dropDown!.add(MainPopViewDropDown(
            initialValue: serviceList.serviceName,
            partList: [],
            serviceNo: serviceList.serviceId));
        _isinitialCheckList = false;
      }
    });

    _assetId = assetData.assetID;
    // Logger().w(initialValue!.initialValue);
    // Logger().i(initialValue!.partList!.length);
    // dropDown!.forEach((element) {
    //   Logger().wtf(element.initialValue);
    //   Logger().v(element.partList!.length);
    // });

    _loading = false;
    notifyListeners();
  }

  onReset() {
    workOrderDateController.text = "";

    hourMeterDateController.text = "";

    workHourController.text = "";
    performedByController.text = "";
    serviceMeterController.text = "";

    serviceNoteController.text = "";
    notifyListeners();
  }

  onComplete() async {
    try {
      if (performedByController.text.isEmpty) {
        Fluttertoast.showToast(msg: "PerformedBy field is Requierd");
        return;
      }

      if (hourMeterDateController.text.isEmpty) {
        Fluttertoast.showToast(msg: "Service Date field is Requierd");
        return;
      }

      if (serviceMeterController.text.isEmpty) {
        Fluttertoast.showToast(msg: "Service Meter field is Requierd");
        return;
      }

      if (serviceNoteController.text.isEmpty) {
        Fluttertoast.showToast(msg: "Service Note field is Requierd");
        return;
      }

      showLoadingDialog();
      if (isVisionLink) {
        Complete? complete = await _maintenanceService!.complete(
            serviceDate: hourMeterDateController.text,
            hourMeter: int.parse(hourMeterDateController.text),
            performedBy: performedBy,
            serviceNotes: serviceNotes,
            workOrder: workOrderDateController.text,
            serviceId: int.parse(_serviceId!),
            occurenceId: _occurenceId!.toInt(),
            assetUid: _assetUid,
            assetId: _assetId,
            serialNumber: _serialNo,
            makecode: _makeCode,
            model: _model,
            checkListId: _isCheckList ? 0 : 0,
            checkListName: _isCheckList ? "" : "",
            isComplete: _isCheckList ? false : true);
        _isCheckList
            ? Utils.showToast("checklist saved")
            : complete == null
                ? Utils.showToast(
                    "Maintenance Service Date Is Greater Last Serviced Date")
                : Utils.showToast("Success");
      } else {
        var data = await _maintenanceService!.onCompletion(graphqlSchemaService!
            .onCompletion(
                assetId: _assetId,
                performedBy: performedByController.text,
                serviceDate: hourMeterDate,
                serviceMeter:
                    num.parse(serviceMeterController.text).toInt().toString(),
                serviceNo: serviceNumber,
                serviceNotes: serviceNoteController.text,
                workOrder: workOrderDateController.text));
        if (data != null) {
          if (data.data["maintenancepostData"] != null) {
            snackbarService!.showSnackbar(
                message: data.data["maintenancepostData"]["message"]);
            dispose();
            hideLoadingDialog();
            return data.data["maintenancepostData"]["message"];
          }
        }
      }
      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
      Logger().w(e.toString());
    }
  }

  void dispose() {
    hourMeterDateController.dispose();
    workHourController.dispose();
    serviceMeterController.dispose();
    serviceNoteController.dispose();
    workOrderDateController.dispose();
  }
}

class MainPopViewData {
  final String? serialNo;
  final String? prodfamily;
  final String? hourmeter;
  final String? odometer;
  final int? dueAt;
  final int? overdueBy;
  final String? dueDate;
  final String? make;
  final String? model;
  MainPopViewData(
      {this.dueAt,
      this.make,
      this.model,
      this.dueDate,
      this.hourmeter,
      this.odometer,
      this.overdueBy,
      this.prodfamily,
      this.serialNo});
}

class MainPopViewDropDown {
  final String? initialValue;
  final int? serviceNo;
  final List<MaitenanceCheckListDataPop>? partList;
  MainPopViewDropDown({this.initialValue, this.partList, this.serviceNo});
}

class Dummy {
  final String? data;
  Dummy({this.data});
}
