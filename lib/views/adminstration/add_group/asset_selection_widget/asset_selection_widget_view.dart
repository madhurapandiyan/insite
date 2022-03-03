import 'package:flutter/material.dart';

import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/add_group/model/add_group_model.dart';
import 'package:insite/views/adminstration/add_group/reusable_widget/selected_assets_widget.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'asset_selection_widget_view_model.dart';

class AssetSelectionWidgetView extends StatelessWidget {
  final Function(AssetGroupSummaryResponse)? assetData;
  final AssetGroupSummaryResponse? assetResult;
  final Function(int i, Asset? assetData)? onAddingAsset;
  AssetSelectionWidgetView(
      {this.assetData, this.assetResult, this.onAddingAsset});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return ViewModelBuilder<AssetSelectionWidgetViewModel>.reactive(
      builder: (BuildContext context, AssetSelectionWidgetViewModel viewModel,
          Widget? _) {
        return Container(
          height: mediaQuery.size.height * 0.45,
          width: mediaQuery.size.width * 0.85,
          child: Card(
            child: PageView(
              controller: viewModel.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListView(
                    children: List.generate(
                        viewModel.assetSelectionCategory!.length,
                        (i) => ListTile(
                              onTap: () {
                                viewModel.onClickingRespectiveAssetCategory(
                                    viewModel.assetSelectionCategory![i]
                                        .assetCategoryType!);
                                assetData!(viewModel.assetIdresult!);
                              },
                              leading: InsiteText(
                                text: viewModel.assetSelectionCategory![i].name,
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: theme.textTheme.bodyText1!.color,
                              ),
                            ))),
                SelectionAssetWidget(
                  onAddingAsset: (i, value) {
                    onAddingAsset!(i, value);
                  },
                  displayList: viewModel.assetId,
                  onBackPressed: () {
                    viewModel.onAssetIdBackPressed();
                  },
                  title: "Asset Id",
                ),
                SelectionAssetWidget(
                  onAddingAsset: (i, value) {
                    Logger().e(value.toJson());
                    onAddingAsset!(i, value);
                  },
                  displayList: viewModel.assetSerialNumber,
                  onBackPressed: () {
                    viewModel.onAssetIdBackPressed();
                  },
                  title: "Serial Number",
                ),
                SelectionAssetCountWidget(
                  onBackPressed: () {
                    viewModel.onAssetIdBackPressed();
                  },
                  onClickingNestedType: (i, value) {
                    viewModel.getProductFamilyFilterData(value);
                  },
                  displayList: viewModel.productFamilyData,
                  isLoading: viewModel.isloading,
                  title: "Product Family",
                ),
                SelectionAssetWidget(
                  onAddingAsset: (i, value) {
                    onAddingAsset!(i, value);
                  },
                  displayList: viewModel.productFamilyCountData,
                  onBackPressed: () {
                    viewModel.onProductFamilyBackPressed();
                  },
                  title: "Product Family",
                ),
                SelectionAssetCountWidget(
                  onBackPressed: () {
                    viewModel.onAssetIdBackPressed();
                  },
                  onClickingNestedType: (i, value) {
                    viewModel.getFilterManufacturerData(value);
                  },
                  displayList: viewModel.manufacturerData,
                  isLoading: viewModel.isloading,
                  title: "Manufacture",
                ),
                SelectionAssetWidget(
                  onAddingAsset: (i, value) {
                    onAddingAsset!(i, value);
                  },
                  displayList: viewModel.subManufacturerList,
                  onBackPressed: () {
                    viewModel.onManufacturueBackPressed();
                  },
                  title: "Manufacture",
                ),
                SelectionAssetCountWidget(
                  onBackPressed: () {
                    viewModel.onAssetIdBackPressed();
                  },
                  onClickingNestedType: (i, value) {
                    viewModel.getFilterModelData(value);
                  },
                  displayList: viewModel.modelData,
                  title: "Model",
                ),
                SelectionAssetWidget(
                  onAddingAsset: (i, value) {
                    onAddingAsset!(i, value);
                  },
                  displayList: viewModel.subModelData,
                  onBackPressed: () {
                    viewModel.onModelBackPressed();
                  },
                  title: "Model",
                ),
                SelectionAssetCountWidget(
                  onBackPressed: () {
                    viewModel.onAssetIdBackPressed();
                  },
                  onClickingNestedType: (i, value) {
                    viewModel.getFilterDeviceTypeData(value);
                  },
                  displayList: viewModel.deviceTypdeData,
                  title: "Device Type",
                ),
                SelectionAssetWidget(
                  onAddingAsset: (i, value) {
                    onAddingAsset!(i, value);
                  },
                  displayList: viewModel.subDeviceList,
                  onBackPressed: () {
                    viewModel.onDeviceTypeBackPressed();
                  },
                  title: "Device Type",
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => AssetSelectionWidgetViewModel(assetResult),
    );
  }
}

class SelectionAssetWidget extends StatelessWidget {
  final Function? onBackPressed;
  final String? title;
  final List? displayList;
  final bool? isLoading;
  final Function(int i, Asset assetData)? onAddingAsset;
  SelectionAssetWidget(
      {this.displayList,
      this.onBackPressed,
      this.title,
      this.isLoading,
      this.onAddingAsset});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
            onPressed: () {
              onBackPressed!();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: theme.textTheme.bodyText1!.color,
            ),
            label: InsiteText(
              text: title,
              size: 14,
            )),
        displayList!.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: displayList!.length,
                  itemBuilder: (BuildContext context, int i) {
                    var list = displayList as List<Asset>;
                    return ListTile(
                      leading: InsiteText(
                        text: list[i].assetSerialNumber,
                      ),
                      trailing: InsiteButton(
                        title: "add".toUpperCase(),
                        fontSize: 14,
                        onTap: () {
                          onAddingAsset!(i, list[i]);
                        },
                        width: 77,
                        height: 32,
                        textColor: Colors.white,
                      ),
                    );
                  },
                ),
              )
            : Expanded(
                child: EmptyView(
                  bg: theme.cardColor,
                  title: "No Asset Found",
                ),
              )
      ],
    );
  }
}

class SelectionAssetCountWidget extends StatelessWidget {
  final Function? onBackPressed;
  final String? title;
  final List? displayList;
  final bool? isLoading;
  final Function(int, String)? onClickingNestedType;
  SelectionAssetCountWidget(
      {this.displayList,
      this.onBackPressed,
      this.title,
      this.isLoading,
      this.onClickingNestedType});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
            onPressed: () {
              onBackPressed!();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: theme.textTheme.bodyText1!.color,
            ),
            label: InsiteText(
              text: title,
              size: 14,
            )),
        displayList!.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: displayList!.length,
                  itemBuilder: (BuildContext context, int i) {
                    var list = displayList as List<Count>;
                    return ListTile(
                      onTap: () {
                        onClickingNestedType!(i, list[i].countOf!);
                      },
                      leading: InsiteText(
                        text: list[i].countOf,
                      ),
                      trailing: InsiteButton(
                        title: list[i].count.toString(),
                        bgColor: theme.backgroundColor,
                        fontSize: 14,
                        onTap: () {
                          onClickingNestedType!(i, list[i].countOf!);
                        },
                        width: 77,
                        height: 32,
                        textColor: Colors.white,
                      ),
                    );
                  },
                ),
              )
            : Expanded(
                child: EmptyView(
                  bg: theme.cardColor,
                  title: "No Asset Found",
                ),
              )
      ],
    );
  }
}

class SelectedAsset extends StatelessWidget {
  final List<Asset>? displayList;
  final Function(int)? onDeletingSelectedAsset;
  final List<String>? dropDownList;
  final String? initialValue;
  final Function(String)? onChange;
  SelectedAsset(
      {this.displayList,
      this.onDeletingSelectedAsset,
      this.dropDownList,
      this.initialValue,
      this.onChange});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InsiteText(
                text: "Selected Assets",
                size: 14,
                fontWeight: FontWeight.w700,
              ),
              InsiteText(
                text: displayList!.length.toString() + " " + "Assets",
                size: 14,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
        Container(
          height: mediaQuery.size.height * 0.45,
          width: mediaQuery.size.width * 0.85,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!),
                                  top: BorderSide(
                                      width: 1,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!),
                                  left: BorderSide(
                                      width: 1,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!),
                                  right: BorderSide(
                                      width: 1,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!))),
                          child: CustomDropDownWidget(
                            items: dropDownList,
                            value: initialValue,
                            onChanged: (String? value) {
                              onChange!(value!);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 5,
                        child: CustomTextBox(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: InsiteImage(
                          path: "assets/images/descending_filter_group.png",
                        ),
                      )
                    ],
                  ),
                  displayList == null
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 70,
                              ),
                              EmptyView(
                                bg: theme.cardColor,
                                title: "No Asset Selected",
                              ),
                            ],
                          ),
                        )
                      : Flexible(
                          child: ListView.builder(
                              itemCount: displayList!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Asset detailsRecords = displayList![index];
                                return SelectedAssetsWidget(
                                  selectedAssetList: detailsRecords,
                                  callBack: () {
                                    onDeletingSelectedAsset!(index);
                                  },
                                );
                              }),
                        )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
