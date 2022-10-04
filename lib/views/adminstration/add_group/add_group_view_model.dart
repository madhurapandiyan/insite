import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_group_data_response.dart';
import 'package:insite/core/models/edit_group_payload.dart';
import 'package:insite/core/models/add_group_payload.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/edit_group_response.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/add_group/model/add_group_model.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:insite/views/adminstration/manage_group/manage_group_view.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';

import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/services/graphql_schemas_service.dart';

class AddGroupViewModel extends InsiteViewModel {
  Logger? log;
  NavigationService? _navigationService = locator<NavigationService>();
  final AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();
  final SnackbarService? _snackBarservice = locator<SnackbarService>();
  GraphqlSchemaService? graphqlSchemaService = locator<GraphqlSchemaService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final Geofenceservice? _geofenceservice = locator<Geofenceservice>();

  Groups? groups;
  List<AddGroupModel>? selectedAssetDisplayList = [];

  String? assetSelectionValue;

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  TextEditingController selectedItemController = TextEditingController();

  List<String> _choiseData = ["Assets", "Geofences", "Groups"];
  List<String> get choiseData => _choiseData;

  Customer? accountSelected;

  bool _isAssetLoading = true;
  bool get isAssetLoading => _isAssetLoading;

  List<String> _assetId = [];
  List<String> get assetId => _assetId;

  AssetGroupSummaryResponse? assetIdresult;

  List<String> _assetSerialNumber = [];
  List<String> get assetSerialNumber => _assetSerialNumber;

  List<String> associatedAssetId = [];
  List<String> dissociatedAssetId = [];

  List<String> dropDownList = ["All", "ID", "S/N"];

  String initialValue = "All";

  List<Asset>? selectedAsset = [];

  bool isLoading = true;

  AddGroupViewModel(Groups? groups) {
    this.groups = groups;
    this.log = getLogger(this.runtimeType.toString());
    _manageUserService!.setUp();

    Future.delayed(Duration(seconds: 1), () async {
      getData();
      await getGroupListData();
      if (groups != null) {
        nameController.text = groups.GroupName ?? "";
        descriptionController.text = groups.Description ?? "";
        if (assetIdresult?.assetDetailsRecords != null &&
            assetIdresult!.assetDetailsRecords!.isNotEmpty) {
          for (var asset in assetIdresult!.assetDetailsRecords!) {
            if (groups.AssetUID!
                .any((element) => element == asset.assetIdentifier)) {
              selectedAsset!.add(asset);
            }
          }
        }
      }
    });
  }

  updateModelValueChooseBy(String value) async {
    if (value == assetSelectionValue) {
      return;
    }
    showLoadingDialog();
    assetSelectionValue = value;
    if (value == choiseData[1]) {
      var geofenceData = await _geofenceservice!.getGeofenceData();
      assetIdresult = AssetGroupSummaryResponse(
          assetDetailsRecords: geofenceData!.geofences!
              .map((e) => Asset(
                    assetIdentifier: e.GeofenceUID,
                    assetSerialNumber: e.GeofenceName,
                  ))
              .toList());
              Logger().w(assetIdresult!.assetDetailsRecords!.first.toJson());
    } else if (value == choiseData[2]) {
      var groupResult =
          await _manageUserService!.getManageGroupSummaryResponseListData(
              1,
              {
                "pageNumber": 1,
                "searchKey": "GroupName",
                "searchValue": _searchKeyword,
                "sort": ""
              },
              _searchKeyword);
      assetIdresult = AssetGroupSummaryResponse(
          assetDetailsRecords: groupResult!.groups!
              .map((e) => Asset(
                    assetIdentifier: e.GroupUid,
                    assetSerialNumber: e.GroupName,
                  ))
              .toList());
    } else {
      await getGroupListData();
    }
    hideLoadingDialog();
    notifyListeners();
  }

  List<String> assetUidData = [];

  // AssetGroupSummaryResponse? assetIdresult;

  getAddGroupSaveData() async {
    try {
      if (nameController.text.isEmpty) {
        _snackBarservice!.showSnackbar(message: "Name should be specified");
        return;
      }
      assetUidData.clear();
      selectedAsset?.forEach((element) {
        Logger().wtf(element.assetIdentifier);
        assetUidData.add(element.assetIdentifier!);
      });

      showLoadingDialog(tapDismiss: true);
      AddGroupDataResponse? result =
          await _manageUserService!.getAddGroupSaveData(
        addGroupPayLoad: AddGroupPayLoad(
          AssetUID: assetUidData,
          Description: descriptionController.text,
          GroupName: nameController.text,
        ),
        gqlPayload: {
          "assetUID": assetUidData,
          "description": descriptionController.text,
          "groupName": nameController.text
        },
        query: graphqlSchemaService?.createGroup(),
      );
      if (result != null) {
        _snackBarservice!.showSnackbar(message: "You have added a new group");
        gotoManageGroupPage();
        hideLoadingDialog();
      } else {
        _snackBarservice!
            .showSnackbar(message: "Something wents wrong try again later");
        hideLoadingDialog();
      }
      Logger().i(result);
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
    notifyListeners();
  }

  onRemoving() {
    selectedAsset!.clear();
    notifyListeners();
  }

  getEditGroupData() async {
    try {
      showLoadingDialog();
      EditGroupResponse? result =
          await _manageUserService!.getEditGroupData(groups!.GroupUid!);
      if (result != null) {
        nameController.text = result.GroupName!;
        descriptionController.text = result.Description ?? "";
        if (result.AssetUID != null) {
          for (var i = 0; i < result.AssetUID!.length; i++) {
            assetUidData.add(result.AssetUID![i]);
          }
          Logger().i("assetUId:${assetUidData.length}");
        }
      }

      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  getGroupListData() async {
    try {
      assetIdresult = await _manageUserService!.getGroupListData(false);
      notifyListeners();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      hideLoadingDialog();
      notifyListeners();
      Logger().e(e.toString());
    }
  }

  onAddingAsset(int i, dynamic selectedData) {
    if (selectedData != null) {
      assetIdresult?.assetDetailsRecords?.remove(selectedData);
      selectedAsset?.add(selectedData);
    }
    notifyListeners();
  }

  onAddingAllAsset(List<Asset>? allAsset) {
    if (allAsset != null && allAsset.isNotEmpty) {
      selectedAsset!.clear();
      selectedAsset?.addAll(allAsset);
    }
    notifyListeners();
  }

  onRemove() {
    selectedAsset!.clear();
    notifyListeners();
  }

  onDeletingAsset(int i) {
    try {
      if (selectedAsset != null) {
        Logger().e(selectedAsset?.length);
        var data = selectedAsset?.elementAt(i);
        assetIdresult?.assetDetailsRecords?.add(data!);
        selectedAsset?.removeAt(i);
        Logger().e(selectedAsset?.length);
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onChangingInitialValue(value) {
    initialValue = value;
    notifyListeners();
  }

  void getData() {
    if (groups != null) {
      getEditGroupData();
    } else {}
    hideLoadingDialog();
    notifyListeners();
  }

  getAddGroupEditData() async {
    try {
      Logger().i(dissociatedAssetId);
      assetUidData.clear();
      selectedAsset?.forEach((element) {
        Logger().wtf(element.assetIdentifier);
        assetUidData.add(element.assetIdentifier!);
      });
      showLoadingDialog();
      UpdateResponse? result = await _manageUserService!.getAddGroupEditPayLoad(
        EditGroupPayLoad(
            GroupName: nameController.text,
            GroupUid: groups!.GroupUid!,
            CustomerUID: "d7ac4554-05f9-e311-8d69-d067e5fd4637",
            Description: descriptionController.text,
            AssociatedAssetUID: associatedAssetId,
            DissociatedAssetUID: dissociatedAssetId),
        graphqlSchemaService!.updateGroup(),
        {
          "assetUID": assetUidData,
          "groupUid": groups!.GroupUid,
          "description": descriptionController.text,
          "groupName": nameController.text,
          "dissociatedAssetUID": []
        },
      );
      if (result != null) {
        gotoManageGroupPage();
      }
      hideLoadingDialog();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  gotoManageGroupPage() {
    _navigationService!.clearTillFirstAndShowView(ManageGroupView());
  }
}
