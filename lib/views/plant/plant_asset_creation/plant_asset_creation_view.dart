import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/plant/plant_asset_creation/reusable_widget/asset_creation_validation_widget.dart';
import 'package:insite/views/plant/plant_asset_creation/reusable_widget/asset_creation_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'plant_asset_creation_view_model.dart';

class PlantAssetCreationView extends StatefulWidget {
  @override
  _PlantAssetCreationViewState createState() => _PlantAssetCreationViewState();
}

class _PlantAssetCreationViewState extends State<PlantAssetCreationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlantAssetCreationViewModel>.reactive(
      builder: (BuildContext context, PlantAssetCreationViewModel viewModel,
          Widget? _) {
        return InsiteScaffold(
            viewModel: viewModel,
            body: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 21.0),
                          child: InsiteText(
                            text: "asset creation".toUpperCase(),
                            fontWeight: FontWeight.w700,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: viewModel.issubmitButtonState
                                ? InsiteButton(
                                    width: MediaQuery.of(context).size.width *
                                        0.24,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    title: "Submit",
                                    textColor:
                                        Theme.of(context).backgroundColor,
                                    fontSize: 14,
                                    onTap: () {
                                      if (viewModel.validate()) {
                                        showDialogBox(viewModel);
                                      }
                                    })
                                : SizedBox()),
                        viewModel.isResetButtonState
                            ? InsiteButton(
                                width: MediaQuery.of(context).size.width * 0.24,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                title: "Reset",
                                textColor: Theme.of(context).backgroundColor,
                                fontSize: 14,
                                onTap: () {
                                  //viewModel.changedResetButtonState();
                                  viewModel.onClickResetButton();
                                },
                              )
                            : SizedBox(),
                        SizedBox(
                          width: 5,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 5.0),
                        //   child: InsiteButton(
                        //     title: "",
                        //     icon: Icon(
                        //       Icons.download,
                        //       color: appbarcolor,
                        //     ),
                        //     onTap: () {
                        //       viewModel.downloadAssetCreationData();
                        //     },
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InsiteText(
                      size: 14,
                      fontWeight: FontWeight.w700,
                      text: "1. Enter Details",
                    ),
                    InsiteText(
                      size: 14,
                      fontWeight: FontWeight.w700,
                      text: "2.Validation",
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.02,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        border: Border.all(
                            width: 1,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    AnimatedContainer(
                        duration: Duration(seconds: 1),
                        height: MediaQuery.of(context).size.height * 0.02,
                        decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: viewModel.screenOne
                            ? MediaQuery.of(context).size.width * 0.85
                            : MediaQuery.of(context).size.width * 0.4),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  flex: 1,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: viewModel.pageController,
                    children: [
                      Form(
                        key: viewModel.formKeyScreenOne,
                        child: ListView.builder(
                            itemCount: viewModel.assetCreationListData.length,
                            padding: EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final dataModel =
                                  viewModel.assetCreationListData[index];

                              return AssetCreationWidget(
                                voidCallback: () {},
                                data: dataModel,
                                onAssetSerialValueChange: (String value) {
                                  viewModel.getAssetSerialListValue(
                                      value.toUpperCase(), index);
                                },
                                onDeviceIdValueChange: (String value) {
                                  viewModel.getDeviceIdListValue(value, index);
                                },
                                onHourMeterValueChange: (String value) {
                                  viewModel.getHrsMeterListValue(value, index);
                                },
                              );
                            }),
                      ),
                      Form(
                        key: viewModel.formKeyScreenTwo,
                        child: ListView.builder(
                            itemCount: viewModel.assetCreationListData.length,
                            padding: EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final assetCreationData =
                                  viewModel.assetCreationListData[index];

                              return AssetCreationValidationWidget(
                                data: assetCreationData,
                                voidCallback: () {
                                  //viewModel.onItemSelect(index);
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
      viewModelBuilder: () => PlantAssetCreationViewModel(),
    );
  }

  showDialogBox(PlantAssetCreationViewModel viewModel) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InsiteButton(
                      width: 120,
                      height: 40,
                      title: "Yes",
                      textColor: Theme.of(context).backgroundColor,
                      onTap: () {
                        viewModel.submitAssetCreationData();
                        Navigator.pop(context);
                      },
                    ),
                    InsiteButton(
                      width: 120,
                      height: 40,
                      title: "No",
                      textColor: Theme.of(context).backgroundColor,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
              content: InsiteText(
                text: "Do You want to Create Asset?",
              ),
            ));
  }
}
