import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/manage_report_response.dart';
import 'package:insite/core/models/search_contact_report_list_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/address_custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_date_picker.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/add_group/selection_widget/selection_widget_view.dart';
import 'package:insite/views/adminstration/add_report/fault_code_model.dart';
import 'package:insite/views/adminstration/add_report/reusable_widget/add_report_custom_dropdown_widget.dart';
import 'package:insite/views/adminstration/add_report/reusable_widget/fault_code_reusable_widget.dart';
import 'package:insite/views/adminstration/add_report/reusable_widget/search_contact_reusable_widget.dart';
import 'package:insite/views/adminstration/add_report/reusable_widget/selected_contact_list_item.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'add_report_view_model.dart';

class AddReportView extends StatefulWidget {
  final ScheduledReports? scheduledReports;
  final bool? isEdit;
  AddReportView({this.scheduledReports, this.isEdit});
  @override
  State<AddReportView> createState() => _AddReportViewState();
}

class _AddReportViewState extends State<AddReportView> {
  DateTime? datePickerValue;
  // String? dropDownValue;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddReportViewModel>.reactive(
      builder: (BuildContext context, AddReportViewModel viewModel, Widget? _) {
        return InsiteScaffold(
            viewModel: viewModel,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    InsiteText(
                      text: "Schedule Email CSV Report",
                      size: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InsiteText(
                      text: "Schedule Report Type",
                      size: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AddReportCustomDropdownWidget(
                      reportFleetAssets: viewModel.reportFleetAssets,
                      reportServiceAssets: viewModel.reportServiceAssets,
                      reportProductivityAssets:
                          viewModel.reportProductivityAssets,
                      reportStandartAssets: viewModel.reportStandartAssets,
                      dropDownValue: (String value) {
                        viewModel.dropDownValue = value;
                        setState(() {});
                        Logger().w(viewModel.dropDownValue);
                      },
                      isShowingDropDownState:
                          widget.scheduledReports == null ? true : false,
                      value: viewModel.dropDownValue,
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    viewModel.dropDownValue == "Fault Code"
                        ? InsiteText(
                            text: "Severity :",
                            fontWeight: FontWeight.w700,
                            size: 14)
                        : SizedBox(),

                    SizedBox(
                      height: 8,
                    ),

                    viewModel.dropDownValue == "Fault Code"
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: viewModel.severityListData!.length,
                            itemBuilder: (context, index) {
                              FaultCodeModel faultCodeModel =
                                  viewModel.severityListData![index];
                              return FaultCodeReusableWidget(
                                faultCodeModel: faultCodeModel,
                                voidCallback: () {
                                  viewModel.onItemSelect(index);
                                },
                              );
                            },
                          )
                        : SizedBox(),

                    SizedBox(
                      height: 2,
                    ),
                    viewModel.dropDownValue == "Fault Code"
                        ? InsiteText(
                            text: "Fault Code Type :",
                            fontWeight: FontWeight.w700,
                            size: 14)
                        : SizedBox(),
                    SizedBox(
                      height: 4,
                    ),

                    viewModel.dropDownValue == "Fault Code"
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: viewModel.faultCodeTypeListData!.length,
                            itemBuilder: (context, index) {
                              FaultCodeModel faultCodeModel =
                                  viewModel.faultCodeTypeListData![index];
                              return FaultCodeReusableWidget(
                                faultCodeModel: faultCodeModel,
                                voidCallback: () {
                                  viewModel.onItemSelect(index);
                                },
                              );
                            },
                          )
                        : SizedBox(),

                    SizedBox(
                      height: 10,
                    ),

                    InsiteText(
                      text: "Report Format",
                      size: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1, color: black),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: widget.scheduledReports == null
                              ? CustomDropDownWidget(
                                  items: [".CSV", ".XLS", ".PDF"],
                                  value: viewModel.reportFormatDropDownValue,
                                  onChanged: (String? value) {
                                    viewModel.reportFormatDropDownValue =
                                        value!;
                                    setState(() {});
                                  },
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: InsiteText(
                                        text: viewModel.reportFormat == 1
                                            ? "CSV"
                                            : viewModel.reportFormat == 2
                                                ? "XLSX"
                                                : viewModel.reportFormat == 3
                                                    ? "PDF"
                                                    : "-",
                                        size: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InsiteText(
                      text: "Report Name",
                      size: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextBox(
                      title: "Enter the Name",
                      controller: viewModel.nameController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InsiteText(
                      text: "Frequency",
                      size: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1, color: black),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomDropDownWidget(
                          items: ["Daily", "Weekly", "Monthly"],
                          value: viewModel.frequencyDropDownValue,
                          onChanged: (String? value) {
                            viewModel.frequencyDropDownValue = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    viewModel.dropDownValue == "Cost Analysis - Fleet" ||
                            viewModel.dropDownValue ==
                                "Cost Analysis - Single Asset"
                        ? InsiteText(
                            text: "Cost per Hour :",
                            size: 14,
                            fontWeight: FontWeight.w700,
                          )
                        : Container(),
                    SizedBox(
                      height: 8,
                    ),
                    viewModel.dropDownValue == "Cost Analysis - Fleet" ||
                            viewModel.dropDownValue ==
                                "Cost Analysis - Single Asset"
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(width: 1, color: black),
                              shape: BoxShape.rectangle,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: InsiteText(
                                      text: "100",
                                      size: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 40,
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InsiteText(
                                      text: "USD",
                                      size: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    viewModel.dropDownValue == "Cost Analysis - Fleet" ||
                            viewModel.dropDownValue ==
                                "Cost Analysis - Single Asset"
                        ? InsiteText(
                            text: "Idling Time Threshold:",
                            size: 14,
                            fontWeight: FontWeight.w700,
                          )
                        : Container(),
                    viewModel.dropDownValue == "Cost Analysis - Fleet" ||
                            viewModel.dropDownValue ==
                                "Cost Analysis - Single Asset"
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(width: 1, color: black),
                              shape: BoxShape.rectangle,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: InsiteText(
                                      text: "10",
                                      size: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 40,
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InsiteText(
                                      text: "Minutes",
                                      size: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: InsiteText(
                            text: "Delivery End Date :",
                            size: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InsiteText(
                            text: "(Optional)",
                            size: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          border: Border.all(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!)),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 3),
                          child: CustomDatePicker(
                            controller: viewModel.dateTimeController,
                            voidCallback: () {
                              getDatePicker(viewModel);
                            },
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InsiteText(
                      text: "Choose by",
                      size: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1, color: black),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomDropDownWidget(
                          items: ["Assets", "Groups", "Geofences"],
                          value: viewModel.chooseByDropDownValue,
                          onChanged: (String? value) {
                            viewModel.chooseByDropDownValue = value!;

                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    viewModel.chooseByDropDownValue == "Assets"
                        ? SelectionWidgetView(
                            isEdit: false,
                            assetIds: [],
                            group: null,
                            dissociatedIds: [],
                            onAssetSelected: (
                              List<String> value,
                              AssetGroupSummaryResponse data,
                              List<String> associatedAssetId,
                            ) {
                              viewModel.associatedIdentifier =
                                  associatedAssetId;
                            },
                          )
                        : Container(),
                    SizedBox(
                      height: 30,
                    ),
                    InsiteText(
                      text: "Email Report Recipients :",
                      size: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextBox(
                        title: "Search Contact",
                        controller: viewModel.searchContactController,
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
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(border: Border.all()),
                            child: ListView.builder(
                                itemCount:
                                    viewModel.searchContactListName!.length,
                                itemBuilder: (context, index) {
                                  User user =
                                      viewModel.searchContactListName![index];
                                  return SearchContactReusableWidget(
                                    user: user,
                                    voidCallback: () {
                                      Logger().i("button is tapped");
                                      viewModel.onItemContactSelected(index);
                                    },
                                  );
                                }))
                        : SizedBox(),

                    SizedBox(
                      height: 8,
                    ),
                    viewModel.selectedContactItems!.isNotEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(border: Border.all()),
                            child: ListView.builder(
                                itemCount:
                                    viewModel.selectedContactItems!.length,
                                itemBuilder: (context, index) {
                                  final email =
                                      viewModel.selectedContactItems![index];
                                  return SelectedContactListItem(
                                    email: email,
                                    voidCallback: () {
                                      viewModel.onRemovedSelectedContact(index);
                                    },
                                  );
                                }))
                        : SizedBox(),

                    // Autocomplete<String>(
                    //   fieldViewBuilder:
                    //       (context, controller, focusnode, onEditing) {
                    //     return TextFormField(
                    //       onChanged: (String? value) {
                    //         viewModel.getContactSearchReportData(value!);

                    //       },
                    //     );
                    //   },
                    //   optionsBuilder: (TextEditingValue textEditingValue) {
                    //     if (textEditingValue.text == "") {
                    //       return const Iterable<String>.empty();
                    //     } else {

                    //       return viewModel.searchContactListName!
                    //           .where((String option) {
                    //             Logger().w(option.contains(textEditingValue.text));
                    //         return option.contains(textEditingValue.text);
                    //       });
                    //     }
                    //   },
                    //   onSelected: (String selection) {
                    //     Logger().i('You just selected $selection');
                    //   },
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    InsiteText(
                      text: "Email Subject Line ",
                      size: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextBox(
                      title: "Service Due",
                      controller: viewModel.serviceDueController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InsiteText(
                      text: "Email Content",
                      size: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AddressCustomTextBox(
                      title: "Enter here",
                      controller: viewModel.emailContentController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: InsiteButton(
                            bgColor: chipBackgroundOne,
                            height: MediaQuery.of(context).size.height * 0.06,
                            title: "Cancel",
                            fontSize: 14,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          flex: 2,
                          child: InsiteButton(
                            height: MediaQuery.of(context).size.height * 0.06,
                            title: "Save",
                            fontSize: 14,
                            onTap: () {
                              if (widget.scheduledReports == null) {
                                viewModel.addReportSaveData();
                              } else {
                                viewModel.getEditReportSaveData();
                              }
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
      viewModelBuilder: () =>
          AddReportViewModel(widget.scheduledReports, widget.isEdit!),
    );
  }

  getDatePicker(AddReportViewModel viewModel) async {
    DateTime pickedStartDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101))
        .then((value) => (datePickerValue = value)!);

    if (pickedStartDate != null) {
      print(pickedStartDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedStartDate);

      print(formattedDate);
      viewModel.getDatPickerData(formattedDate);
    } else {
      print("Date is not selected");
    }
  }
}
