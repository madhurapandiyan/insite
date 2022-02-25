import 'package:flutter/material.dart';
import 'package:insite/utils/enums.dart';

import 'package:insite/views/adminstration/reusable_widget/asset_cards_small.dart';
import 'package:insite/views/adminstration/reusable_widget/asset_setting_widget.dart';
import 'package:insite/views/adminstration/reusable_widget/notification_widget.dart';
import 'package:insite/widgets/smart_widgets/asset_card_large.dart';
import 'package:insite/views/adminstration/reusable_widget/notification_widget.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'adminstration_view_model.dart';

class AdminstrationView extends StatefulWidget {
  @override
  _AdminstrationViewState createState() => _AdminstrationViewState();
}

List<AdminAssetsButtonType> selectedList = [];

class _AdminstrationViewState extends State<AdminstrationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminstrationViewModel>.reactive(
      builder:
          (BuildContext context, AdminstrationViewModel viewModel, Widget? _) {
        return InsiteScaffold(
          viewModel: viewModel,
          screenType: ScreenType.ADMINISTRATION,
          onFilterApplied: () {},
          onRefineApplied: () {},
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AssetCardsSmall(
                        headerText: "users",
                        icon: "assets/images/users_items.svg",
                        showExapansionMenu: false,
                        height: 10,
                        buttonTitle: [
                          AdminAssetsButtonType.values[0],
                          AdminAssetsButtonType.values[1],
                        ],
                        onCallbackSelected: (value) {
                          viewModel.onRespectiveButtonClicked(value);
                        }),
                    AssetCardsSmall(
                        headerText: "groups",
                        icon: "assets/images/gear_icon.svg",
                        height: 10,
                        showExapansionMenu: false,
                        buttonTitle: [
                          AdminAssetsButtonType.values[2],
                          AdminAssetsButtonType.values[3]
                        ],
                        onCallbackSelected: (value) {
                          viewModel.onRespectiveButtonClicked(value);
                        }),

                    // AssetCardsSmall(
                    //     headerText: "reports".toUpperCase(),
                    //     icon: "assets/images/reports.svg",
                    //     showExapansionMenu: false,
                    //     buttonTitle: [
                    //       AdminAssetsButtonType.values[6],
                    //       AdminAssetsButtonType.values[7]
                    //     ],
                    //     height: 10,
                    //     onCallbackSelected: (value) {
                    //       viewModel.onRespectiveButtonClicked(value);
                    //     }),
                    // AssetCardsSmall(
                    //     headerText: "geofences".toUpperCase(),
                    //     height: 10,
                    //     icon: "assets/images/geofence.svg",
                    //     showExapansionMenu: false,
                    //     buttonTitle: [
                    //       AdminAssetsButtonType.values[4],
                    //       AdminAssetsButtonType.values[5]
                    //     ],
                    //     onCallbackSelected: (value) {
                    //       viewModel.onRespectiveButtonClicked(value);
                    //     }),
                    // AssetCardsSmall(
                    //     headerText: "geofences".toUpperCase(),
                    //     height: 10,
                    //     icon: "assets/images/geofence.svg",
                    //     showExapansionMenu: false,
                    //     buttonTitle: [
                    //       AdminAssetsButtonType.values[4],
                    //       AdminAssetsButtonType.values[5]
                    //     ],
                    //     onCallbackSelected: (value) {
                    //       viewModel.onRespectiveButtonClicked(value);
                    //     }),
                    // AssetCardsSmall(
                    //     headerText: "groups",
                    //     icon: "assets/images/gear_icon.svg",
                    //     height: 10,
                    //     showExapansionMenu: false,
                    //     buttonTitle: [
                    //       AdminAssetsButtonType.values[2],
                    //       AdminAssetsButtonType.values[3]
                    //     ],
                    //     onCallbackSelected: (value) {
                    //       viewModel.onRespectiveButtonClicked(value);
                    //     }),
                  ],
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // AssetSettingWidget(
                //   headerText: "asset settings",
                //   showExapansionMenu: false,
                //   icon: "assets/images/assessment.svg",
                //   buttonText: "Manage Asset configurations",
                //   onButtonClicked: () {
                //     viewModel.onAssetSettingStateButtonClicked();
                //   },
                // ),
                SizedBox(
                  height: 21,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // AssetCardsSmall(
                      //     headerText: "geofences".toUpperCase(),
                      //     height: 10,
                      //     icon: "assets/images/geofence.svg",
                      //     showExapansionMenu: false,
                      //     buttonTitle: [
                      //       AdminAssetsButtonType.values[4],
                      //       AdminAssetsButtonType.values[5]
                      //     ],
                      //     onCallbackSelected: (value) {
                      //       viewModel.onRespectiveButtonClicked(value);
                      //     }),
                      AssetCardsSmall(
                          headerText: "reports".toUpperCase(),
                          icon: "assets/images/reports.svg",
                          showExapansionMenu: false,
                          buttonTitle: [
                            AdminAssetsButtonType.values[6],
                            AdminAssetsButtonType.values[7]
                          ],
                          height: 10,
                          onCallbackSelected: (value) {
                            viewModel.onRespectiveButtonClicked(value);
                          })
                    ]),
                SizedBox(
                  height: 30,
                ),
                NotificationWidget(
                  showExapansionMenu: false,
                  icon: "assets/images/warning.svg",
                  headerText: "notifications".toUpperCase(),
                  onAddButtonClicked: (value) {
                    viewModel.onRespectiveButtonClicked(value);
                  },
                  onManageButtonClicked: (value) {
                    viewModel.onRespectiveButtonClicked(value);
                  },
                ),
                // AssetCardsLarge(
                //   cardWidth: MediaQuery.of(context).size.width * 0.90,
                //   cardHeight: MediaQuery.of(context).size.height * 0.23,
                //   headerText: "notifications".toUpperCase(),
                //   icon: "assets/images/warning.svg",
                //   scrollDirection: Axis.horizontal,
                //   height: 15,
                //   buttonTitle: [],
                //   onCallbackSelected: (value) {
                //     viewModel.onRespectiveButtonClicked(value);
                //   },
                // ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => AdminstrationViewModel(),
    );
  }
}
