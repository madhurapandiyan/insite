import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/complete.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/models/serviceItem.dart';
import 'package:insite/core/services/maintenance_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/maintenance/asset/asset/detail_popup/detail_popup_view.dart';
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

  String? _hourMeter = "";
  String? get hourMeter => _hourMeter;

  String? _odoMeter = "";
  String? get odoMeter => _odoMeter;

  String? _dueAt = "";
  String? get dueAt => _dueAt;

  String? _overdueBy = "";
  String? get overdueBy => _overdueBy;

  String? _dueDate = "";
  String? get dueDate => _dueDate;

  String? _performedBy = "";
  String? get performedBy => _performedBy;

  String? _workOrder = "";
  String? get workOrder => _workOrder;

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

  num? _serviceId = 0;
  num? get serviceId => _serviceId;

  num? _occurenceId = 0;
  num? get occurenceId => _occurenceId;

  List<Checklists>? _checkLists = [];
  List<Checklists>? get checkLists => _checkLists;

  updatePerformedValue(String? value) {
    _performedBy = value;
    notifyListeners();
  }

  updateWorkOrder(String? value) {
    _workOrder = value;
    notifyListeners();
  }

  updateServiceNotes(String? value) {
    _serviceNotes = value;
    notifyListeners();
  }

  List<String?>? _serviceList = [];
  List<String?>? get serviceList => _serviceList;

  MainDetailPopupViewModel(ServiceItem? serviceItem, AssetData? assetDataValue,
      List<Services?>? services, SummaryData? summaryData) {
    this.log = getLogger(this.runtimeType.toString());
    scrollController = ScrollController();
    services!.forEach((element) {
      if (serviceList!.contains(element!.serviceName)) {
      } else {
        serviceList!.add(element.serviceName);
      }
    });

    _serviceName = serviceItem!.serviceName;
    _serviceId = serviceItem.serviceId;
    _hourMeter = assetDataValue!.currentHourmeter == null
        ? summaryData!.currentHourMeter!.toStringAsFixed(0)
        : assetDataValue.currentHourmeter!.toStringAsFixed(0);
    _odoMeter = summaryData!.currentOdometer!.toStringAsFixed(0);

    _dueAt = serviceItem.dueInfo!.dueAt!.toStringAsFixed(0);
    _overdueBy = serviceItem.dueInfo!.dueBy!.abs().toStringAsFixed(0);
    _dueDate = serviceItem.dueInfo!.dueDate;

    _occurenceId = serviceItem.dueInfo!.occurrenceId;
    _assetUid = assetDataValue.assetUID == null
        ? summaryData.assetUID
        : assetDataValue.assetUID;
    _assetId = assetDataValue.assetID == null
        ? summaryData.assetID
        : assetDataValue.assetID;
    _serialNo = assetDataValue.assetSerialNumber == null
        ? summaryData.assetSerialNumber
        : assetDataValue.assetSerialNumber;
    _makeCode = assetDataValue.makeCode == null
        ? summaryData.makeCode
        : assetDataValue.makeCode;
    _model =
        assetDataValue.model == null ? summaryData.model : assetDataValue.model;
  }

  //Todo: change initial value to true once api integration is done.
  bool _loading = false;
  bool get loading => _loading;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _isCheckList = false;
  bool get isCheckList => _isCheckList;

  TextEditingController hourMeterDateController = TextEditingController(
      text: Utils.getDateInFormatddMMyyyy(
          DateTime.now().subtract(Duration(days: 1)).toString()));

  getSelectedDate(String newDate) {
    hourMeterDateController.text = newDate;

    notifyListeners();
  }

  updateModelValue(String? onchangedValue, List<Services?>? service) async {
    _serviceName = onchangedValue!;

    service!.forEach((element) async {
      if (_serviceName == element!.serviceName) {
        _serviceId = element.serviceId;

        ServiceItem? serviceItem =
            await _maintenanceService!.getServiceItemCheckList(_serviceId);

        _dueAt = serviceItem!.dueInfo!.dueAt!.toStringAsFixed(0);
        _overdueBy = serviceItem.dueInfo!.dueBy!.abs().toStringAsFixed(0);
        _dueDate = serviceItem.dueInfo!.dueDate;
        _checkLists = serviceItem.checklists;

        notifyListeners();
      }
    });
    notifyListeners();
  }

  onComplete(num id, String name, bool check) async {
    _isCheckList = check;
    Complete? complete = await _maintenanceService!.complete(
        serviceDate: hourMeterDateController.text,
        hourMeter: int.parse(hourMeter!),
        performedBy: performedBy,
        serviceNotes: serviceNotes,
        workOrder: workOrder,
        serviceId: _serviceId!.toInt(),
        occurenceId: _occurenceId!.toInt(),
        assetUid: _assetUid,
        assetId: _assetId,
        serialNumber: _serialNo,
        makecode: _makeCode,
        model: _model,
        checkListId: _isCheckList ? id : 0,
        checkListName: _isCheckList ? name : "",
        isComplete: _isCheckList ? false : true);
    _isCheckList
        ? Utils.showToast("checklist saved")
        : complete == null
            ? Utils.showToast(
                "Maintenance Service Date Is Greater Last Serviced Date")
            : Utils.showToast("Success");
  }
}
