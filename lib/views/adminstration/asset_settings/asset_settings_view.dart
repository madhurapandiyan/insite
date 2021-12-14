import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_asset_configuration_card.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'asset_settings_view_model.dart';

class AssetSettingsView extends StatefulWidget {
  @override
  _AssetSettingsViewState createState() => _AssetSettingsViewState();
}

class _AssetSettingsViewState extends State<AssetSettingsView> {
  void unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetSettingsViewModel>.reactive(
      builder:
          (BuildContext context, AssetSettingsViewModel viewModel, Widget _) {
        return InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.ASSET_SETTINGS,
            body: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: InsiteText(
                            text: "manage asset configuration".toUpperCase() +
                                " (" +
                                viewModel.asset.length.toString() +
                                " of " +
                                viewModel.totalCount.toString() +
                                " )",
                            fontWeight: FontWeight.w700,
                            size: 14,
                          ),
                        ),
                        // viewModel.showEdit
                        //     ? ClipRRect(
                        //         borderRadius: BorderRadius.only(
                        //           topLeft: Radius.circular(10),
                        //           topRight: Radius.circular(10),
                        //           bottomRight: Radius.circular(10),
                        //           bottomLeft: Radius.circular(10),
                        //         ),
                        //         child: InsiteButton(
                        //             title: "",
                        //             onTap: () {
                        //               viewModel.onClickEditselected();
                        //             },
                        //             icon: Icon(
                        //               Icons.edit,
                        //               color: appbarcolor,
                        //             )),
                        //       )
                        //     : SizedBox(),
                        viewModel.showMenu
                            ? ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InsitePopMenuItemButton(
                                    width: 40,
                                    height: 40,
                                    //icon: Icon(Icons.more_vert),
                                    widget: onContextMenuSelected(viewModel),
                                  ),
                                ))
                            : SizedBox(),
                        // viewModel.showDeSelect
                        //     ? ClipRRect(
                        //         borderRadius: BorderRadius.only(
                        //           topLeft: Radius.circular(10),
                        //           topRight: Radius.circular(10),
                        //           bottomRight: Radius.circular(10),
                        //           bottomLeft: Radius.circular(10),
                        //         ),
                        //         child: InsiteButton(
                        //             title: "",
                        //             onTap: () {
                        //               viewModel.onItemDeselect();
                        //             },
                        //             icon: Icon(
                        //               Icons.close,
                        //               color: appbarcolor,
                        //             )),
                        //       )
                        //     : SizedBox()
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InsiteText(
                          text: "Device Type :",
                          size: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1, color: black),
                          shape: BoxShape.rectangle,
                        ),
                        child: CustomDropDownWidget(
                            items: viewModel.deviceTypeList,
                            onChanged: (String value) {
                              unfocus();
                              viewModel.onDeviceTypeSelected(value);
                            },
                            value: viewModel.deviceTypeSelected)),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomTextBox(
                        controller: viewModel.textEditingController,
                        title: "Search assets",
                        onChanged: (searchText) {
                          if (searchText.isNotEmpty) {
                            viewModel.searchAssets(searchText);
                          } else {
                            viewModel.updateSearchDataToEmpty();
                          }
                        },
                      ),
                    ),
                    viewModel.loading
                        ? Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: InsiteProgressBar(),
                          )
                        : viewModel.asset.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: viewModel.asset.length,
                                  padding: EdgeInsets.all(8),
                                  controller: viewModel.scrollController,
                                  itemBuilder: (_, index) {
                                    AssetSettingsRow assetSetting =
                                        viewModel.asset[index];
                                    return ManageAssetConfigurationCard(
                                      assetSetting: assetSetting,
                                      voidCallback: () {
                                        viewModel.onItemSelected(index);
                                      },
                                    );
                                  },
                                ),
                              )
                            : EmptyView(
                                title: "No assets found",
                              ),
                    viewModel.loadingMore
                        ? Padding(
                            padding: EdgeInsets.all(8),
                            child: InsiteProgressBar())
                        : SizedBox()
                  ],
                ),
                viewModel.isRefreshing ? InsiteProgressBar() : SizedBox()
              ],
            ));
      },
      viewModelBuilder: () => AssetSettingsViewModel(),
    );
  }

  Widget onContextMenuSelected(AssetSettingsViewModel viewModel) {
    return PopupMenuButton<String>(
      offset: Offset(30, 50),
      itemBuilder: (context) => [
        PopupMenuItem(
            value: "Deselect All",
            child: InsiteText(
              text: "Deselect All",
              fontWeight: FontWeight.w700,
              size: 14,
            )),
        viewModel.showEdit
            ? PopupMenuItem(
                value: "Show/Edit Target",
                child: InsiteText(
                  text: "Show/Edit Target",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ))
            : null,
        viewModel.showEdit
            ? PopupMenuItem(
                value: "Configure",
                child: InsiteText(
                  text: "Configure",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ),
              )
            : null
      ],
      onSelected: (value) {
        Logger().i("value:$value");
        viewModel.onSelectedItemClicK(value);
      },
      icon: Icon(
        Icons.more_vert,
        color: appbarcolor,
        size: 25,
      ),
    );
  }
}
