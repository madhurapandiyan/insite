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
import 'package:insite/views/adminstration/add_group/selection_widget/selection_widget_view_model.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:insite/views/adminstration/manage_group/manage_group_view.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';

import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AddGroupViewModel extends InsiteViewModel {
  Logger? log;
  NavigationService? _navigationService = locator<NavigationService>();
  final AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();
  final SnackbarService? _snackBarservice = locator<SnackbarService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Groups? groups;

  Customer? accountSelected;

  AssetGroupSummaryResponse? groupSummaryResponseData;

  List<String> associatedAssetId = [];
  List<String> dissociatedAssetId = [];

  AddGroupViewModel(Groups? groups) {
    this.groups = groups;
    this.log = getLogger(this.runtimeType.toString());
    _manageUserService!.setUp();

    Future.delayed(Duration(seconds: 1), () {
      getData();
    });
  }
  List<String> assetUidData = [];

  getAddGroupSaveData() async {
    try {
      if (nameController.text.isEmpty) {
        _snackBarservice!.showSnackbar(message: "Name should be specified");
        return;
      }

      showLoadingDialog();
      AddGroupDataResponse? result =
          await _manageUserService!.getAddGroupSaveData(
        AddGroupPayLoad(
          AssetUID: assetUidData,
          Description: descriptionController.text,
          GroupName: nameController.text,
        ),
      );
      if (result != null) {
        gotoManageGroupPage();
        _snackBarservice!.showSnackbar(message: "You have added a new group");
        hideLoadingDialog();
      }
      Logger().i(result);
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
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
      showLoadingDialog();
      UpdateResponse? result = await _manageUserService!.getAddGroupEditPayLoad(
          EditGroupPayLoad(
              GroupName: nameController.text,
              GroupUid: groups!.GroupUid!,
              CustomerUID: "d7ac4554-05f9-e311-8d69-d067e5fd4637",
              Description: descriptionController.text,
              AssociatedAssetUID: associatedAssetId,
              DissociatedAssetUID: dissociatedAssetId));
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
