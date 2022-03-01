import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/add_group/selection_widget/selection_widget_view.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/model/alert_config_edit.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/custom_dropdown_add_notification.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/expansion_card.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/text_box_with_switch.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/textbox_with_suffix_prefix.dart';
import 'package:insite/views/subscription/replacement/device_replacement/device_replacement_widget.dart/deviceId_widget_list.dart';

import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/day_check.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/time_slots.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'add_new_notifications_view_model.dart';
import 'reusable_widget/dropdown_widget_with_google_map.dart';
import 'reusable_widget/multi_custom_dropDown_widget.dart';
import 'reusable_widget/selcted_card_widget.dart';
import 'reusable_widget/zone_creating_widget.dart';

class AddNewNotificationsView extends StatefulWidget {
  final AlertConfigEdit? alertData;
  AddNewNotificationsView({this.alertData});
  @override
  State<AddNewNotificationsView> createState() =>
      _AddNewNotificationsViewState();
}

class _AddNewNotificationsViewState extends State<AddNewNotificationsView>
    with TickerProviderStateMixin {
  bool isEdit = false;

  Widget showingSwitchableWidgetWithTitle(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsiteText(
          text: "Severity :",
        ),
        child,
      ],
    );
  }

  Widget showingSwitchableWidget(
      List<SwitchState> listData, Function checkingSwitchState) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            listData.length,
            (i) => Column(
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          checkingSwitchState(i);
                        },
                        icon: Icon(
                          Icons.crop_square,
                          color: listData[i].state!
                              ? Theme.of(context).buttonColor
                              : Theme.of(context).cardColor,
                        ),
                        label: InsiteText(
                          text: listData[i].text,
                        )),
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
            body: SingleChildScrollView(
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
                          title: "Notification",
                          controller: viewModel.notificationController,
                          onChanged: (value) {
                            viewModel.checkIfNotificationNameExist(value);
                          },
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
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: CustomDropDownAddNotificationWidget(
                              dropDownValue: (value) {
                                viewModel.updateModelValue(value);
                              },
                              value: viewModel.dropDownInitialValue,
                              administratortAssets:
                                  viewModel.administratortAssets,
                              geofenceAssets: viewModel.geofenceAssets,
                              reportFleetAssets:
                                  viewModel.notificationFleetType,
                              reportServiceAssets:
                                  viewModel.notificationServiceType,
                              isShowingDropDownState: true,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        viewModel.showZone
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Configure Notification Type",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    viewModel.dropDownInitialValue !=
                                                "Switches" &&
                                            viewModel.dropDownInitialValue !=
                                                "Power Mode"
                                        ? Card(
                                            color: cardcolor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InsiteText(
                                                text:
                                                    "You can configure only one inclusion zone and a maximum of five exclusion zones",
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: viewModel.dropDownInitialValue ==
                                                "Fuel Loss"
                                            ? TextBoxWithSuffixAndPrefix(
                                                suffixTitle: "%",
                                                controller: viewModel
                                                    .fuelLosssOccurenceController,
                                                onChange: (value) {
                                                  // viewModel
                                                  //     .onChagingeFuelLossOccurenceBox(
                                                  //         value);
                                                },
                                              )
                                            : viewModel.dropDownInitialValue ==
                                                    "Switches"
                                                ? showingSwitchableWidget(
                                                    viewModel.switchState,
                                                    viewModel
                                                        .checkingSwitchState)
                                                : viewModel.dropDownInitialValue ==
                                                        "Power Mode"
                                                    ? showingSwitchableWidget(
                                                        viewModel
                                                            .powerModeState,
                                                        viewModel
                                                            .checkingPowerModeState)
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
                                                                          .checkingSeverityState),
                                                                ),
                                                                showingSwitchableWidgetWithTitle(
                                                                  "Fault Code Type :",
                                                                  showingSwitchableWidget(
                                                                      viewModel
                                                                          .faultCodeType,
                                                                      viewModel
                                                                          .checkingFaultCodeTypeState),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                    child:
                                                                        TextBoxWithSuffixAndPrefix(
                                                                  prefixTitle:
                                                                      "After",
                                                                  suffixTitle:
                                                                      "Occurences",
                                                                  controller:
                                                                      viewModel
                                                                          .occurenceController,
                                                                  onChange:
                                                                      (value) {
                                                                    // viewModel
                                                                    //     .onChagingOccurenceBox(
                                                                    //         value);
                                                                  },
                                                                )),
                                                                SizedBox(
                                                                    height: 10),
                                                                showingSwitchableWidget(
                                                                    viewModel
                                                                        .customizable,
                                                                    viewModel
                                                                        .onCustomiozablestateChange),
                                                                viewModel
                                                                        .customizable
                                                                        .first
                                                                        .state!
                                                                    ? Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 20),
                                                                        child: showingSwitchableWidget(
                                                                            viewModel.customizableState,
                                                                            viewModel.checkingCustomizeableState),
                                                                      )
                                                                    : SizedBox(),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                viewModel
                                                                        .customizable
                                                                        .first
                                                                        .state!
                                                                    ? Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
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
                                                                            height:
                                                                                mediaquerry.size.height * 0.5,
                                                                            child:
                                                                                ExpansionCardWidget(
                                                                              title: viewModel.expansionTitle,
                                                                              // isLoadMore: viewModel.loadingMore,
                                                                              onExpanded: (boolValue, index) {
                                                                                viewModel.onExpansion(boolValue, index);
                                                                              },
                                                                              items: viewModel.faultCodeTypeSearch!,
                                                                              scrollController: viewModel.faultCodeScrollController,
                                                                              onChange: (value) {
                                                                                viewModel.onChangingFaultCode(value);
                                                                              },
                                                                              textController: viewModel.faultCodeSearchController,
                                                                              onDiagnosticFrontPressed: () {
                                                                                viewModel.onDiagnosticFrontPressed();
                                                                              },
                                                                              onEventFrontPressed: () {
                                                                                viewModel.onEventFrontPressed();
                                                                              },
                                                                              isFaultCodePressed: viewModel.isFaultCodePressed,
                                                                              controller: viewModel.pageController,
                                                                              onDescriptionBackPressed: () {
                                                                                viewModel.onDescriptionBackPressed();
                                                                              },
                                                                              onFaultCodeFrontPressed: () {
                                                                                viewModel.onFaultCodeFrontPressed();
                                                                              },
                                                                              onDescriptionFrontPressed: () {
                                                                                viewModel.onDescriptionFrontPressed();
                                                                              },
                                                                              onAdding: (i) {
                                                                                viewModel.onAddingFaultCode(i);
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          viewModel.SelectedfaultCodeTypeSearch!.isNotEmpty
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
                                                                            .all(
                                                                        8.0),
                                                                child: showingSwitchableWidgetWithTitle(
                                                                    "Severity :",
                                                                    showingSwitchableWidget(
                                                                        viewModel
                                                                            .fluidAnalysisState,
                                                                        viewModel
                                                                            .checkingFluidAnalysisState)),
                                                              )
                                                            : viewModel.dropDownInitialValue ==
                                                                    "Inspection"
                                                                ? Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: showingSwitchableWidgetWithTitle(
                                                                        "Severity :",
                                                                        showingSwitchableWidget(
                                                                            viewModel.inspectionState,
                                                                            viewModel.checkingInspectionState)),
                                                                  )
                                                                : viewModel.dropDownInitialValue ==
                                                                        "Asset Security"
                                                                    ? Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: showingSwitchableWidgetWithTitle(
                                                                            "Status :",
                                                                            showingSwitchableWidget(viewModel.assetSecurityState,
                                                                                viewModel.checkingAssetSecurityState)),
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
                                                                                  MultiSelectionDropDownWidget(
                                                                                    initialValue: "${viewModel.selectedList.length} Geofence Selected",
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
                                                                                    child: CustomDropDownWidget(
                                                                                      istappable: !viewModel.isEditing,
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
                                                                                  TextBoxWithSuffixAndPrefix(
                                                                                    prefixTitle: "After",
                                                                                    suffixTitle: "Occurences",
                                                                                    controller: viewModel.assetStatusOccurenceController,
                                                                                    onChange: (value) {
                                                                                      //  viewModel.onChagingAssetOccurenceBox(value);
                                                                                    },
                                                                                  )
                                                                                ],
                                                                              )
                                                                            : Padding(
                                                                                padding: const EdgeInsets.all(10.0),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      decoration: BoxDecoration(
                                                                                          border: Border.all(
                                                                                            color: Theme.of(context).textTheme.bodyText1!.color!,
                                                                                          ),
                                                                                          borderRadius: BorderRadius.circular(10)),
                                                                                      child: CustomDropDownWidget(
                                                                                        istappable: !viewModel.isEditing,
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
                                                                                    viewModel.dropDownSubInitialValue == "Overdue"
                                                                                        ? Column(
                                                                                            children: List.generate(viewModel.overDueState.length, (i) {
                                                                                            return Column(
                                                                                              children: [
                                                                                                TextBoxWithSwitch(
                                                                                                  onTap: () {
                                                                                                    viewModel.checkingOverduestate(i);
                                                                                                  },
                                                                                                  controller: viewModel.overDueState[i].controller,
                                                                                                  isEnable: viewModel.overDueState[i].state,
                                                                                                  title: viewModel.overDueState[i].text,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 20,
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          }))
                                                                                        : viewModel.dropDownSubInitialValue == "Upcoming"
                                                                                            ? Column(
                                                                                                children: List.generate(viewModel.upcomingState.length, (i) {
                                                                                                return Column(
                                                                                                  children: [
                                                                                                    TextBoxWithSwitch(
                                                                                                      onTap: () {
                                                                                                        viewModel.checkingUpcomingState(i);
                                                                                                      },
                                                                                                      controller: viewModel.upcomingState[i].controller,
                                                                                                      isEnable: viewModel.upcomingState[i].state,
                                                                                                      title: viewModel.upcomingState[i].text,
                                                                                                      suffixTitle: viewModel.upcomingState[i].suffixTitle,
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 20,
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              }))
                                                                                            : viewModel.dropDownInitialValue == "Asset Status"
                                                                                                ? TextBoxWithSuffixAndPrefix(
                                                                                                    prefixTitle: "After",
                                                                                                    suffixTitle: "Occurences",
                                                                                                    controller: viewModel.assetStatusOccurenceController,
                                                                                                    onChange: (value) {
                                                                                                      //viewModel.onChagingAssetOccurenceBox(value);
                                                                                                    },
                                                                                                  )
                                                                                                : viewModel.dropDownInitialValue == "Engine Hours"
                                                                                                    ? TextBoxWithSuffixAndPrefix(
                                                                                                        suffixTitle: "Hours",
                                                                                                        controller: viewModel.engineHoursOccurenceController,
                                                                                                        onChange: (value) {
                                                                                                          //viewModel.onChagingeEngineHourOccurenceBox(value);
                                                                                                        },
                                                                                                      )
                                                                                                    : viewModel.dropDownInitialValue == "Fuel"
                                                                                                        ? TextBoxWithSuffixAndPrefix(
                                                                                                            suffixTitle: "%",
                                                                                                            controller: viewModel.fuelOccurenceController,
                                                                                                            onChange: (value) {
                                                                                                              //viewModel.onChagingeFuelOccurenceBox(value);
                                                                                                            },
                                                                                                          )
                                                                                                        : viewModel.dropDownInitialValue == "Odometer"
                                                                                                            ? TextBoxWithSuffixAndPrefix(
                                                                                                                suffixTitle: "Miles",
                                                                                                                controller: viewModel.odometerOccurenceController,
                                                                                                                onChange: (value) {
                                                                                                                  //viewModel.onChagingeOdometerOccurenceBox(value);
                                                                                                                },
                                                                                                              )
                                                                                                            : viewModel.dropDownInitialValue == "Excessive Daily Idle"
                                                                                                                ? TextBoxWithSuffixAndPrefix(
                                                                                                                    suffixTitle: "Hours",
                                                                                                                    controller: viewModel.excessiveDailyOccurenceController,
                                                                                                                    onChange: (value) {
                                                                                                                      // viewModel.onChagingeExcessiveOccurenceBox(value);
                                                                                                                    },
                                                                                                                  )
                                                                                                                : SizedBox()
                                                                                  ],
                                                                                ),
                                                                              )),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: cardcolor,
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        InsiteText(
                          text: "Schedule Times",
                          size: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: DefaultTabController(
                      length: viewModel.schedule.length,
                      child: Column(
                        children: [
                          TabBar(
                              indicator: BoxDecoration(
                                  color: Theme.of(context).buttonColor,
                                  borderRadius: BorderRadius.circular(10)),
                              tabs: List.generate(
                                  viewModel.schedule.length,
                                  (i) => DayCheck(
                                        day: viewModel.schedule[i].title,
                                      ))),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 160,
                            child: TabBarView(
                                children: List.generate(
                                    viewModel.schedule.length, (i) {
                              return TimeSlots(
                                  type: viewModel.schedule[i].items,
                                  initialTypeValue:
                                      viewModel.schedule[i].initialVale,
                                  initialStartValue:
                                      viewModel.schedule[i].startTime,
                                  initialEndValue:
                                      viewModel.schedule[i].endTime,
                                  typeChanged: (value) {
                                    viewModel.updateType(value!, i);
                                  },
                                  startTimeChanged: (value) {
                                    viewModel.updateStartTime(value!, i);
                                  },
                                  endTimeChanged: (value) {
                                    viewModel.updateEndTime(value!, i);
                                  });
                            })),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: cardcolor,
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
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
                              borderRadius: BorderRadius.circular(10)),
                          child: CustomDropDownWidget(
                            value: "Assets",
                            items: viewModel.choiseData,
                            enableHint: true,
                            onChanged: (String? value) {
                              // viewModel.updateModelValue(value!);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SelectionWidgetView(
                          isEdit: isEdit,
                          //assetIds: viewModel.assetUidData,
                          group: viewModel.groups,
                          dissociatedIds: viewModel.assetUidData,
                          onAssetSelected: (
                            List<String> value,
                            List<String> associatedAssetId,
                          ) {
                            viewModel.assetUidData = value;
                            //viewModel.groupSummaryResponseData = data;
                            //viewModel.associatedAssetId = associatedAssetId;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2.0,
                    color: cardcolor,
                    height: 2.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
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
                          color: cardcolor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InsiteText(
                              text:
                                  "Provide the email address in a suitable format. The SMS/text email address must be in a suitable format for the mobile carrier: <number>@<mobile carrier’s SMS gateway address>. For example, 1234567890@txt.att.net (AT&T U.S.) or 9876543210@vtext.com (Verizon U.S.). Contact your mobile carrier for the correct format for the number and SMS gateway address.",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextBox(
                                title: "Search Contact",
                                controller: viewModel.emailController,
                                onChanged: (searchText) {
                                  if (searchText.isNotEmpty) {
                                    viewModel.searchContacts(searchText);
                                  } else {
                                    viewModel.searchContacts(searchText);
                                  }
                                }),
                            viewModel.isHideSearchList
                                ? Container(
                                    margin: EdgeInsets.all(8),
                                    // height: 120,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    child: Column(
                                      children: List.generate(
                                          viewModel
                                              .searchContactListName!.length,
                                          (i) => SingleChildScrollView(
                                                child: DeviceIdListWidget(
                                                    onSelected: () {
                                                      viewModel
                                                          .onSelectingEmailList(
                                                              viewModel
                                                                  .searchContactListName![
                                                                      i]
                                                                  .email!);
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    deviceId: viewModel
                                                        .searchContactListName![
                                                            i]
                                                        .email),
                                              )),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Theme.of(context).cardColor),
                                        child: Center(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InsiteText(
                                                text: viewModel
                                                    .selectedUser[i].email!,
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
                                                  icon: Icon(Icons.delete))
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InsiteButton(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.06,
                              title: "cancel".toUpperCase(),
                              fontSize: 12,
                              textColor: textcolor,
                              bgColor: Theme.of(context).cardColor,
                              onTap: () {
                                //viewModel.cancel();
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InsiteButton(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.06,
                              title: "save".toUpperCase(),
                              fontSize: 12,
                              textColor: textcolor,
                              bgColor: Theme.of(context).buttonColor,
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
          ),
        );
      },
      viewModelBuilder: () => AddNewNotificationsViewModel(widget.alertData),
    );
  }
}
