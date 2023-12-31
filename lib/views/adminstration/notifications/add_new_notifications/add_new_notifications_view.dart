import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/model/alert_config_edit.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/dropdown_widget_with_google_map.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/expansion_card.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/multi_custom_dropDown_widget.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/text_box_with_switch.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/textbox_with_suffix_prefix.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/zone_creating_widget.dart';
import 'package:insite/views/subscription/replacement/device_replacement/device_replacement_widget.dart/deviceId_widget_list.dart';

import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/day_check.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/time_slots.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../add_group/asset_selection_widget/asset_selection_widget_view.dart';
import 'add_new_notifications_view_model.dart';
import 'reusable_widget/selcted_card_widget.dart';

class AddNewNotificationsView extends StatefulWidget {
  final AlertConfigEdit? alertData;

  AddNewNotificationsView({this.alertData});
  @override
  State<AddNewNotificationsView> createState() =>
      _AddNewNotificationsViewState();
}

class _AddNewNotificationsViewState extends State<AddNewNotificationsView>
    with TickerProviderStateMixin {
  Widget showingSwitchableWidgetWithTitle(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsiteText(
          text: title,
        ),
        child,
      ],
    );
  }

  Widget showingSwitchableWidget(List<SwitchState> listData,
      Function checkingSwitchState, AddNewNotificationsViewModel viewModel) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            listData.length,
            (i) => Column(
                  children: [
                    listData[i].text == "Include" ||
                            listData[i].text == "Exclude"
                        ? ListTile(
                            onTap: () {
                              viewModel.customizable.first.state!
                                  ? checkingSwitchState(i)
                                  : null;
                            },
                            dense: true,
                            visualDensity: VisualDensity(vertical: -2),
                            leading: Container(
                              height: 17,
                              width: 17,
                              decoration: BoxDecoration(
                                border: Border.all(color: tango, width: 2),
                                borderRadius: BorderRadius.circular(3),
                                color: listData[i].state! ? tango : null,
                              ),
                              child: listData[i].state!
                                  ? Icon(
                                      Icons.check,
                                      size: 13,
                                      color: white,
                                    )
                                  : null,
                            ),
                            title: InsiteText(
                                text: listData[i].text,
                                size: 15,
                                fontWeight: FontWeight.w400,
                                color: viewModel.customizable.first.state!
                                    ? black
                                    : Colors.grey),
                          )
                        // TextButton.icon(
                        //     onPressed: () {
                        //       checkingSwitchState(i);
                        //     },
                        //     icon: Icon(Icons.crop_square,
                        //         color: listData[i].state!
                        //             ? Theme.of(context).buttonColor
                        //             : Colors.black),
                        //     label: InsiteText(
                        //       text: listData[i].text,
                        //       color: viewModel.customizable.first.state!
                        //           ? Colors.black
                        //           : Colors.black.withOpacity(0.3),
                        //     ))
                        : ListTile(
                            onTap: () {
                              checkingSwitchState(i);
                            },
                            dense: true,
                            visualDensity: VisualDensity(vertical: -2),
                            leading: Container(
                              height: 17,
                              width: 17,
                              decoration: BoxDecoration(
                                border: Border.all(color: tango, width: 2),
                                borderRadius: BorderRadius.circular(3),
                                color: listData[i].state! ? tango : null,
                              ),
                              child: listData[i].state!
                                  ? Icon(
                                      Icons.check,
                                      size: 13,
                                      color: white,
                                    )
                                  : null,
                            ),
                            title: InsiteText(
                              text: listData[i].text,
                              size: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                    // TextButton.icon(
                    //     onPressed: () {
                    //       checkingSwitchState(i);
                    //     },
                    //     icon: Icon(Icons.crop_square,
                    //         color: listData[i].state!
                    //             ? Theme.of(context).buttonColor
                    //             : Colors.black),
                    //     label: InsiteText(
                    //       text: listData[i].text,
                    //     )),
                  ],
                )));
  }

  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    return ViewModelBuilder<AddNewNotificationsViewModel>.reactive(
      builder: (BuildContext context, AddNewNotificationsViewModel viewModel,
          Widget? _) {
        viewModel.controller = TabController(length: 7, vsync: this);

        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.ADD_NOTIFICATION,
            onFilterApplied: () {
              //viewModel.refresh();
            },
            onRefineApplied: () {
              //viewModel.refresh();
            },
            body: viewModel.isEditLoading!
                ? InsiteProgressBar()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InsiteText(
                                text: "Notification",
                                size: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextBox(
                                title: "Enter Notification Name",
                                controller: viewModel.notificationController,
                                validator: (value) {
                                  if (viewModel.notificationExists != null) {
                                    Logger().wtf(viewModel
                                        .notificationExists!.alertTitleExists);
                                    if (viewModel.notificationExists!
                                            .alertTitleExists ==
                                        true) {
                                      return "This notification title is already taken. Enter a new title.";
                                    }
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  viewModel.checkIfNotificationNameExist(value);
                                },
                                // suffixWidget: viewModel.isNotificationNameChange
                                //     ? InsiteProgressBar()
                                //     : viewModel.isTitleExist
                                //         ? Icon(Icons.dangerous,color: Colors.red,)
                                //         : Icon(Icons.check_circle_rounded,
                                //             color: Colors.green,
                                //           ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InsiteText(
                                text: "Select Notification Type",
                                size: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              viewModel.isEditing
                                  ? Container(
                                      width: double.infinity,
                                      height: mediaquerry.size.height * 0.06,
                                      padding: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: InsiteText(
                                          text: viewModel.dropDownInitialValue,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CustomDropDownWidget(
                                        //istappable: !viewModel.isEditing,
                                        items: viewModel.notificationTypes,
                                        onChanged: (value) {
                                          viewModel.updateModelValue(value!);
                                        },
                                        // isEnabled: viewModel.isEditing,
                                        value: viewModel.dropDownInitialValue,
                                      )
                                      // CustomDropDownAddNotificationWidget(
                                      //   dropDownValue: (value) {
                                      //
                                      //   },
                                      //   value: viewModel.dropDownInitialValue,
                                      //   administratortAssets:
                                      //       viewModel.administratortAssets,
                                      //   geofenceAssets: viewModel.geofenceAssets,
                                      //   reportFleetAssets:
                                      //       viewModel.notificationFleetType,
                                      //   reportServiceAssets:
                                      //       viewModel.notificationServiceType,
                                      //   isShowingDropDownState: true,
                                      // )
                                      ),
                              SizedBox(
                                height: 20,
                              ),
                              viewModel.showZone
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InsiteText(
                                          text: "Configure Notification Type",
                                          size: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        // viewModel.dropDownInitialValue !=
                                        //             "Switches" &&
                                        //         viewModel.dropDownInitialValue !=
                                        //             "Power Mode"
                                        //     ? Card(
                                        //         child: Padding(
                                        //           padding:
                                        //               const EdgeInsets.all(8.0),
                                        //           child: InsiteText(
                                        //             text:
                                        //                 "You can configure only one inclusion zone and a maximum of five exclusion zones",
                                        //           ),
                                        //         ),
                                        //       )
                                        //     : SizedBox(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: viewModel
                                                        .dropDownInitialValue ==
                                                    "Fuel Loss"
                                                ? TextBoxWithSuffixAndPrefix(
                                                    suffixTitle: "%",
                                                    controller: viewModel
                                                        .assetStatusOccurenceController,
                                                    onChange: (value) {
                                                      viewModel
                                                          .onChangingOccurence(
                                                              value);
                                                    },
                                                  )
                                                // : viewModel.dropDownInitialValue ==
                                                //         "Switches"
                                                //     ? showingSwitchableWidget(
                                                //         viewModel.switchState,
                                                //         viewModel
                                                //             .checkingSwitchState)
                                                //     : viewModel.dropDownInitialValue ==
                                                //             "Power Mode"
                                                //         ? showingSwitchableWidget(
                                                //             viewModel
                                                //                 .powerModeState,
                                                //             viewModel
                                                //                 .checkingPowerModeState)
                                                : viewModel.dropDownInitialValue ==
                                                        "Fault Code"
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            showingSwitchableWidgetWithTitle(
                                                              "Severity :",
                                                              showingSwitchableWidget(
                                                                  viewModel
                                                                      .severityState,
                                                                  viewModel
                                                                      .checkingSeverityState,
                                                                  viewModel),
                                                            ),
                                                            showingSwitchableWidgetWithTitle(
                                                              "Fault Code Type :",
                                                              showingSwitchableWidget(
                                                                  viewModel
                                                                      .faultCodeType,
                                                                  viewModel
                                                                      .checkingFaultCodeTypeState,
                                                                  viewModel),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                InsiteText(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  text:
                                                                      "After Occurences",
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.05,
                                                                    child:
                                                                        CustomTextBox(
                                                                      //isenabled: widget.isEnable == null ? true : widget.isEnable,
                                                                      isenabled:
                                                                          false,
                                                                      keyPadType:
                                                                          TextInputType
                                                                              .number,
                                                                      //controller: widget.controller,
                                                                      title:
                                                                          "1",
                                                                    )),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            showingSwitchableWidget(
                                                                viewModel
                                                                    .customizable,
                                                                viewModel
                                                                    .onCustomiozablestateChange,
                                                                viewModel),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child: showingSwitchableWidget(
                                                                  viewModel
                                                                      .customizableState,
                                                                  viewModel
                                                                      .checkingCustomizeableState,
                                                                  viewModel),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            viewModel
                                                                    .customizable
                                                                    .first
                                                                    .state!
                                                                ? Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      InsiteText(
                                                                        text:
                                                                            "Select Fault Code",
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Container(
                                                                        height: mediaquerry.size.height *
                                                                            0.5,
                                                                        child:
                                                                            ExpansionCardWidget(
                                                                          title:
                                                                              viewModel.expansionTitle,
                                                                          // isLoadMore: viewModel.loadingMore,
                                                                          onExpanded:
                                                                              (boolValue, index) {
                                                                            viewModel.onExpansion(boolValue,
                                                                                index);
                                                                          },
                                                                          items:
                                                                              viewModel.faultCodeTypeSearch!,
                                                                          scrollController:
                                                                              viewModel.faultCodeScrollController,
                                                                          onChange:
                                                                              (value) {
                                                                            viewModel.onChangingFaultCode(value);
                                                                          },
                                                                          textController:
                                                                              viewModel.faultCodeSearchController,
                                                                          onDiagnosticFrontPressed:
                                                                              () {
                                                                            viewModel.onDiagnosticFrontPressed();
                                                                          },
                                                                          onEventFrontPressed:
                                                                              () {
                                                                            viewModel.onEventFrontPressed();
                                                                          },
                                                                          isFaultCodePressed:
                                                                              viewModel.isFaultCodePressed,
                                                                          controller:
                                                                              viewModel.pageController,
                                                                          onDescriptionBackPressed:
                                                                              () {
                                                                            viewModel.onDescriptionBackPressed();
                                                                          },
                                                                          onFaultCodeFrontPressed:
                                                                              () {
                                                                            viewModel.onFaultCodeFrontPressed();
                                                                          },
                                                                          onDescriptionFrontPressed:
                                                                              () {
                                                                            viewModel.onDescriptionFrontPressed();
                                                                          },
                                                                          onAdding:
                                                                              (i) {
                                                                            viewModel.onAddingFaultCode(i);
                                                                          },
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      viewModel
                                                                              .SelectedfaultCodeTypeSearch
                                                                              .isNotEmpty
                                                                          ? Container(
                                                                              height: mediaquerry.size.height * 0.5,
                                                                              child: SelectedCardWidget(
                                                                                items: viewModel.SelectedfaultCodeTypeSearch,
                                                                                onDeleting: (i) {
                                                                                  viewModel.onDeletingSelectedFaultCode(i);
                                                                                },
                                                                              ))
                                                                          : SizedBox()
                                                                    ],
                                                                  )
                                                                : SizedBox()
                                                          ],
                                                        ),
                                                      )
                                                    : viewModel.dropDownInitialValue ==
                                                            "Fluid Analysis"
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: showingSwitchableWidgetWithTitle(
                                                                "Severity :",
                                                                showingSwitchableWidget(
                                                                    viewModel
                                                                        .fluidAnalysisState,
                                                                    viewModel
                                                                        .checkingFluidAnalysisState,
                                                                    viewModel)),
                                                          )
                                                        : viewModel.dropDownInitialValue ==
                                                                "Inspection"
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: showingSwitchableWidgetWithTitle(
                                                                    "Severity :",
                                                                    showingSwitchableWidget(
                                                                        viewModel
                                                                            .inspectionState,
                                                                        viewModel
                                                                            .checkingInspectionState,
                                                                        viewModel)),
                                                              )
                                                            : viewModel.dropDownInitialValue ==
                                                                    "Asset Security"
                                                                ? Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: showingSwitchableWidgetWithTitle(
                                                                        "Status :",
                                                                        showingSwitchableWidget(
                                                                            viewModel.assetSecurityState,
                                                                            viewModel.checkingAssetSecurityState,
                                                                            viewModel)),
                                                                  )
                                                                : viewModel.dropDownInitialValue ==
                                                                        "Zone Inclusion/Exclusion"
                                                                    ? Stack(
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              DropDownWidgetWithGoogleMap(
                                                                                onSelecting: (i) {
                                                                                  viewModel.onSelectingInclusion(i);
                                                                                },
                                                                                onAddingZone: () {
                                                                                  viewModel.onAddingInclusion();
                                                                                },
                                                                                initialValue: viewModel.inclusionInitialValue,
                                                                                items: viewModel.zoneNamesInclusion,
                                                                                onConform: (value) {
                                                                                  viewModel.onChangingInclusion(value);
                                                                                },
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              DropDownWidgetWithGoogleMap(
                                                                                onAddingZone: () {
                                                                                  viewModel.onAddingExclusion();
                                                                                },
                                                                                onSelecting: (i) {
                                                                                  viewModel.onSelectingExclusion(i);
                                                                                },
                                                                                initialValue: viewModel.exclusionInitialValue,
                                                                                items: viewModel.zoneNamesExclusion,
                                                                                onConform: (value) {
                                                                                  Logger().w(value);
                                                                                  viewModel.onChangingExclusion(value);
                                                                                },
                                                                              )
                                                                            ],
                                                                          ),
                                                                          viewModel.isAddingInclusionZone
                                                                              ? ZoneCreatingWidget(
                                                                                  onCreate: () {
                                                                                    viewModel.onCreatingInclusionZone();
                                                                                  },
                                                                                  controller: viewModel.inclusionZoneName,
                                                                                  onCancel: () {
                                                                                    viewModel.onCreateInclusionZone();
                                                                                  },
                                                                                  isDrawing: viewModel.isDrawing,
                                                                                  centerPosition: viewModel.centerPosition,
                                                                                  circle: viewModel.circle,
                                                                                  onDeleting: () {
                                                                                    viewModel.onDeleting();
                                                                                  },
                                                                                  onEditing: () {
                                                                                    viewModel.onEditing();
                                                                                  },
                                                                                  googleMapController: viewModel.googleMapController,
                                                                                  onInclusionZoneCreating: (value) {
                                                                                    viewModel.onInclusionZoneCreating(value);
                                                                                  },
                                                                                  onSliderChange: (range) {
                                                                                    viewModel.onSliderChange(range);
                                                                                  },
                                                                                  radius: viewModel.radius,
                                                                                )
                                                                              : SizedBox(),
                                                                          viewModel.isAddingExclusionZone
                                                                              ? ZoneCreatingWidget(
                                                                                  onCreate: () {
                                                                                    viewModel.onCreatingExclusionZone();
                                                                                  },
                                                                                  controller: viewModel.exclusionZoneName,
                                                                                  onCancel: () {
                                                                                    viewModel.onCreateExclusionZone();
                                                                                  },
                                                                                  isDrawing: viewModel.isDrawing,
                                                                                  centerPosition: viewModel.centerPosition,
                                                                                  circle: viewModel.circle,
                                                                                  onDeleting: () {
                                                                                    viewModel.onDeleting();
                                                                                  },
                                                                                  onEditing: () {
                                                                                    viewModel.onEditing();
                                                                                  },
                                                                                  googleMapController: viewModel.googleMapController,
                                                                                  onInclusionZoneCreating: (value) {
                                                                                    viewModel.onInclusionZoneCreating(value);
                                                                                  },
                                                                                  onSliderChange: (range) {
                                                                                    viewModel.onSliderChange(range);
                                                                                  },
                                                                                  radius: viewModel.radius,
                                                                                )
                                                                              : SizedBox(),
                                                                        ],
                                                                      )
                                                                    : viewModel.dropDownInitialValue ==
                                                                            "Geofence"
                                                                        ? Column(
                                                                            children: [
                                                                              viewModel.isEditing
                                                                                  ? MultiSelectionDropDownWidget(
                                                                                      initialValue: "${viewModel.geofenceAddedNameBR}",
                                                                                      items: viewModel.geoenceData,
                                                                                      onConform: (value) {
                                                                                        viewModel.onConformingDropDown(value);
                                                                                      },
                                                                                      onSelected: (i) {
                                                                                        viewModel.onEditSelectingDropDown(i);
                                                                                      },
                                                                                    )
                                                                                  : MultiSelectionDropDownWidget(
                                                                                      initialValue: "${viewModel.geofenceNameBR}",
                                                                                      items: viewModel.geoenceData,
                                                                                      onConform: (value) {
                                                                                        viewModel.onConformingDropDown(value);
                                                                                      },
                                                                                      onSelected: (i) {
                                                                                        viewModel.onSelectingDropDown(i);
                                                                                      },
                                                                                    ),
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                    border: Border.all(
                                                                                      color: Theme.of(context).textTheme.bodyText1!.color!,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(10)),
                                                                                child: viewModel.isEditing
                                                                                    ? CustomDropDownWidget(
                                                                                        textColorChange: viewModel.isEditing ? true : false,
                                                                                        onChanged: null,
                                                                                        items: viewModel.notificationSubTypesEdit,
                                                                                        value: viewModel.dropDownSubInitialValueEdit,
                                                                                      )
                                                                                    : CustomDropDownWidget(
                                                                                        //istappable: !viewModel.isEditing,
                                                                                        onChanged: (value) {
                                                                                          Logger().e(value);
                                                                                          viewModel.onChangingSubType(value);
                                                                                        },
                                                                                        items: viewModel.notificationSubTypes,
                                                                                        value: viewModel.dropDownSubInitialValue,
                                                                                      ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  InsiteText(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    text: "After Occurences",
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Container(
                                                                                      height: MediaQuery.of(context).size.height * 0.05,
                                                                                      child: CustomTextBox(
                                                                                        //isenabled: widget.isEnable == null ? true : widget.isEnable,
                                                                                        isenabled: false,
                                                                                        keyPadType: TextInputType.number,
                                                                                        //controller: widget.controller,
                                                                                        title: "1",
                                                                                      )),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          )
                                                                        : viewModel.dropDownInitialValue ==
                                                                                "Asset Status"
                                                                            ? Column(
                                                                                children: [
                                                                                  Container(
                                                                                    decoration: BoxDecoration(
                                                                                        border: Border.all(
                                                                                          color: Theme.of(context).textTheme.bodyText1!.color!,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(10)),
                                                                                    child: viewModel.isEditing
                                                                                        ? CustomDropDownWidget(
                                                                                            textColorChange: viewModel.isEditing ? true : false,
                                                                                            // istappable:
                                                                                            //     !viewModel
                                                                                            //         .isEditing,
                                                                                            // onChanged: (value) {
                                                                                            //   Logger().e(value);
                                                                                            //   viewModel.onChangingSubType(value);
                                                                                            // },
                                                                                            onChanged: null,
                                                                                            items: viewModel.notificationSubTypes,
                                                                                            value: viewModel.dropDownSubInitialValue,
                                                                                          )
                                                                                        : CustomDropDownWidget(
                                                                                            //textColorChange: viewModel.isEditing ? true : false,
                                                                                            // istappable:
                                                                                            //     !viewModel
                                                                                            //         .isEditing,
                                                                                            onChanged: (value) {
                                                                                              Logger().e(value);
                                                                                              viewModel.onChangingSubType(value);
                                                                                            },

                                                                                            items: viewModel.notificationSubTypes,
                                                                                            value: viewModel.dropDownSubInitialValue,
                                                                                          ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      InsiteText(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        text: "After Occurences",
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Container(
                                                                                          height: MediaQuery.of(context).size.height * 0.05,
                                                                                          child: CustomTextBox(
                                                                                            //isenabled: widget.isEnable == null ? true : widget.isEnable,
                                                                                            isenabled: false,
                                                                                            keyPadType: TextInputType.number,
                                                                                            //controller: widget.controller,
                                                                                            title: "1",
                                                                                          )),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              )
                                                                            : Column(
                                                                                children: [
                                                                                  Container(
                                                                                    decoration: BoxDecoration(
                                                                                        border: Border.all(
                                                                                          color: Theme.of(context).textTheme.bodyText1!.color!,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(10)),
                                                                                    child: CustomDropDownWidget(
                                                                                      // istappable:
                                                                                      //     !viewModel
                                                                                      //         .isEditing,
                                                                                      onChanged: (value) {
                                                                                        Logger().e(value);
                                                                                        viewModel.onChangingSubType(value);
                                                                                      },
                                                                                      items: viewModel.notificationSubTypes,
                                                                                      value: viewModel.dropDownSubInitialValue,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  // viewModel.dropDownSubInitialValue ==
                                                                                  //         "Overdue"
                                                                                  //     ? Column(
                                                                                  //         children: List.generate(viewModel.overDueState.length, (i) {
                                                                                  //         return Column(
                                                                                  //           children: [
                                                                                  //             TextBoxWithSwitch(
                                                                                  //               onTap: () {
                                                                                  //                 viewModel.checkingOverduestate(i);
                                                                                  //               },
                                                                                  //               controller: viewModel.overDueState[i].controller,
                                                                                  //               isEnable: viewModel.overDueState[i].state,
                                                                                  //               title: viewModel.overDueState[i].text,
                                                                                  //             ),
                                                                                  //             SizedBox(
                                                                                  //               height: 20,
                                                                                  //             ),
                                                                                  //           ],
                                                                                  //         );
                                                                                  //       }))
                                                                                  //     : viewModel.dropDownSubInitialValue == "Upcoming"
                                                                                  //         ? Column(
                                                                                  //             children: List.generate(viewModel.upcomingState.length, (i) {
                                                                                  //             return Column(
                                                                                  //               children: [
                                                                                  //                 TextBoxWithSwitch(
                                                                                  //                   onTap: () {
                                                                                  //                     viewModel.checkingUpcomingState(i);
                                                                                  //                   },
                                                                                  //                   controller: viewModel.upcomingState[i].controller,
                                                                                  //                   isEnable: viewModel.upcomingState[i].state,
                                                                                  //                   title: viewModel.upcomingState[i].text,
                                                                                  //                   suffixTitle: viewModel.upcomingState[i].suffixTitle,
                                                                                  //                 ),
                                                                                  //                 SizedBox(
                                                                                  //                   height: 20,
                                                                                  //                 ),
                                                                                  //               ],
                                                                                  //             );
                                                                                  //           }))
                                                                                  //         :
                                                                                  viewModel.dropDownInitialValue == "Asset Status"
                                                                                      ? Column(
                                                                                          children: [
                                                                                            InsiteText(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              text: "After Occurences",
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 10,
                                                                                            ),
                                                                                            Container(
                                                                                                height: MediaQuery.of(context).size.height * 0.05,
                                                                                                child: CustomTextBox(
                                                                                                  //isenabled: widget.isEnable == null ? true : widget.isEnable,
                                                                                                  isenabled: false,
                                                                                                  keyPadType: TextInputType.number,
                                                                                                  //controller: widget.controller,
                                                                                                  title: "1",
                                                                                                )),
                                                                                          ],
                                                                                        )
                                                                                      : viewModel.dropDownInitialValue == "Engine Hours"
                                                                                          ? TextBoxWithSuffixAndPrefix(
                                                                                              suffixTitle: "Hours",
                                                                                              controller: viewModel.assetStatusOccurenceController,
                                                                                              onChange: (value) {
                                                                                                viewModel.onChangingOccurence(value);
                                                                                              },
                                                                                            )
                                                                                          : viewModel.dropDownInitialValue == "Fuel"
                                                                                              ? TextBoxWithSuffixAndPrefix(
                                                                                                  suffixTitle: "%",
                                                                                                  controller: viewModel.assetStatusOccurenceController,
                                                                                                  onChange: (value) {
                                                                                                    viewModel.onChangingOccurence(value);
                                                                                                  },
                                                                                                )
                                                                                              // : viewModel.dropDownInitialValue == "Odometer"
                                                                                              //     ? TextBoxWithSuffixAndPrefix(
                                                                                              //         suffixTitle: "Miles",
                                                                                              //         controller: viewModel.odometerOccurenceController,
                                                                                              //         onChange: (value) {
                                                                                              //           //viewModel.onChagingeOdometerOccurenceBox(value);
                                                                                              //         },
                                                                                              //       )
                                                                                              : viewModel.dropDownInitialValue == "Excessive Daily Idle"
                                                                                                  ? TextBoxWithSuffixAndPrefix(
                                                                                                      suffixTitle: "Hours",
                                                                                                      controller: viewModel.assetStatusOccurenceController,
                                                                                                      onChange: (value) {
                                                                                                        viewModel.onChangingOccurence(value);
                                                                                                      },
                                                                                                    )
                                                                                                  : SizedBox()
                                                                                ],
                                                                              )),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        // Divider(
                        //   thickness: 2.0,
                        //   color: cardcolor,
                        //   height: 2.0,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InsiteText(
                                    text: "Schedule Times",
                                    size: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Wrap(
                                    spacing: mediaquerry.size.width * 0.035,
                                    children: List.generate(
                                        viewModel.schedule.length,
                                        (i) => DayCheck(
                                              onTap: () {
                                                viewModel.onDaysSelected(i);
                                              },
                                              checkingAllDays:
                                                  viewModel.checkingAllDay,
                                              isSelected: viewModel
                                                  .schedule[i].isSelected,
                                              color:
                                                  viewModel.schedule[i].color,
                                              day: viewModel.schedule[i].title,
                                            ))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TimeSlots(
                                initialvalue: viewModel.startTime,
                                endValue: viewModel.endTime,
                                userPreference: viewModel.userPref,
                                  initialTypeValue: viewModel.initialDayOption,
                                  type: viewModel.days,
                                  initialEndValue:
                                      "To :- ${viewModel.initialEndValue}",
                                  initialStartValue:
                                      "From :- ${viewModel.initialStartValue}",
                                  onSwitchChange: (value) {
                                    viewModel.onSwitchAllscheduleDate(value, 1);
                                  },
                                  typeChanged: (value) {
                                    viewModel.updateType(value!, 1);
                                  },
                                  startTimeChanged: (value,startTime) {
                                    viewModel.updateStartTime(value!, 1,startTime!);
                                  },
                                  endTimeChanged: (value,endTime) {
                                    viewModel.updateEndTime(value!, 1,endTime!);
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: InsiteButton(
                                  onTap: () {
                                    viewModel.onSelectingDays();
                                  },
                                  fontSize: 16,
                                  height: 40,
                                  width: 200,
                                  textColor: textcolor,
                                  bgColor: Theme.of(context).buttonColor,
                                  title: "Add",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              viewModel.scheduleDay.isNotEmpty
                                  ? Center(
                                      child: Column(
                                        children: List.generate(
                                            viewModel.scheduleDay.length,
                                            (i) => Column(
                                                  children: [
                                                    Container(
                                                      width: mediaquerry
                                                              .size.width *
                                                          0.9,
                                                      height: mediaquerry
                                                              .size.height *
                                                          0.09,
                                                      decoration: BoxDecoration(
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: black,
                                                              blurRadius: 2,
                                                            )
                                                          ]),
                                                      child: ListTile(
                                                        trailing: IconButton(
                                                            onPressed: () {
                                                              viewModel
                                                                  .onDeletingSelectedDays(
                                                                      i);
                                                            },
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .color,
                                                            )),
                                                        title: InsiteText(
                                                            text:
                                                                "Days : ${viewModel.scheduleDay[i].title}"),
                                                        subtitle: InsiteText(
                                                            text:
                                                                "Schedule Time : ${viewModel.scheduleDay[i].startTime} - ${viewModel.scheduleDay[i].endTime}"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    )
                                                  ],
                                                )),
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Choose by : ",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: viewModel.isEditing
                                          ? Container(
                                              width: 400,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InsiteText(
                                                  text: viewModel
                                                      .assetSelectionValue,
                                                  size: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            )
                                          : viewModel.dropDownInitialValue ==
                                                  "Geofence"
                                              ? CustomDropDownWidget(
                                                  value: viewModel
                                                              .assetSelectionValue ==
                                                          "Geofences"
                                                      ? null
                                                      : viewModel
                                                          .assetSelectionValue,
                                                  items: viewModel.choiseDatas,
                                                  enableHint: true,
                                                  onChanged: (String? value) {
                                                    viewModel
                                                        .updateModelValueChooseBy(
                                                            value!);
                                                  },
                                                )
                                              : CustomDropDownWidget(
                                                  value: viewModel
                                                      .assetSelectionValue,
                                                  items: viewModel.choiseData,
                                                  enableHint: true,
                                                  onChanged: (String? value) {
                                                    viewModel
                                                        .updateModelValueChooseBy(
                                                            value!);
                                                  },
                                                ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    viewModel.isLoading
                                        ? Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.45,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              child: Card(
                                                child: Center(
                                                  child: InsiteProgressBar(),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Center(
                                            child: AssetSelectionWidgetView(
                                              onRemoving: () {
                                                viewModel.onRemoving();
                                              },
                                              key:
                                                  viewModel.assetSelectionState,
                                              addingAllAsset: (data) {
                                                viewModel
                                                    .onAddingAllAsset(data);
                                              },
                                              onAddingAsset: (i, value) {
                                                viewModel.onAddingAsset(
                                                    i, value);
                                              },
                                              assetData: (value) {},
                                              assetResult:
                                                  viewModel.assetIdresult,
                                              dropdownValue:
                                                  viewModel.assetSelectionValue,
                                            ),
                                          ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SelectedAsset(
                                      isLoading: viewModel.isLoading,
                                      dropDownList: viewModel.dropDownList,
                                      initialValue: viewModel.initialValue,
                                      onChange: (value) {
                                        viewModel.onChangingInitialValue(value);
                                      },
                                      onChangeSearchBox: (value) {
                                        viewModel
                                            .onChangingSelectedAsset(value);
                                      },
                                      onDeletingSelectedAsset: (i) {
                                        viewModel.onDeletingAsset(i);
                                      },
                                      selectedDropDownValue:
                                          viewModel.assetSelectionValue,
                                      displayList: viewModel.isSearching
                                          ? viewModel.searchAsset
                                          : viewModel.selectedAsset,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Divider(
                              //   thickness: 2.0,
                              //   color: cardcolor,
                              //   height: 2.0,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Select Recipients",
                                      fontWeight: FontWeight.bold,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InsiteText(
                                          text:
                                              "Provide the email address in a suitable format.",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomTextBox(
                                            title: "Search Contact",
                                            controller:
                                                viewModel.emailController,
                                            onChanged: (searchText) {
                                              viewModel
                                                  .searchContacts(searchText);
                                            }),
                                        viewModel.isHideSearchList
                                            ? Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black,
                                                          // blurStyle: BlurStyle.outer,
                                                          blurRadius: 0.5,
                                                          spreadRadius: 0.2)
                                                    ]),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: List.generate(
                                                        viewModel
                                                            .searchContactListName!
                                                            .length,
                                                        (i) =>
                                                            DeviceIdListWidget(
                                                                onSelected: () {
                                                                  viewModel.onSelectingEmailList(
                                                                      viewModel
                                                                          .searchContactListName![
                                                                              i]
                                                                          .email!);
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                },
                                                                name: viewModel
                                                                    .searchContactListName![
                                                                        i]
                                                                    .name,
                                                                deviceId: viewModel
                                                                    .searchContactListName![
                                                                        i]
                                                                    .email)),
                                                  ),
                                                ))
                                            : SizedBox(),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        InsiteButton(
                                          onTap: viewModel.addContact,
                                          fontSize: 16,
                                          height: 50,
                                          width: 200,
                                          textColor: textcolor,
                                          bgColor:
                                              Theme.of(context).buttonColor,
                                          title: "Add contact",
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // viewModel.selectedContactItems!.isNotEmpty
                                    //     ? Container(
                                    //         height:
                                    //             MediaQuery.of(context).size.height * 0.3,
                                    //         decoration: BoxDecoration(border: Border.all()),
                                    //         child: ListView.builder(
                                    //             itemCount:
                                    //                 viewModel.selectedContactItems!.length,
                                    //             itemBuilder: (context, index) {
                                    //               final email = viewModel
                                    //                   .selectedContactItems![index];
                                    //               return SelectedContactListItem(
                                    //                 email: email,
                                    //                 voidCallback: () {
                                    //                   viewModel
                                    //                       .onRemovedSelectedContact(index);
                                    //                 },
                                    //               );
                                    //             }))
                                    //     : SizedBox(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    viewModel.isShowingSelectedContact
                                        ? Column(
                                            children: List.generate(
                                              viewModel.selectedUser.length,
                                              (i) => Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .backgroundColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: black,
                                                            blurRadius: 2,
                                                          )
                                                        ]),
                                                    child: Center(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          InsiteText(
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .color,
                                                            text: viewModel
                                                                .selectedUser[i]
                                                                .email!,
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                viewModel
                                                                    .onRemovedSelectedContact(
                                                                        i);
                                                              },
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .color,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InsiteButton(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          title: "cancel".toUpperCase(),
                                          fontSize: 12,
                                          bgColor:
                                              Theme.of(context).backgroundColor,
                                          onTap: () {
                                            viewModel.cancel(context);
                                          },
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        InsiteButton(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          title: "save".toUpperCase(),
                                          fontSize: 12,
                                          textColor: white,
                                          onTap: () {
                                            viewModel.saveAddNotificationData();
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40.0,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        //   gridDelegate:
                        //       const SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2,
                        //   ),
                        //   itemCount: 2,
                        //   itemBuilder: (BuildContext context, int i) {

                        //   },
                        // ),
                        // TabBar(
                        //     onTap: (i) {
                        //       viewModel.changingTabColor(i);
                        //     },
                        //     indicator: BoxDecoration(
                        //         color: Theme.of(context).buttonColor,
                        //         borderRadius: BorderRadius.circular(10)),
                        //     tabs: List.generate(
                        //         viewModel.schedule.length,
                        //         (i) => DayCheck(
                        //               color: viewModel.schedule[i].color,
                        //               day: viewModel.schedule[i].title,
                        //             ))),

                        // Container(
                        //   height: 160,
                        //   child: TabBarView(
                        //       children: List.generate(
                        //           viewModel.schedule.length, (i) {
                        //     return TimeSlots(
                        //         isSelected: viewModel.schedule[i].isSelected,
                        //         onSwitchChange: (value) {
                        //           viewModel.onSwitchAllscheduleDate(value, i);
                        //         },
                        //         type: viewModel.schedule[i].items,
                        //         initialTypeValue:
                        //             viewModel.schedule[i].initialVale,
                        //         initialStartValue:
                        //             viewModel.schedule[i].startTime,
                        //         initialEndValue:
                        //             viewModel.schedule[i].endTime,
                        //         typeChanged: (value) {
                        //           viewModel.updateType(value!, i);
                        //         },
                        //         startTimeChanged: (value) {
                        //           viewModel.updateStartTime(value!, i);
                        //         },
                        //         endTimeChanged: (value) {
                        //           viewModel.updateEndTime(value!, i);
                        //         });
                        //   })),
                        // ),

                        // Divider(
                        //   thickness: 2.0,
                        //   color: cardcolor,
                        //   height: 2.0,
                        // ),
                      ],
                    ),
                  ),
          ),
        );
      },
      viewModelBuilder: () => AddNewNotificationsViewModel(widget.alertData,context),
    );
  }

//  Color? getColors(SwitchState listData) {
//     if(listData.text=="Customize"){
//      if(listData.state==)

//     }
//     return null;
//   }
}
