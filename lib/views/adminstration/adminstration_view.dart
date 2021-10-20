import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/reusable_widget/asset_cards_small.dart';
import 'package:insite/views/adminstration/reusable_widget/asset_setting_widget.dart';
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
          (BuildContext context, AdminstrationViewModel viewModel, Widget _) {
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
                        icon: "assets/images/users.svg",
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
                        buttonTitle: [
                          AdminAssetsButtonType.values[2],
                          AdminAssetsButtonType.values[3]
                        ],
                        onCallbackSelected: (value) {
                          viewModel.onRespectiveButtonClicked(value);
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                AssetSettingWidget(
                  headerText: "asset settings",
                  onButtonClicked: () {
                   viewModel.onAssetSettingStateButtonClicked();
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
                          onCallbackSelected: (value) {}),
                      AssetCardsSmall(
                          headerText: "reports".toUpperCase(),
                          icon: "assets/images/reports.svg",
                          buttonTitle: [
                            AdminAssetsButtonType.values[6],
                            AdminAssetsButtonType.values[7]
                          ],
                          onCallbackSelected: (value) {
                            viewModel.onRespectiveButtonClicked(value);
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
                ),
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
