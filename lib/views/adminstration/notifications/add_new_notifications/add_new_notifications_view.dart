import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/notification_type.dart';
import 'package:insite/core/models/search_contact_report_list_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/add_group/selection_widget/selection_widget_view.dart';
import 'package:insite/views/adminstration/add_report/reusable_widget/search_contact_reusable_widget.dart';
import 'package:insite/views/adminstration/add_report/reusable_widget/selected_contact_list_item.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/custom_dropdown_add_notification.dart';
import 'package:insite/views/subscription/options/sub_registration/single_asset_reg/custom_auto_complete_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/add_notification_checkbox.dart';
import 'package:insite/widgets/smart_widgets/day_check.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/time_slots.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'add_new_notifications_view_model.dart';

class AddNewNotificationsView extends StatefulWidget {
  @override
  State<AddNewNotificationsView> createState() =>
      _AddNewNotificationsViewState();
}

class _AddNewNotificationsViewState extends State<AddNewNotificationsView>
    with TickerProviderStateMixin {
  bool isEdit = false;
  Widget build(BuildContext context) {
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
                          onFieldSubmmit: (value) {
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
                            value: viewModel.dropDownInitialValue,
                            items: viewModel.notificationTypes,
                            enableHint: true,
                            onChanged: (value) {
                              viewModel.updateModelValue(value!);
                            },
                          ),
                        ),
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
                                    Card(
                                      color: cardcolor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InsiteText(
                                          text:
                                              "You can configure only one inclusion zone and a maximum of five exclusion zones",
                                        ),
                                      ),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:
                                          CustomDropDownAddNotificationWidget(
                                        value: viewModel.inclusionInitialValue,
                                        items: viewModel.zoneNamesInclusion,
                                        enableHint: true,
                                        onChanged: (value) {
                                          viewModel.updateSubModelValue(value!);
                                        },
                                      ),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:
                                          CustomDropDownAddNotificationWidget(
                                        value: viewModel.exclusionInitialValue,
                                        items: viewModel.zoneNamesExclusion,
                                        enableHint: true,
                                        onChanged: (value) {
                                          viewModel.updateSubModelValue(value!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        viewModel.showInspections
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Configure Notification Type",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InsiteText(
                                              text: "Severity",
                                              size: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            NotificationTypeCheckBox(
                                              title: "Red",
                                            ),
                                            NotificationTypeCheckBox(
                                                title: "Yellow"),
                                            NotificationTypeCheckBox(
                                                title: "Green"),
                                            NotificationTypeCheckBox(
                                                title: "Grey"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        viewModel.showAssetSecurity
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Configure Notification Type",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InsiteText(
                                              text: "Severity",
                                              size: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            NotificationTypeCheckBox(
                                                title: "Normal Operation"),
                                            NotificationTypeCheckBox(
                                                title: "Disable"),
                                            NotificationTypeCheckBox(
                                                title: "Derated"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        viewModel.showFluidnalysis
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Configure Notification Type",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InsiteText(
                                              text: "Severity",
                                              size: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            NotificationTypeCheckBox(
                                                title: "Action Required"),
                                            NotificationTypeCheckBox(
                                                title: "Monitor"),
                                            NotificationTypeCheckBox(
                                                title: "No Action"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        viewModel.showFaultCodes
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Configure Notification Type",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InsiteText(
                                              text: "Severity",
                                              size: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            NotificationTypeCheckBox(
                                                title: "High"),
                                            NotificationTypeCheckBox(
                                                title: "Medium"),
                                            NotificationTypeCheckBox(
                                                title: "Low"),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            InsiteText(
                                              text: "Fault code Type",
                                              size: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            NotificationTypeCheckBox(
                                                title: "Event"),
                                            NotificationTypeCheckBox(
                                                title: "Diagnotic"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            NotificationTypeCheckBox(
                                                title: "Customize"),
                                            NotificationTypeCheckBox(
                                                title: "Include"),
                                            NotificationTypeCheckBox(
                                                title: "Exclude"),
                                          ],
                                        ),
                                        Container(
                                          height: 40,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade800,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: InsiteText(
                                                      text: "After",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: 14),
                                                ),
                                              ),
                                              // TextFormField(),
                                              SizedBox(
                                                width: 38,
                                                child: Center(
                                                  child: InsiteText(
                                                    text: "1",
                                                    fontWeight: FontWeight.bold,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade800,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: InsiteText(
                                                      text: "Occurence",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        viewModel.showSwitches
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Configure Notification Type",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NotificationTypeCheckBox(
                                                title: "Open"),
                                            NotificationTypeCheckBox(
                                                title: "Closed"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        viewModel.selectPowerMode
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Configure Notification Type",
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InsiteText(
                                              text: "Status",
                                              size: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            NotificationTypeCheckBox(
                                                title: "Economy"),
                                            NotificationTypeCheckBox(
                                                title: "Standard"),
                                            NotificationTypeCheckBox(
                                                title: "Run"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        viewModel.showNotificationType
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
                                      child:
                                          CustomDropDownAddNotificationWidget(
                                        value:
                                            viewModel.dropDownSubInitialValue,
                                        items: viewModel.notificationSubTypes,
                                        enableHint: true,
                                        onChanged: (value) {
                                          viewModel.updateSubModelValue(value!);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: CustomTextBox(
                                        title: viewModel.occurenceController
                                                .text.isEmpty
                                            ? "    1 "
                                            : viewModel
                                                .occurenceController.text,
                                        controller:
                                            viewModel.occurenceController,
                                        prefixWidget: Container(
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: cardcolor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))),
                                            child: Center(
                                              child: InsiteText(
                                                  text: "After",
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        suffixWidget: Container(
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: cardcolor,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: Center(
                                              child: InsiteText(
                                                  text: "occurence",
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(),
                        viewModel.showMaintainance
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
                                      child:
                                          CustomDropDownAddNotificationWidget(
                                        value:
                                            viewModel.dropDownSubInitialValue,
                                        items: viewModel.notificationSubTypes,
                                        enableHint: true,
                                        onChanged: (value) {
                                          viewModel.updateSubModelValue(value!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        viewModel.showConditionTypes
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
                                      child:
                                          CustomDropDownAddNotificationWidget(
                                        value:
                                            viewModel.dropDownSubInitialValue,
                                        items: viewModel.notificationSubTypes,
                                        enableHint: true,
                                        onChanged: (value) {
                                          viewModel.updateSubModelValue(value!);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: CustomTextBox(
                                        title: "1",
                                        suffixWidget: Container(
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: cardcolor,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: Center(
                                              child: InsiteText(
                                                  text: viewModel.setOdometer
                                                      ? "Miles"
                                                      : "Hours",
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(),
                        viewModel.showFuelLoss
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
                                    Card(
                                      color: cardcolor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InsiteText(
                                          text:
                                              "Notifies you when the fuel level drops by greater than or equal to the specified percentage between the fuel level registered at the last Asset Off event and the fuel level registered at the next Asset On event.",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: CustomTextBox(
                                        title: "1",
                                        suffixWidget: Container(
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: cardcolor,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: Center(
                                              child: InsiteText(
                                                  text: " % ",
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    )
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 100,
                      child: DefaultTabController(
                        length: 7,
                        child: Container(
                          height: 60,
                          child: TabBar(
                              controller: viewModel.controller,
                              indicator: BoxDecoration(
                                  color: Theme.of(context).buttonColor,
                                  borderRadius: BorderRadius.circular(10)),
                              tabs: [
                                DayCheck(day: "S"),
                                DayCheck(day: "M"),
                                DayCheck(day: "T"),
                                DayCheck(day: "W"),
                                DayCheck(day: "TH"),
                                DayCheck(day: "F"),
                                DayCheck(day: "S"),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 150,
                    child:
                        TabBarView(controller: viewModel.controller, children: [
                      TimeSlots(
                          type: viewModel.type,
                          startTime: viewModel.startTimes,
                          endTime: viewModel.endTimes,
                          initialTypeValue: viewModel.initialType,
                          initialStartValue: viewModel.initialStartTime,
                          initialEndValue: viewModel.initialEndTime,
                          typeChanged: (value) {
                            viewModel.updateType(value!);
                          },
                          startTimeChanged: (value) {
                            viewModel.updateStartTime(value!);
                          },
                          endTimeChanged: (value) {
                            viewModel.updateEndTime(value!);
                          }),
                      TimeSlots(
                          type: viewModel.type,
                          startTime: viewModel.startTimes,
                          endTime: viewModel.endTimes,
                          initialTypeValue: viewModel.initialType,
                          initialStartValue: viewModel.initialStartTime,
                          initialEndValue: viewModel.initialEndTime,
                          typeChanged: (value) {
                            viewModel.updateType(value!);
                          },
                          startTimeChanged: (value) {
                            viewModel.updateStartTime(value!);
                          },
                          endTimeChanged: (value) {
                            viewModel.updateEndTime(value!);
                          }),
                      TimeSlots(
                          type: viewModel.type,
                          startTime: viewModel.startTimes,
                          endTime: viewModel.endTimes,
                          initialTypeValue: viewModel.initialType,
                          initialStartValue: viewModel.initialStartTime,
                          initialEndValue: viewModel.initialEndTime,
                          typeChanged: (value) {
                            viewModel.updateType(value!);
                          },
                          startTimeChanged: (value) {
                            viewModel.updateStartTime(value!);
                          },
                          endTimeChanged: (value) {
                            viewModel.updateEndTime(value!);
                          }),
                      TimeSlots(
                          type: viewModel.type,
                          startTime: viewModel.startTimes,
                          endTime: viewModel.endTimes,
                          initialTypeValue: viewModel.initialType,
                          initialStartValue: viewModel.initialStartTime,
                          initialEndValue: viewModel.initialEndTime,
                          typeChanged: (value) {
                            viewModel.updateType(value!);
                          },
                          startTimeChanged: (value) {
                            viewModel.updateStartTime(value!);
                          },
                          endTimeChanged: (value) {
                            viewModel.updateEndTime(value!);
                          }),
                      TimeSlots(
                          type: viewModel.type,
                          startTime: viewModel.startTimes,
                          endTime: viewModel.endTimes,
                          initialTypeValue: viewModel.initialType,
                          initialStartValue: viewModel.initialStartTime,
                          initialEndValue: viewModel.initialEndTime,
                          typeChanged: (value) {
                            viewModel.updateType(value!);
                          },
                          startTimeChanged: (value) {
                            viewModel.updateStartTime(value!);
                          },
                          endTimeChanged: (value) {
                            viewModel.updateEndTime(value!);
                          }),
                      TimeSlots(
                          type: viewModel.type,
                          startTime: viewModel.startTimes,
                          endTime: viewModel.endTimes,
                          initialTypeValue: viewModel.initialType,
                          initialStartValue: viewModel.initialStartTime,
                          initialEndValue: viewModel.initialEndTime,
                          typeChanged: (value) {
                            viewModel.updateType(value!);
                          },
                          startTimeChanged: (value) {
                            viewModel.updateStartTime(value!);
                          },
                          endTimeChanged: (value) {
                            viewModel.updateEndTime(value!);
                          }),
                      TimeSlots(
                          type: viewModel.type,
                          startTime: viewModel.startTimes,
                          endTime: viewModel.endTimes,
                          initialTypeValue: viewModel.initialType,
                          initialStartValue: viewModel.initialStartTime,
                          initialEndValue: viewModel.initialEndTime,
                          typeChanged: (value) {
                            viewModel.updateType(value!);
                          },
                          startTimeChanged: (value) {
                            viewModel.updateStartTime(value!);
                          },
                          endTimeChanged: (value) {
                            viewModel.updateEndTime(value!);
                          }),
                    ]),
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
                          assetIds: viewModel.assetUidData,
                          group: viewModel.groups,
                          dissociatedIds: viewModel.dissociatedAssetId,
                          onAssetSelected: (
                            List<String> value,
                            AssetGroupSummaryResponse data,
                            List<String> associatedAssetId,
                          ) {
                            viewModel.assetUidData = value;
                            viewModel.groupSummaryResponseData = data;
                            viewModel.associatedAssetId = associatedAssetId;
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
                        SizedBox(
                          height: 5,
                        ),
                        viewModel.isHideSearchList
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(border: Border.all()),
                                child: ListView.builder(
                                    itemCount:
                                        viewModel.searchContactListName!.length,
                                    itemBuilder: (context, index) {
                                      User user = viewModel
                                          .searchContactListName![index];
                                      return SearchContactReusableWidget(
                                        user: user,
                                        voidCallback: () {
                                          Logger().i("button is tapped");
                                          viewModel
                                              .onItemContactSelected(index);
                                        },
                                      );
                                    }))
                            : SizedBox(),
                        SizedBox(
                          height: 8,
                        ),
                        viewModel.selectedContactItems!.isNotEmpty
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(border: Border.all()),
                                child: ListView.builder(
                                    itemCount:
                                        viewModel.selectedContactItems!.length,
                                    itemBuilder: (context, index) {
                                      final email = viewModel
                                          .selectedContactItems![index];
                                      return SelectedContactListItem(
                                        email: email,
                                        voidCallback: () {
                                          viewModel
                                              .onRemovedSelectedContact(index);
                                        },
                                      );
                                    }))
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InsiteButton(
                              width: MediaQuery.of(context).size.width * 0.20,
                              height: MediaQuery.of(context).size.height * 0.06,
                              title: "cancel".toUpperCase(),
                              fontSize: 12,
                              textColor: textcolor,
                              bgColor: tango,
                              onTap: () {
                                viewModel.cancel();
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InsiteButton(
                              width: MediaQuery.of(context).size.width * 0.20,
                              height: MediaQuery.of(context).size.height * 0.06,
                              title: "save".toUpperCase(),
                              fontSize: 12,
                              textColor: textcolor,
                              bgColor: tango,
                              onTap: () {
                                viewModel.saveAddNotificationData();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
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
      viewModelBuilder: () => AddNewNotificationsViewModel(),
    );
  }
}
