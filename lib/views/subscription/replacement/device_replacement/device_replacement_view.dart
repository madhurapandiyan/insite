import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/subscription/replacement/device_replacement/device_replacement_widget.dart/deviceId_widget_list.dart';
import 'package:insite/views/subscription/replacement/device_replacement/device_replacement_widget.dart/showing_new_device_preview.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'device_replacement_view_model.dart';
import 'device_replacement_widget.dart/getting_new_deviceId.dart';
import 'device_replacement_widget.dart/showing_old_device_detail.dart';

class DeviceReplacementView extends StatefulWidget {
  @override
  _DeviceReplacementViewState createState() => _DeviceReplacementViewState();
}

class _DeviceReplacementViewState extends State<DeviceReplacementView> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          duration: Duration(seconds: 1),
                          width: !viewModel.initialAlign
                              ? MediaQuery.of(context).size.width * 0.2
                              : viewModel.finalAlign
                                  ? MediaQuery.of(context).size.width * 1
                                  : MediaQuery.of(context).size.width * 0.4,
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
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: !viewModel.showingOldPreview
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InsiteText(
                                    text: "Enter Old Device ID",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: CustomTextBox(
                                      controller:
                                          viewModel.searchTextController,
                                      onChanged: (value) {
                                        viewModel.onEnteringDeviceId(value);
                                      },
                                      suffixWidget: Icon(
                                        Icons.search,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  viewModel.searchList.isEmpty
                                      ? SizedBox()
                                      : Container(
                                          margin: EdgeInsets.all(8),
                                          // height: 50,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          child: Column(
                                            children: List.generate(
                                                viewModel.searchList.length,
                                                (i) => DeviceIdListWidget(
                                                    onSelected: () {
                                                      viewModel
                                                          .onSelectedDeviceId(
                                                              i);
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      
                                                    },
                                                    deviceId: viewModel
                                                        .searchList[i]
                                                        .containsList)),
                                          )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  viewModel.deviceSearchModelResponse == null
                                      ? Container()
                                      : ShowingOldDeviceDetail(
                                          Vin: viewModel
                                              .deviceSearchModelResponse!
                                              .result!
                                              .VIN,
                                          date: viewModel
                                              .deviceSearchModelResponse!
                                              .result!
                                              .S_StartDate,
                                          deviceId: viewModel
                                              .deviceSearchModelResponse!
                                              .result!
                                              .GPSDeviceID,
                                          modelName: viewModel
                                              .deviceSearchModelResponse!
                                              .result!
                                              .Model,
                                        ),
                                  InsiteButton(
                                    textColor: white,
                                    fontSize: 17,
                                    onTap: () {
                                      if (viewModel.deviceSearchModelResponse ==
                                          null) {
                                        if (viewModel.searchTextController.text
                                            .isEmpty) {
                                          return;
                                        } else {
                                          viewModel.onSearchingDeviceId();
                                        }
                                      } else {
                                        setState(() {
                                          viewModel.showingOldPreview =
                                              !viewModel.showingOldPreview;
                                        });
                                      }
                                    },
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    title:
                                        viewModel.deviceSearchModelResponse ==
                                                null
                                            ? "Search"
                                            : "Next",
                                  )
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  !viewModel.showNewPreview
                                      ? GettingNewDeviceId(
                                          controller: viewModel
                                              .replaceDeviceIdController,
                                          modelData:
                                              viewModel.replaceDeviceModelData,
                                          showingDeviceId: viewModel
                                                  .replaceDeviceModelData ==
                                              null,
                                          onChange: (value) {
                                            viewModel.onGettingReplaceDeviceId(
                                                value);
                                          },
                                          onDropDownValueChange: (value) {
                                            viewModel.onDropDownChanged(value);
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
                                        )
                                      : ShowingNewDeviceDetail(
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
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InsiteButton(
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color,
                                        onTap: () {
                                          if (viewModel.isBackPressed) {
                                            viewModel.onBackPressed();
                                          } else {
                                            viewModel
                                                .showingOldDeviceIdPreview();
                                          }
                                        },
                                        bgColor: white,
                                        title: "Back",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                      InsiteButton(
                                        textColor: white,
                                        onTap: !viewModel.showNewPreview
                                            ? viewModel.initialvalue ==
                                                        viewModel
                                                                .dropDownValues[
                                                            0] ||
                                                    viewModel
                                                        .replaceDeviceIdController
                                                        .text
                                                        .isEmpty
                                                ? null
                                                : () {
                                                    setState(() {
                                                      viewModel.showNewPreview =
                                                          !viewModel
                                                              .showNewPreview;
                                                      viewModel.isBackPressed =
                                                          true;
                                                    });
                                                  }
                                            : () {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                        AlertDialog(
                                                          backgroundColor: tuna,
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
                                                                  bgColor: tuna,
                                                                ),
                                                                InsiteButton(
                                                                  width: 120,
                                                                  height: 40,
                                                                  title: "Yes",
                                                                  onTap: () {
                                                                    viewModel
                                                                        .onRegister();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
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
                                        //bgColor: tango,
                                        title: !viewModel.showNewPreview
                                            ? "Next"
                                            : "Replace",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                      ),
                    )
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
