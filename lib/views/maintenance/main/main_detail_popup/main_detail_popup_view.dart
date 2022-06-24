import 'package:flutter/material.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/maintenance_checkList.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_date_picker.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/maintenance/main/main_detail_popup/main_detail_popup_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:stacked/stacked.dart';

class MainDetailPopupView extends StatefulWidget {
  final AssetData? assetDataValue;

  final BuildContext? parentContext;
  final int? serviceNo;

  const MainDetailPopupView({
    Key? key,
    this.serviceNo,
    this.assetDataValue,
    this.parentContext,
  });

  @override
  State<MainDetailPopupView> createState() => _MainDetailPopupViewState();
}

class _MainDetailPopupViewState extends State<MainDetailPopupView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late var viewModel;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _tabController = TabController(length: 2, vsync: this);
  //   viewModel = MainDetailPopupViewModel(widget.serviceItem,
  //       widget.assetDataValue, widget.services, widget.summaryData);
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainDetailPopupViewModel>.reactive(
      builder: (BuildContext context, MainDetailPopupViewModel viewModel,
          Widget? _) {
        return viewModel.loading
            ? InsiteProgressBar()
            : Card(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //  width: 385,
                        // height: 83,
                        margin:
                            EdgeInsets.only(left: 14.0, right: 15.0, top: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1.0,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!)
                          ],
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!),
                          shape: BoxShape.rectangle,
                        ),
                        child: Table(children: [
                          TableRow(children: [
                            Column(
                              children: [
                                Row(children: [
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //       left: 2.0, bottom: 15.0),
                                  //   child: SvgPicture.asset(
                                  //       "assets/images/arrowdown.svg"),
                                  // ),
                                  SizedBox(width: 10.0),
                                  Padding(
                                    padding: EdgeInsets.only(top: 13.0),
                                    child: Container(
                                      width: 58.7,
                                      height: 54,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                            width: 1, color: containercolor),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Image.asset(
                                          "assets/images/truck.png"),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              child: InsiteRichText(
                                                title: "",
                                                onTap: () {},
                                                content: viewModel
                                                    .mainPopViewData!.serialNo,
                                              ),
                                              padding:
                                                  EdgeInsets.only(right: 38.0),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15.0),
                                        Text(
                                          "${viewModel.mainPopViewData!.make.toString().toUpperCase()} ${viewModel.mainPopViewData!.prodfamily.toString().toUpperCase()}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w700,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize: 12.0),
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ]),
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InsiteExpansionTile(
                        title: Column(
                          children: [
                            Table(
                              border: TableBorder.all(),
                              columnWidths: {
                                0: FlexColumnWidth(1.8),
                                1: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    InsiteTableRowItem(
                                      title: "HourMeter :",
                                      content: double.parse(viewModel
                                              .mainPopViewData!.hourmeter!)
                                          .round(),
                                    ),
                                    // InsiteTableRowItem(
                                    //     title: "Odometer :",
                                    //     content: viewModel
                                    //         .mainPopViewData!.odometer)
                                  ],
                                ),
                              ],
                            ),
                            Table(
                              border: TableBorder.all(),
                              columnWidths: {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    InsiteTableRowItem(
                                        title: "Due At :",
                                        content:
                                            "${viewModel.mainPopViewData!.dueAt} hrs"),
                                    viewModel.serviceCheckList?.serviceStatus ==
                                            "Upcoming"
                                        ? InsiteTableRowItem(
                                            title: "Due In:",
                                            content:
                                                "${viewModel.serviceCheckList!.dueInOverdueBy} hrs",
                                          )
                                        : InsiteTableRowItem(
                                            title: "Overdue By :",
                                            content:
                                                "${viewModel.mainPopViewData!.overdueBy} hrs",
                                          ),
                                    InsiteTableRowItem(
                                      title: "Due Date :",
                                      content: Utils.getDateInFormatddMMyyyy(
                                          viewModel.mainPopViewData!.dueDate),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                            height: 50,
                            // decoration: BoxDecoration(
                            //     border: Border.all(
                            //       color: Theme.of(context)
                            //           .textTheme
                            //           .bodyText1!
                            //           .color!,
                            //     ),
                            //     borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton<MainPopViewDropDown>(
                              //focusNode: onFocus,
                              isExpanded: true,
                              items: viewModel.dropDown!.map((e) {
                                return DropdownMenuItem<MainPopViewDropDown>(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InsiteText(text: e.initialValue!),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                viewModel.updateModelValue(value);
                              },
                              value: viewModel.initialValue,
                            )
                            //  CustomDropDownWidget(
                            //   value: viewModel.serviceName,
                            //   items: viewModel.serviceList,
                            //   onChanged: (
                            //     String? value,
                            //   ) {
                            //     // viewModel.updateModelValue(
                            //     //     value!, widget.services);
                            //   },
                            // ),
                            ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        color: tango,
                        width: MediaQuery.of(context).size.width * 1,
                        child: TabBar(
                            controller: _tabController,
                            // labelPadding: const EdgeInsets.only(
                            //     left: 20, right: 20),
                            onTap: (i) {
                              viewModel.onTabChange(i);
                            },
                            labelColor: Theme.of(context).buttonColor,
                            unselectedLabelColor: Colors.white,
                            //isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                //borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context)
                                    .backgroundColor
                                    .withOpacity(0.9),
                                border: Border.all(color: Colors.white)),
                            tabs: [
                              Container(
                                child:
                                    Tab(text: "\t Checklist & Parts List \t"),
                              ),
                              Container(child: Tab(text: "\t Complete \t "))
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: viewModel.selectedIndex == 0
                              ? MediaQuery.of(context).size.height * 0.5
                              : MediaQuery.of(context).size.height * 0.8,
                          width: double.maxFinite,
                          child: TabBarView(
                             controller: _tabController,
                            children: [
                              checkList(
                                context,
                                viewModel,
                              ),
                              complete(
                                  context, viewModel, widget.parentContext!)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
      viewModelBuilder: () => MainDetailPopupViewModel(
          assetDataValue: widget.assetDataValue, serviceNo: widget.serviceNo),
    );
  }

  Widget checkList(BuildContext context, MainDetailPopupViewModel viewModel) {
    if (viewModel.isinitialCheckList) {
      return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: InsiteText(
            text: "No checklist/parts list to display for the given interval"),
      );
    } else {
      return viewModel.checkLists == null || viewModel.checkLists!.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: InsiteText(
                  text:
                      " No checklist/parts list to display for the given interval"),
            )
          : Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: Theme(
                          data: ThemeData()
                              .copyWith(dividerColor: Colors.transparent),
                          child: Column(
                            children: List.generate(
                                viewModel.checkLists!.length, (index) {
                              return ExpansionTile(
                                  title: InsiteText(
                                    text: viewModel
                                        .checkLists![index].checkListName,
                                  ),
                                  children: [
                                    Table(
                                      border:
                                          TableBorder.all(color: Colors.black),
                                      children: [
                                        TableRow(children: [
                                          InsiteTextWithPadding(
                                            padding: EdgeInsets.all(8),
                                            text: "Name",
                                            // size: 12,
                                          ),
                                          InsiteTextWithPadding(
                                            padding: EdgeInsets.all(8),
                                            text: "Part No.",
                                            // size: 12,
                                          ),
                                          InsiteTextWithPadding(
                                            padding: EdgeInsets.all(8),
                                            text: "Quantity",
                                            //  size: 12,
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Column(
                                      children: List.generate(
                                          viewModel.checkLists![index].partList!
                                              .length, (i) {
                                        var part = viewModel
                                            .checkLists![index].partList![i];
                                        return Table(
                                          border: TableBorder.all(
                                              color: Colors.black),
                                          children: [
                                            TableRow(children: [
                                              InsiteTextWithPadding(
                                                padding: EdgeInsets.all(8),
                                                text: part.name ?? "-",
                                                //  size: 12,
                                              ),
                                              InsiteTextWithPadding(
                                                padding: EdgeInsets.all(8),
                                                text: part.partNo
                                                    ?.replaceRange(4,
                                                        part.partNo!.length, "")
                                                    .trimRight(),
                                                //  size: 12,
                                              ),
                                              InsiteTextWithPadding(
                                                padding: EdgeInsets.all(8),
                                                text: part.quantity.toString(),
                                                //  size: 12,
                                              ),
                                            ])
                                          ],
                                        );
                                      }),
                                    )
                                  ]);
                            }),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // InsiteButton(
                        //   width: MediaQuery.of(context).size.width * 0.4,
                        //   height: MediaQuery.of(context).size.height * 0.06,
                        //   title: "Save".toUpperCase(),
                        //   fontSize: 12,
                        //   textColor: white,
                        //   onTap: () {
                        //     // viewModel.onComplete(
                        //     //     checklistsItem
                        //     //         .checklistId,
                        //     //     checklistsItem
                        //     //         .checklistName,
                        //     //     true);
                        //   },
                        // ),
                        InsiteButton(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.06,
                          title: "Next".toUpperCase(),
                          fontSize: 12,
                          textColor: white,
                          onTap: () {
                            
                            _tabController!.index = 1;
                             viewModel.onTabChange(1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
    }
  }

  Widget complete(BuildContext context, MainDetailPopupViewModel viewModel,
      BuildContext parentContext) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).textTheme.bodyText1!.color!,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              InsiteText(
                text: 'Service Date:',
                size: 13,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                //height: 35,
                width: double.infinity,

                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: CustomDatePicker(
                  controller: viewModel.hourMeterDateController,
                  voidCallback: () => showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 1000)),
                    lastDate: DateTime.now().subtract(
                      Duration(days: 0),
                    ),
                  ).then((value) {
                    viewModel.getSelectedDate(
                        Utils.getDateInFormatddMMyyyy(value.toString()));
                  }),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              InsiteText(
                text: 'Performed By :',
                size: 13,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              CustomTextBox(
                controller: viewModel.performedByController,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              InsiteText(
                text: 'Service Meter :',
                size: 13,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              CustomTextBox(
                // title: viewModel.hourMeter,
                controller: viewModel.serviceMeterController,

                onChanged: (value) {},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              InsiteText(
                text: 'Work Order (Optional):',
                size: 13,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              CustomTextBox(
                //    title: viewModel.workOrder,
                controller: viewModel.workOrderDateController,
                onChanged: (value) {
                  // viewModel.updateWorkOrder(value);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              InsiteText(
                text: 'Service Notes :',
                size: 13,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              CustomTextBox(
                controller: viewModel.serviceNoteController,
                onChanged: (value) {
                  viewModel.updateServiceNotes(value);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InsiteButton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.06,
                    title: "Reset".toUpperCase(),
                    fontSize: 12,
                    bgColor: Theme.of(context).backgroundColor,
                    onTap: () {
                      viewModel.onReset();
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InsiteButton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.06,
                    title: "Complete".toUpperCase(),
                    fontSize: 12,
                    textColor: white,
                    onTap: () async {
                      var data = await viewModel.onComplete();
                      if (data != null) {
                        Navigator.of(parentContext).pop();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              )
            ]),
          ),
        ),
      ],
    );
  }
}
