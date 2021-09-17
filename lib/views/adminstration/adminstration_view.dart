import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/reusable_widget/asset_cards_small.dart';
import 'package:insite/views/adminstration/reusable_widget/asset_setting_widget.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_card_widget.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_geofence_widet.dart';
import 'package:insite/views/adminstration/reusable_widget/new_report_template_widget.dart';
import 'package:insite/views/adminstration/reusable_widget/notification_widget.dart';
import 'package:stacked/stacked.dart';
import 'adminstration_view_model.dart';

class AdminstrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminstrationViewModel>.reactive(
      builder:
          (BuildContext context, AdminstrationViewModel viewModel, Widget _) {
        return Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              color: bgcolor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AssetCardsSmall(
                          headerText: "users",
                          icon: "assets/images/users.svg",
                          buttonTitle: [
                            AdminAssetsButtonType.values[0],
                            AdminAssetsButtonType.values[1]
                          ],
                          onCallbackSelected: (value) {
                            print("button is tapped");
                          },
                        ),
                        AssetCardsSmall(
                            headerText: "groups",
                            icon: "assets/images/gear_icon.svg",
                            buttonTitle: [
                              AdminAssetsButtonType.values[2],
                              AdminAssetsButtonType.values[3]
                            ],
                            onCallbackSelected: (value) {
                              print("button is tapped");
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AssetSettingWidget(
                      headerText: "asset settings",
                      onButtonClicked: () {
                        print("button is tapped");
                      },
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AssetCardsSmall(
                              headerText: "geofences".toUpperCase(),
                              icon: "assets/images/geofence.svg",
                              buttonTitle: [
                                AdminAssetsButtonType.values[4],
                                AdminAssetsButtonType.values[5]
                              ],
                              onCallbackSelected: (value) {
                                print("button is tapped");
                              }),
                          AssetCardsSmall(
                              headerText: "reports".toUpperCase(),
                              icon: "assets/images/reports.svg",
                              buttonTitle: [
                                AdminAssetsButtonType.values[6],
                                AdminAssetsButtonType.values[7]
                              ],
                              onCallbackSelected: (value) {
                                print("button is tapped");
                              })
                        ]),
                    SizedBox(
                      height: 21,
                    ),
                    NotificationWidget(
                      headerText: "notifications".toUpperCase(),
                      onButtonClicked: () {
                        print("button is tapped");
                      },
                    )
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => AdminstrationViewModel(),
    );
  }
}
