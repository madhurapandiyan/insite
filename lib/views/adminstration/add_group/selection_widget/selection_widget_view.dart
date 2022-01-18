import 'package:flutter/material.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/edit_group_response.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/add_group/reusable_widget/selected_item_select_widget.dart';
import 'package:insite/views/adminstration/add_group/reusable_widget/selected_item_widget.dart';
import 'package:insite/views/adminstration/add_group/selection_widget/selection_widget_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class SelectionWidgetView extends StatefulWidget {
  final Function(List<String> value, AssetGroupSummaryResponse groupSummaryResponse,
      List<String> associatedAssetId)? voidCallback;
  final List<String?>? assetId;
  final Groups? group;
  final bool? isEdit;
  final List<String>? dissociatedId;
  SelectionWidgetView(
      {this.voidCallback,
      this.assetId,
      this.group,
      this.isEdit,
      this.dissociatedId});

  @override
  _SelectionWidgetViewState createState() => _SelectionWidgetViewState();
}

class _SelectionWidgetViewState extends State<SelectionWidgetView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectionWidgetViewModel>.reactive(
      builder: (BuildContext context, SelectionWidgetViewModel viewModel,
          Widget? _) {
        return Column(
          children: [
            Card(
              margin: EdgeInsets.only(left: 43, right: 43),
              child: Column(
                children: [
                  SelectedItemWidget(
                    headerText: "Asset ID",
                    displayList: viewModel.assetIdDisplayList,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    headerBoxCountValue: "",
                    displayCountBoxValue: [],
                    callback: () {},
                    controller: viewModel.assetIDController,
                    groupValueCallBack: (valueData, int index) {
                      viewModel.selectedIndexData(valueData, index);
                      viewModel.selectedIndex = index;
                      widget.voidCallback!(
                          viewModel.assetIdentifier,
                          viewModel.assetIdresult!,
                          viewModel.associatedAssetId);
                    },
                    subList: [],
                    subTextEditingController: null,
                    isLoading: viewModel.isSubAssetLoading,
                  ),
                  SelectedItemWidget(
                    headerText: "Serial Number",
                    displayList: viewModel.assetSeriaNumberList,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    headerBoxCountValue: "",
                    displayCountBoxValue: [],
                    callback: () {},
                    controller: viewModel.serialNumberController,
                    groupValueCallBack: (valueData, int index) {
                      viewModel.selectedSerialNumberIndexData(valueData, index);
                      viewModel.selectedIndex = index;
                      widget.voidCallback!(
                          viewModel.assetIdentifier,
                          viewModel.assetIdresult!,
                          viewModel.associatedAssetId);
                    },
                    subList: [],
                    subTextEditingController: null,
                    isLoading: viewModel.isSubAssetLoading,
                  ),
                  SelectedItemWidget(
                    pageController: viewModel.pageController,
                    headerText: "Product Family",
                    displayList: viewModel.productFamilyList,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    headerBoxCountValue: "productFamily",
                    displayCountBoxValue: viewModel.productFamilyCountData,
                    callback: () {
                      viewModel.getProductFamilyData();
                    },
                    controller: viewModel.productFamilyController,
                    productFamilyKey: (value) {
                      viewModel.getProductFamilyFilterData(value);
                    },
                    isShowingState: viewModel.isShowingState,
                    isShowingbackButtonState: () {
                      viewModel.getBackButtonState();
                    },
                    groupValueCallBack: (valueData, int index) {
                      viewModel.selectedProductFamilyData(valueData, index);
                      viewModel.selectedIndex = index;
                      widget.voidCallback!(
                        viewModel.assetIdentifier,
                        viewModel.assetIdresult!,
                        viewModel.associatedAssetId,
                      );
                    },
                    subList: viewModel.subProductFamilySearchList,
                    subTextEditingController:
                        viewModel.productFamilySubController,
                    isLoading: viewModel.isSubAssetLoading,
                  ),
                  SelectedItemWidget(
                    headerText: "Manfacturer",
                    displayList: viewModel.manfactureList,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    displayCountBoxValue: viewModel.manfactureCountData,
                    headerBoxCountValue: "manafacture",
                    callback: () {
                      viewModel.getManfactureGroupData();
                    },
                    controller: viewModel.manafactureController,
                    productFamilyKey: (value) {
                      viewModel.getFilterManafactureData(value);
                    },
                    isShowingbackButtonState: () {
                      viewModel.getBackButtonState();
                    },
                    groupValueCallBack: (valueData, int index) {
                      viewModel.selectedManfactureListData(valueData, index);
                      viewModel.selectedIndex = index;
                      widget.voidCallback!(
                        viewModel.assetIdentifier,
                        viewModel.assetIdresult!,
                        viewModel.associatedAssetId,
                      );
                    },
                    isShowingState: viewModel.isShowingManaFactureState,
                    pageController: viewModel.pageController,
                    subList: viewModel.subManafactureSearchList,
                    subTextEditingController:
                        viewModel.manafactureSubController,
                    isLoading: viewModel.isSubAssetLoading,
                  ),
                  SelectedItemWidget(
                    headerText: "Geofences",
                    displayList: viewModel.geofenceData,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    displayCountBoxValue: viewModel.geofenceCountData,
                    headerBoxCountValue: "geoFence",
                    callback: () {
                      viewModel.getGeoFenceData();
                    },
                    controller: null,
                    subList: [],
                    subTextEditingController: null,
                    isLoading: viewModel.isSubAssetLoading,
                  ),
                  SelectedItemWidget(
                    headerText: "Model",
                    displayList: viewModel.modelList,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    displayCountBoxValue: viewModel.modelCountData,
                    headerBoxCountValue: "model",
                    callback: () {
                      viewModel.getModelData();
                    },
                    controller: viewModel.modelController,
                    productFamilyKey: (value) {
                      viewModel.getFilterModelData(value);
                    },
                    groupValueCallBack: (valueData, int index) {
                      viewModel.selectedModelData(valueData, index);
                      viewModel.selectedIndex = index;
                      widget.voidCallback!(
                        viewModel.assetIdentifier,
                        viewModel.assetIdresult!,
                        viewModel.associatedAssetId,
                      );
                    },
                    subList: viewModel.subModelSearchList,
                    isShowingState: viewModel.isShowingModelState,
                    pageController: viewModel.pageController,
                    isShowingbackButtonState: () {
                      viewModel.getBackButtonState();
                    },
                    subTextEditingController: viewModel.modelSubController,
                    isLoading: viewModel.isSubAssetLoading,
                  ),
                  SelectedItemWidget(
                    headerText: "Device Type",
                    displayList: viewModel.deviceTypeList,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    displayCountBoxValue: viewModel.deviceTypeCountData,
                    headerBoxCountValue: "deviceType",
                    callback: () {
                      viewModel.getDeviceTypeData();
                    },
                    controller: viewModel.deviceTypeController,
                    productFamilyKey: (value) {
                      viewModel.getFilterDeviceTypeData(value);
                    },
                    subList: viewModel.subDeviceTypeSearchList,
                    pageController: viewModel.pageController,
                    isShowingbackButtonState: () {
                      viewModel.getBackButtonState();
                    },
                    isShowingState: viewModel.isShowingDeviceTypeState,
                    groupValueCallBack: (valueData, int index) {
                      viewModel.selectedDeviceTypeData(valueData, index);
                      viewModel.selectedIndex = index;
                      widget.voidCallback!(
                        viewModel.assetIdentifier,
                        viewModel.assetIdresult!,
                        viewModel.associatedAssetId,
                      );
                    },
                    subTextEditingController: viewModel.deviceTypeSubController,
                    isLoading: viewModel.isSubAssetLoading,
                  ),
                  SelectedItemWidget(
                    headerText: "Account",
                    displayList: viewModel.accountDisplayList,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    displayCountBoxValue: [],
                    headerBoxCountValue: "",
                    callback: () {
                      viewModel.getSubCustomerList();
                    },
                    controller: viewModel.accountController,
                    productFamilyKey: (value) {
                      viewModel.getAccountSelectionData(value);
                    },
                    subList: viewModel.subAccountSearchList,
                    groupValueCallBack: (valueData, int index) {
                      viewModel.selectedAccountSelectionData(valueData, index);
                      viewModel.selectedIndex = index;
                      widget.voidCallback!(
                        viewModel.assetIdentifier,
                        viewModel.assetIdresult!,
                        viewModel.associatedAssetId,
                      );
                    },
                    isShowingState: viewModel.isaccountSelectionState,
                    pageController: viewModel.pageController,
                    isShowingbackButtonState: () {
                      viewModel.getBackButtonState();
                    },
                    subTextEditingController: viewModel.accountSubController,
                    isChangingAccountSelectionState:
                        viewModel.isShowingAccountSelectedState,
                    isLoading: viewModel.isSubAssetLoading,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.80,
              height: MediaQuery.of(context).size.height * 0.60,
              child: Card(
                  child: viewModel.isAssetLoading
                      ? InsiteProgressBar()
                      : SelectedItemSelectWidgetView(
                          searchList: viewModel.searchSelectedItemList,
                          displayList: viewModel.assetIdSelecteList,
                          textEditingController:
                              viewModel.selectedItemController,
                          callBack: (int value, String assetIdentifier) {
                            widget.dissociatedId!.add(assetIdentifier);
                            viewModel.onRemoveSelectedIndex(
                                value, assetIdentifier);
                          },
                          searchCallBack: (String value) {
                            viewModel.onSearchSelectedItemList(value);
                          },
                          filterCallBack: () {
                            viewModel.filterSelectedItemSelectWidgetState();
                          },
                          filterChangeState: viewModel.isFilterChangeState,
                          dropDownItem: viewModel.dropdownList,
                          dropDownValue: viewModel.dropDownValue,
                          onDropDownChange: (String value) {
                            viewModel.getDropDownListData(value);
                          },
                        )),
            )
          ],
        );
      },
      viewModelBuilder: () => SelectionWidgetViewModel(
          widget.group, widget.assetId, widget.isEdit!),
    );
  }
}
