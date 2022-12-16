import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/subscription/replacement/device_replacement/device_replacement_widget.dart/old_deviceId_search_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'device_replacement_view_model.dart';
import 'device_replacement_widget.dart/getting_new_deviceId.dart';
import 'device_replacement_widget.dart/showing_new_device_preview.dart';
import 'device_replacement_widget.dart/showing_old_device_detail.dart';

class DeviceReplacementView extends StatefulWidget {
  @override
  _DeviceReplacementViewState createState() => _DeviceReplacementViewState();
}

class _DeviceReplacementViewState extends State<DeviceReplacementView> {
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeviceReplacementViewModel>.reactive(
      builder: (BuildContext context, DeviceReplacementViewModel viewModel,
          Widget? _) {
        return InsiteScaffold(
          viewModel: viewModel,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    InsiteText(
                      text: "DEVICE REPLACEMENT",
                      size: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InsiteText(
                          fontWeight: FontWeight.w500,
                          text: "1. Search old\nDevice ID",
                          size: 18,
                        ),
                        InsiteText(
                          fontWeight: FontWeight.w500,
                          text: "2. Enter\nNew Device ID",
                          size: 18,
                        ),
                        InsiteText(
                          fontWeight: FontWeight.w500,
                          text: "3. Preview",
                          size: 18,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.02,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!),
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).backgroundColor),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: viewModel.changingIndex == 0
                              ? MediaQuery.of(context).size.width * 0
                              : viewModel.changingIndex == 1
                                  ? MediaQuery.of(context).size.width * 0.2
                                  : viewModel.changingIndex == 2
                                      ? MediaQuery.of(context).size.width * 0.35
                                      : viewModel.changingIndex == 3
                                          ? MediaQuery.of(context).size.width *
                                              0.6
                                          : MediaQuery.of(context).size.width *
                                              1,
                          height: MediaQuery.of(context).size.height * 0.02,
                          //   Container(
                          //     //   width: MediaQuery.of(context).size.width * 0.4,
                          // //   height: MediaQuery.of(context).size.height * 0.02,
                          decoration: BoxDecoration(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: viewModel.changingIndex == 0
                          ? MediaQuery.of(context).size.height * 0.25
                          : MediaQuery.of(context).size.height * 0.55,
                      //: MediaQuery.of(context).size.height * 0.55,
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: (int) {
                          viewModel.onPageChange(int);
                        },
                        controller: controller,
                        children: [
                          Card(
                            child: OldDeviceIdSearchWidget(
                              checkingDeviceIdEnter: viewModel.checkingDeviceIdEnter,
                              onSearchingDeviceId: () async {
                                
                                if (viewModel.searchTextController.text.length <
                                    4) {
                                  Fluttertoast.showToast(
                                      msg: "Enter valid Device Id");
                                } else {
                                  viewModel.onSearchingDeviceId().then((value) {
                                    Logger().w(value);
                                    if (value == true) {
                                      controller.jumpToPage(1);
                                    } else {}
                                  });
                                }
                              },
                              onSelectedDeviceId: (value) {
                                viewModel.onSelectedDeviceId(value);
                              },
                              searchList: viewModel.searchList,
                              searchTextController:
                                  viewModel.searchTextController,
                              isGettingOldDeviceId:
                                  viewModel.isGettingOldDeviceId,
                              onEnteringDeviceId: (value) {
                                viewModel.onEnteringDeviceId(value);
                              },
                            ),
                          ),
                          viewModel.searchingOldDeviceId
                              ? Card(
                                  child: ShowingOldDeviceDetail(
                                    onSearching: () {
                                      if (viewModel.searchTextController.text
                                              .length <
                                          4) {
                                        Fluttertoast.showToast(
                                            msg: "Enter valid Device Id");
                                      } else {
                                        viewModel
                                            .onSearchingDeviceId()
                                            .then((value) {
                                          if (value!) {
                                          } else {
                                            //Logger().e("ma");
                                            //  controller.jumpToPage(1);
                                          }
                                        });
                                      }
                                    },
                                    searchTextController:
                                        viewModel.searchTextController,
                                    onEnteringDeviceId: (value) {
                                      viewModel.onEnteringDeviceId(value);
                                    },
                                    onSelectedDeviceId: (value) {
                                      viewModel.onSelectedDeviceId(value);
                                    },
                                    searchList: viewModel.searchList,
                                    onNextPressed: () {
                                      controller.animateToPage(2,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOut);
                                    },
                                    Vin: viewModel
                                        .deviceSearchModelResponse!.result!.VIN,
                                    date: viewModel.deviceSearchModelResponse!
                                        .result!.S_StartDate,
                                    deviceId: viewModel
                                        .deviceSearchModelResponse!
                                        .result!
                                        .GPSDeviceID,
                                    modelName: viewModel
                                        .deviceSearchModelResponse!
                                        .result!
                                        .Model,
                                  ),
                                )
                              : SizedBox(),
                          viewModel.searchingOldDeviceId
                              ? Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: GettingNewDeviceId(
                                      onBackPressed: () {
                                        controller.animateToPage(1,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeInOut);
                                      },
                                      onNextPressed: () {
                                        viewModel.onBackPressed();
                                        controller.animateToPage(3,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeInOut);
                                      },
                                      onSelectingNewDeviceId: (value) {
                                        viewModel.onSelectedNewDeviceId(value);
                                      },
                                      controller:
                                          viewModel.replaceDeviceIdController,
                                      modelData:
                                          viewModel.replaceDeviceModelData,
                                      showingDeviceId:
                                          viewModel.checkingNewDeviceIdEnter,
                                      onChange: (value) {
                                        viewModel
                                            .onGettingReplaceDeviceId(value);
                                      },
                                      onDropDownValueChange: (value) {
                                        viewModel.onDropDownChanged(value);
                                      //  Focus.of(context).unfocus();
                                      },
                                      initialValue: viewModel.initialvalue,
                                      items: viewModel.dropDownValues,
                                      modelName: viewModel
                                          .deviceSearchModelResponse!
                                          .result!
                                          .Model,
                                      oldDeviceId: viewModel
                                          .deviceSearchModelResponse!
                                          .result!
                                          .GPSDeviceID,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          viewModel.showingNewDeviceIdPreview
                              ? Card(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 10, right: 10),
                                    child: ShowingNewDeviceDetail(
                                      onBackPressed: () {
                                        viewModel.onBackPressed();
                                        controller.animateToPage(2,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeInOut);
                                      },
                                      onReplacing: () {
                                        setState(() {
                                          viewModel.changingIndex = 4;
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                                  backgroundColor: white,
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        InsiteButton(
                                                          width: 120,
                                                          height: 40,
                                                          title: "No",
                                                          onTap: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          bgColor: white,
                                                        ),
                                                        InsiteButton(
                                                          width: 120,
                                                          height: 40,
                                                          title: "Yes",
                                                          onTap: () async {
                                                            //toDo
                                                            viewModel
                                                                .onRegister()
                                                                .then((value) {
                                                              viewModel
                                                                  .onReplacementSuccessful();
                                                              if (value ==
                                                                  "success") {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();

                                                                controller.animateToPage(0,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            500),
                                                                    curve: Curves
                                                                        .easeInOut);
                                                              } else {}
                                                            });
                                                          },
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                  content: InsiteText(
                                                    text:
                                                        "Are you sure, do you want to replace ${viewModel.deviceSearchModelResponse!.result!.GPSDeviceID} with ${viewModel.replaceDeviceIdController.text}?",
                                                  ),
                                                ));
                                      },
                                      oldDeviceId: viewModel
                                          .deviceSearchModelResponse!
                                          .result!
                                          .GPSDeviceID,
                                      modelName: viewModel
                                          .deviceSearchModelResponse!
                                          .result!
                                          .Model,
                                      machineSerialNo: viewModel
                                          .deviceSearchModelResponse!
                                          .result!
                                          .VIN,
                                      startDate: viewModel
                                          .deviceSearchModelResponse!
                                          .result!
                                          .S_StartDate,
                                      newDeviceId: viewModel
                                          .replaceDeviceIdController.text,
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => DeviceReplacementViewModel(),
    );
  }
}
