import 'package:flutter/material.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/edit_group_response.dart';
import 'package:insite/core/models/group_summary_response.dart';
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
  final Function(List<String> value, GroupSummaryResponse groupSummaryResponse,
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
                    displayList: viewModel.assetId,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    headerBoxCountValue: "",
                    displayCountBoxValue: [],
                    callback: () {},
                    controller: viewModel.assetIDController,
                    searchList: viewModel.assetIdDisplayList,
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
                    subSearchList: [],
                  ),
                  SelectedItemWidget(
                    headerText: "Serial Number",
                    displayList: viewModel.assetSerialNumber,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    headerBoxCountValue: "",
                    displayCountBoxValue: [],
                    callback: () {},
                    controller: viewModel.serialNumberController,
                    searchList: viewModel.assetSeriaNumberList,
                    isLoading: viewModel.isloading,
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
                    subSearchList: [],
                  ),
                  SelectedItemWidget(
                    pageController: viewModel.pageController,
                    headerText: "Product Family",
                    displayList: viewModel.productFamilyData,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    headerBoxCountValue: "productFamily",
                    displayCountBoxValue: viewModel.productFamilyCountData,
                    callback: () {
                      viewModel.getProductFamilyData();
                    },
                    controller: viewModel.productFamilyController,
                    searchList: viewModel.productFamilyList,
                    productFamilyKey: (value) {
                      viewModel.getProductFamilyFilterData(value);
                    },
                    isShowingState: viewModel.isShowingState,
                    isShowingbackButtonState: () {
                      viewModel.getBackButtonState();
                      viewModel.pageController!
                          .jumpToPage(viewModel.currentPage);
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
                    subList: viewModel.subProductFamilyList,
                    subTextEditingController:
                        viewModel.productFamilySubController,
                    subSearchList: viewModel.subProductFamilySearchList,
                  ),
                  SelectedItemWidget(
                    headerText: "Manfacturer",
                    displayList: viewModel.manfactureData,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    displayCountBoxValue: viewModel.manfactureCountData,
                    headerBoxCountValue: "manafacture",
                    callback: () {
                      viewModel.getManfactureGroupData();
                    },
                    controller: viewModel.manafactureController,
                    searchList: viewModel.manfactureList,
                    productFamilyKey: (value) {
                      viewModel.getFilterManafactureData(value);
                    },
                    isShowingbackButtonState: () {
                      viewModel.getBackButtonState();
                      viewModel.pageController!
                          .jumpToPage(viewModel.currentPage);
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
                    subList: viewModel.subManfactureList,
                    subSearchList: viewModel.subManafactureSearchList,
                    subTextEditingController:
                        viewModel.manafactureSubController,
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
                    searchList: [],
                    subList: [],
                    subTextEditingController: null,
                    subSearchList: [],
                  ),
                  SelectedItemWidget(
                    headerText: "Model",
                    displayList: viewModel.modelData,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    displayCountBoxValue: viewModel.modelCountData,
                    headerBoxCountValue: "model",
                    callback: () {
                      viewModel.getModelData();
                    },
                    controller: viewModel.modelController,
                    searchList: viewModel.modelList,
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
                    subList: viewModel.subModelList,
                    isShowingState: viewModel.isShowingModelState,
                    pageController: viewModel.pageController,
                    isShowingbackButtonState: () {
                      viewModel.getBackButtonState();
                      viewModel.pageController!
                          .jumpToPage(viewModel.currentPage);
                    },
                    subSearchList: viewModel.subModelSearchList,
                    subTextEditingController: viewModel.modelSubController,
                  ),
                  SelectedItemWidget(
                    headerText: "Device Type",
                    displayList: viewModel.deviceTypdeData,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    displayCountBoxValue: viewModel.deviceTypeCountData,
                    headerBoxCountValue: "deviceType",
                    callback: () {
                      viewModel.getDeviceTypeData();
                    },
                    controller: viewModel.deviceTypeController,
                    searchList: viewModel.devicetypeList,
                    productFamilyKey: (value) {
                      viewModel.getFilterDeviceTypeData(value);
                    },
                    subList: viewModel.deviceTypeList,
                    pageController: viewModel.pageController,
                    isShowingbackButtonState: () {
                      viewModel.getBackButtonState();
                      viewModel.pageController!
                          .jumpToPage(viewModel.currentPage);
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
                    subSearchList: viewModel.subDeviceTypeSearchList,
                    subTextEditingController: viewModel.deviceTypeSubController,
                  ),
                  SelectedItemWidget(
                    headerText: "Account",
                    displayList: viewModel.displayName,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    displayCountBoxValue: [],
                    headerBoxCountValue: "",
                    searchList: viewModel.accountDisplayList,
                    callback: () {
                      viewModel.getSubCustomerList();
                    },
                    controller: viewModel.accountController,
                    productFamilyKey: (value) {
                      viewModel.getAccountSelectionData(value);
                    },
                    subList: viewModel.accountSelectionList,
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
                      viewModel.pageController!
                          .jumpToPage(viewModel.currentPage);
                    },
                    subSearchList: viewModel.subAccountSearchList,
                    subTextEditingController: viewModel.accountSubController,
                    isChangingAccountSelectionState:
                        viewModel.isShowingAccountSelectedState,
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
                          viewModel. getDropDownListData(value);
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
