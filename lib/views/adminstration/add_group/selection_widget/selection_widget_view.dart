import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/views/adminstration/add_group/reusable_widget/selected_item_select_widget.dart';
import 'package:insite/views/adminstration/add_group/reusable_widget/selected_item_widget.dart';
import 'package:insite/views/adminstration/add_group/selection_widget/selection_widget_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:stacked/stacked.dart';

class SelectionWidgetView extends StatefulWidget {
  final Function(
      List<String> value,
      AssetGroupSummaryResponse groupSummaryResponse,
      List<String> associatedAssetId)? onAssetSelected;
  final List<String>? assetIds;
  final Groups? group;
  final bool? isEdit;
  final bool? isSelectedAssets;
  final List<String>? dissociatedIds;

  SelectionWidgetView(
      {this.onAssetSelected,
      this.assetIds,
      this.group,
      this.isEdit,
      this.dissociatedIds,
      this.isSelectedAssets});

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
              //margin: EdgeInsets.only(left: 25, right: 50),
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
                      widget.onAssetSelected!(
                          viewModel.assetIdentifier,
                          viewModel.assetIdresult!,
                          viewModel.associatedAssetId);
                    },
                    subList: [],
                    subTextEditingController: null,
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
                      widget.onAssetSelected!(
                          viewModel.assetIdentifier,
                          viewModel.assetIdresult!,
                          viewModel.associatedAssetId);
                    },
                    subList: [],
                    subTextEditingController: null,
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
                    onClickedBackButton: () {
                      viewModel.getBackButtonState();
                    },
                    groupValueCallBack: (valueData, int index) {
                      viewModel.selectedProductFamilyData(valueData, index);
                      viewModel.selectedIndex = index;
                      widget.onAssetSelected!(
                        viewModel.assetIdentifier,
                        viewModel.assetIdresult!,
                        viewModel.associatedAssetId,
                      );
                    },
                    subList: viewModel.subProductFamilySearchList,
                    subTextEditingController:
                        viewModel.productFamilySubController,
                  ),
                  SelectedItemWidget(
                    headerText: "Manufacturer",
                    displayList: viewModel.manfactureList,
                    isAssetIdLoading: viewModel.isAssetLoading,
                    displayCountBoxValue: viewModel.manufacturerCountData,
                    headerBoxCountValue: "Manufacturer",
                    callback: () {
                      viewModel.getManufacturerGroupData();
                    },
                    controller: viewModel.manafactureController,
                    productFamilyKey: (value) {
                      viewModel.getFilterManufacturerData(value);
                    },
                    onClickedBackButton: () {
                      viewModel.getBackButtonState();
                    },
                    groupValueCallBack: (valueData, int index) {
                      viewModel.selectedManfactureListData(valueData, index);
                      viewModel.selectedIndex = index;
                      widget.onAssetSelected!(
                        viewModel.assetIdentifier,
                        viewModel.assetIdresult!,
                        viewModel.associatedAssetId,
                      );
                    },
                    isShowingState: viewModel.isShowingManaFactureState,
                    pageController: viewModel.pageController,
                    subList: viewModel.subManufacturerSearchList,
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
                    subList: [],
                    subTextEditingController: null,
                    pageController: viewModel.pageController,
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
                      widget.onAssetSelected!(
                        viewModel.assetIdentifier,
                        viewModel.assetIdresult!,
                        viewModel.associatedAssetId,
                      );
                    },
                    subList: viewModel.subModelSearchList,
                    isShowingState: viewModel.isShowingModelState,
                    pageController: viewModel.pageController,
                    onClickedBackButton: () {
                      viewModel.getBackButtonState();
                    },
                    subTextEditingController: viewModel.modelSubController,
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
                    onClickedBackButton: () {
                      viewModel.getBackButtonState();
                    },
                    isShowingState: viewModel.isShowingDeviceTypeState,
                    groupValueCallBack: (valueData, int index) {
                      viewModel.selectedDeviceTypeData(valueData, index);
                      viewModel.selectedIndex = index;
                      widget.onAssetSelected!(
                        viewModel.assetIdentifier,
                        viewModel.assetIdresult!,
                        viewModel.associatedAssetId,
                      );
                    },
                    subTextEditingController: viewModel.deviceTypeSubController,
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
                      widget.onAssetSelected!(
                        viewModel.assetIdentifier,
                        viewModel.assetIdresult!,
                        viewModel.associatedAssetId,
                      );
                    },
                    isShowingState: viewModel.isAccountSelectionState,
                    pageController: viewModel.pageController,
                    onClickedBackButton: () {
                      viewModel.getBackButtonState();
                    },
                    subTextEditingController: viewModel.accountSubController,
                    isChangingAccountSelectionState:
                        viewModel.isShowingAccountSelectedState,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InsiteText(
                    text: "Selected Assets",
                    size: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  InsiteText(
                    text: viewModel.assetIdSelecteList.length.toString() +
                        " " +
                        "Assets",
                    size: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.60,
              child: Card(
                  child: viewModel.isAssetLoading
                      ? InsiteProgressBar()
                      : SelectedItemSelectWidgetView(
                          displayList: viewModel.searchSelectedItemList,
                          textEditingController:
                              viewModel.selectedItemController,
                          onAssetDeselected:
                              (int value, String assetIdentifier) {
                            widget.dissociatedIds!.add(assetIdentifier);
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
          widget.group, widget.assetIds, widget.isEdit!),
    );
  }
}
