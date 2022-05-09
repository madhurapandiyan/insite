import 'package:flutter/material.dart';

import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'asset_selection_widget_view_model.dart';

class AssetSelectionWidgetView extends StatefulWidget {
  final Function(AssetGroupSummaryResponse)? assetData;
  final bool? isLoading;
  final bool? isAddingAllAsset;
  final AssetGroupSummaryResponse? assetResult;
  final Function(List<Asset>? allAsset)? addingAllAsset;
  final Function(int i, Asset? assetData)? onAddingAsset;
  final Function? onRemoving;
  const AssetSelectionWidgetView(
      {Key? key,
      this.assetData,
      this.assetResult,
      this.onAddingAsset,
      this.isLoading,
      this.onRemoving,
      this.addingAllAsset,
      this.isAddingAllAsset})
      : super(key: key);

  @override
  State<AssetSelectionWidgetView> createState() =>
      AssetSelectionWidgetViewState();
}

class AssetSelectionWidgetViewState extends State<AssetSelectionWidgetView> {
  // late AssetSelectionWidgetViewModel viewModel;
  // @override
  // void initState() {
  //   super.initState();
  //   viewModel = AssetSelectionWidgetViewModel(null);
  // }

  // Asset? assetData;

  // onAddingDeletedAsset(Asset data) {
  //   assetData = data;
  //   //viewModel.onAddingDeletedAsset(data);
  // }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return ViewModelBuilder<AssetSelectionWidgetViewModel>.reactive(
      builder: (BuildContext context, AssetSelectionWidgetViewModel viewModel,
          Widget? _) {
        // viewModel.onAddingDeletedAsset(assetData);
        return Column(
          children: [
            Container(
              height: mediaQuery.size.height * 0.45,
              width: mediaQuery.size.width * 0.85,
              child: Card(
                child: PageView(
                  controller: viewModel.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    // widget.assetResult == null
                    //     ? Center(
                    //         child: InsiteProgressBar(),
                    //       )
                    //     :
                    ListView(
                        children: List.generate(
                            viewModel.assetSelectionCategory!.length,
                            (i) => ListTile(
                                  onTap: () {
                                    viewModel.selectedType = viewModel
                                        .assetSelectionCategory![i]
                                        .assetCategoryType;
                                    viewModel.onClickingRespectiveAssetCategory(
                                        viewModel.assetSelectionCategory![i]
                                            .assetCategoryType!);
                                    widget.assetData!(viewModel.assetIdresult!);
                                  },
                                  leading: InsiteText(
                                    text: viewModel
                                        .assetSelectionCategory![i].name,
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: theme.textTheme.bodyText1!.color,
                                  ),
                                ))),
                    SelectionAssetWidget(
                      onAddingAsset: (i, value) {
                        widget.onAddingAsset!(i, value);
                        // viewModel.onDeletingSelectedAsset(i, value.type!);
                        //viewModel.getGroupListData(widget.assetResult!);
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
                        widget.onAddingAsset!(i, value);
                        //viewModel.onDeletingSelectedAsset(i, value.type!);
                        // viewModel.onAddingSerialNo(i,value);
                        // viewModel.getGroupListData(widget.assetResult!);
                      },
                      displayList: viewModel.isSearchingSerialNo
                          ? viewModel.serialNoSearch
                          : viewModel.assetSerialNumber,
                      onBackPressed: () {
                        viewModel.onAssetIdBackPressed();
                      },
                      onChange: (value) {
                        viewModel.onSearchingSerialNo(value);
                      },
                      title: "Serial Number",
                    ),
                    SelectionAssetCountWidget(
                      onBackPressed: () {
                        viewModel.onAssetIdBackPressed();
                      },
                      onClickingNestedType: (i, value) {
                        viewModel.getProductFamilyFilterData(value, i);
                      },
                      displayList: viewModel.productFamilyData,
                      isLoading: viewModel.isloading,
                      title: "Product Family",
                    ),
                    SelectionAssetWidget(
                      onAddingAsset: (i, value) {
                        widget.onAddingAsset!(i, value);
                        //viewModel.onDeletingSelectedAsset(i, value.type!);
                      },
                      onChange: (value) {
                        viewModel.onSearchingProductFamily(value);
                      },
                      displayList: viewModel.isSearchingProductFamily
                          ? viewModel.searchProductFamilyCountData
                          : viewModel.productFamilyCountData,
                      onBackPressed: () {
                        viewModel.onProductFamilyBackPressed();
                        viewModel.clearAllValues();
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
                        widget.onAddingAsset!(i, value);
                        // viewModel.onDeletingSelectedAsset(i, value.type!);
                      },
                      displayList: viewModel.subManufacturerList,
                      onBackPressed: () {
                        viewModel.onManufacturueBackPressed();
                        viewModel.clearAllValues();
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
                        widget.onAddingAsset!(i, value);
                        //viewModel.onDeletingSelectedAsset(i, value.type!);
                      },
                      displayList: viewModel.subModelData,
                      onBackPressed: () {
                        viewModel.onModelBackPressed();
                        viewModel.clearAllValues();
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
                        widget.onAddingAsset!(i, value);
                        //  viewModel.onDeletingSelectedAsset(i, value.type!);
                      },
                      displayList: viewModel.subDeviceList,
                      onBackPressed: () {
                        viewModel.onDeviceTypeBackPressed();
                        viewModel.clearAllValues();
                      },
                      title: "Device Type",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            widget.isAddingAllAsset == true || widget.isAddingAllAsset == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InsiteButton(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.3,
                        title: "Add All".toUpperCase(),
                        onTap: () {
                          var data = viewModel.onAddingAllAsset();
                          Logger().w(data!.length);
                          widget.addingAllAsset!(data);
                        },
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InsiteButton(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.3,
                        title: "Remove all".toUpperCase(),
                        onTap: () {
                          widget.onRemoving!();
                        },
                        textColor: Colors.white,
                      )
                    ],
                  )
                : SizedBox()
          ],
        );
      },
      viewModelBuilder: () => AssetSelectionWidgetViewModel(widget.assetResult),
    );
  }
}

class SelectionAssetWidget extends StatelessWidget {
  final Function? onBackPressed;
  final String? title;
  final List? displayList;
  final Function(String)? onChange;
  final Function(int i, Asset assetData)? onAddingAsset;
  SelectionAssetWidget(
      {this.displayList,
      this.onBackPressed,
      this.title,
      this.onAddingAsset,
      this.onChange});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
          ],
        ),
        // displayList!.isNotEmpty
        //     ? Container(
        //         width: mediaQuery.size.width * 0.8,
        //         margin: EdgeInsets.all(10),
        //         child: CustomTextBox(
        //           onChanged: (value) {
        //             onChange!(value);
        //           },
        //         ))
        //     : SizedBox(),
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
              ),
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

class SelectedAsset extends StatefulWidget {
  final List<Asset>? displayList;
  final Function(int)? onDeletingSelectedAsset;
  final List<String>? dropDownList;
  final String? initialValue;
  final Function(String)? onChange;
  final Function(String)? onChangeSearchBox;
  final bool? isLoading;
  SelectedAsset(
      {this.displayList,
      this.onDeletingSelectedAsset,
      this.dropDownList,
      this.initialValue,
      this.onChange,
      this.isLoading,
      this.onChangeSearchBox});

  @override
  State<SelectedAsset> createState() => _SelectedAssetState();
}

class _SelectedAssetState extends State<SelectedAsset> {
  bool isSorting = false;
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
                text: widget.displayList!.length.toString() + " " + "Assets",
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
                            items: widget.dropDownList,
                            value: widget.initialValue,
                            onChanged: (String? value) {
                              widget.onChange!(value!);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 5,
                        child: CustomTextBox(
                          onChanged: (value) {
                            widget.onChangeSearchBox!(value);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSorting = !isSorting;
                          });
                        },
                        child: InsiteImage(
                          path: isSorting
                              ? "assets/images/ascending_filter_group.png"
                              : "assets/images/descending_filter_group.png",
                        ),
                      )
                    ],
                  ),
                  widget.displayList!.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              widget.isLoading == true
                                  ? Center(
                                      child: InsiteProgressBar(),
                                    )
                                  : EmptyView(
                                      bg: theme.cardColor,
                                      title: "No Asset Selected",
                                    ),
                            ],
                          ),
                        )
                      : Flexible(
                          child: ListView.builder(
                              reverse: isSorting ? true : false,
                              itemCount: widget.displayList!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Asset detailsRecords =
                                    widget.displayList![index];
                                return ListTile(
                                  leading: InsiteImage(
                                    width: 38,
                                    height: 38,
                                    path: "assets/images/crane_small_login.png",
                                  ),
                                  title: Container(
                                    child: InsiteText(
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                      text: detailsRecords.assetSerialNumber,
                                    ),
                                  ),
                                  subtitle: InsiteText(
                                    size: 12,
                                    text: detailsRecords.makeCode! +
                                        "-" +
                                        detailsRecords.model!,
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        widget.onDeletingSelectedAsset!(index);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: theme.textTheme.bodyText1!.color,
                                      )),
                                );
                                //  SelectedAssetsWidget(
                                //   selectedAssetList: detailsRecords,
                                //   callBack: () {
                                //     widget.onDeletingSelectedAsset!(index);
                                //   },
                                // );
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
