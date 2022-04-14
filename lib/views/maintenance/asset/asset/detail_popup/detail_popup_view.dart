import 'package:flutter/material.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/core/models/serviceItem.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_date_picker.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'detail_popup_view_model.dart';

class DetailPopupView extends StatefulWidget {
  final ServiceItem? serviceItem;
  final AssetCentricData? assetData;
  final SummaryData? summaryData;
  final AssetData? assetDataValue;
  final List<Services?>? services;

  const DetailPopupView(
      {Key? key,
      this.serviceItem,
      this.assetData,
      this.assetDataValue,
      this.summaryData,
      this.services});

  @override
  State<DetailPopupView> createState() => _DetailPopupViewState();
}

class _DetailPopupViewState extends State<DetailPopupView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late var viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    viewModel = DetailPopupViewModel(widget.serviceItem, widget.assetData,
        widget.assetDataValue, widget.services);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailPopupViewModel>.reactive(
      builder:
          (BuildContext context, DetailPopupViewModel viewModel, Widget? _) {
        return InsiteScaffold(
          viewModel: viewModel,
          onFilterApplied: () {},
          onRefineApplied: () {},
          body: viewModel.loading
              ? InsiteProgressBar()
              : Card(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 385,
                          height: 83,
                          margin: EdgeInsets.only(
                              left: 14.0, right: 15.0, top: 20.0),
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
                                                  content: widget.assetData!
                                                              .assetSerialNumber ==
                                                          null
                                                      ? widget.summaryData!
                                                          .assetSerialNumber
                                                      : widget.assetData!
                                                          .assetSerialNumber,
                                                ),
                                                padding: EdgeInsets.only(
                                                    right: 38.0),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15.0),
                                          Text(
                                            "${widget.assetData!.makeCode == null ? widget.summaryData!.makeCode.toString().toUpperCase() : widget.assetData!.makeCode.toString().toUpperCase()} ${widget.assetData!.model == null ? widget.summaryData!.model.toString().toUpperCase() : widget.assetData!.model.toString().toUpperCase()}",
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
                                        content: viewModel.hourMeter,
                                      ),
                                      InsiteTableRowItem(
                                          title: "Odometer :",
                                          content: viewModel.odoMeter)
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
                                          content: "${viewModel.dueAt} hrs"),
                                      InsiteTableRowItem(
                                        title: "Overdue By :",
                                        content: "${viewModel.overdueBy} hrs",
                                      ),
                                      InsiteTableRowItem(
                                        title: "Due Date :",
                                        content: Utils.getDateInFormatddMMyyyy(
                                            viewModel.dueDate),
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
                              value: viewModel.serviceName,
                              items: viewModel.serviceList,
                              onChanged: (
                                String? value,
                              ) {
                                viewModel.updateModelValue(
                                    value!, widget.services);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 30,
                            child: Divider(
                              height: 2.0,
                              thickness: 2.0,
                              color: thunder,
                            )),
                        Container(
                          height: 50,
                          child: TabBar(
                              // labelPadding: const EdgeInsets.only(
                              //     left: 20, right: 20),
                              controller: _tabController,
                              labelColor: Theme.of(context).buttonColor,
                              unselectedLabelColor: Colors.white,
                              isScrollable: true,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).backgroundColor,
                                  border: Border.all(color: Colors.white)),
                              tabs: [
                                Tab(text: "\t Checklist & Parts List \t"),
                                Tab(text: "\t Complete \t "),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: 540,
                            width: double.maxFinite,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                checkList(
                                  context,
                                  viewModel,
                                ),
                                complete(
                                  context,
                                  viewModel,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
      viewModelBuilder: () => DetailPopupViewModel(widget.serviceItem,
          widget.assetData, widget.assetDataValue, widget.services),
    );
  }

  Widget checkList(BuildContext context, viewModel) {
    return viewModel.checkLists == null
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: InsiteText(
                text:
                    " No checklist/parts list to display for the given interval"),
          )
        : Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Card(
              color: backgroundColor3,
              child: ListView.builder(
                  itemCount: viewModel.checkLists!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Checklists? checklistsItem = viewModel.checkLists![index];
                    return Container(
                      height: 320,
                      child: Column(
                        children: [
                          Expanded(
                            child: Card(
                              child: InsiteExpansionTile(
                                // childrenPadding: EdgeInsets.all(0),
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
                                              title: " ",
                                              content:
                                                  checklistsItem!.checklistName,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                onExpansionChanged: (value) {
                                  // viewModel.onExpanded();
                                },
                                initiallyExpanded: false,
                                tilePadding: EdgeInsets.all(0),
                                children: [
                                  viewModel.refreshing
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InsiteProgressBar(),
                                        )
                                      : SizedBox(),
                                  checklistsItem.parts!.isNotEmpty
                                      ? Table(
                                          columnWidths: {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(1),
                                            2: FlexColumnWidth(1),
                                          },
                                          border: TableBorder.all(),
                                          children: [
                                            TableRow(children: [
                                              InsiteTextWithPadding(
                                                padding: EdgeInsets.all(8),
                                                text: "Name",
                                                size: 12,
                                              ),
                                              InsiteTextWithPadding(
                                                padding: EdgeInsets.all(8),
                                                text: "Part No.",
                                                size: 12,
                                              ),
                                              InsiteTextWithPadding(
                                                padding: EdgeInsets.all(8),
                                                text: "#",
                                                size: 12,
                                              ),
                                            ]),
                                          ],
                                        )
                                      : InsiteText(
                                          text:
                                              " No checklist/parts list to display for the given interval"),
                                  checklistsItem.parts!.isNotEmpty
                                      ? Container(
                                          height: 200,
                                          child: Scrollbar(
                                            isAlwaysShown: true,
                                            child: SingleChildScrollView(
                                              controller:
                                                  viewModel.scrollController,
                                              child: Column(
                                                children: [
                                                  Table(
                                                    columnWidths: {
                                                      0: FlexColumnWidth(1),
                                                      1: FlexColumnWidth(2),
                                                      2: FlexColumnWidth(1),
                                                    },
                                                    border: TableBorder.all(),
                                                    children: List.generate(
                                                        checklistsItem.parts!
                                                            .length, (index) {
                                                      Parts? parts =
                                                          checklistsItem
                                                              .parts![index];
                                                      Logger().i(parts);
                                                      return TableRow(
                                                          children: [
                                                            InsiteTableRowItem(
                                                              title: " ",
                                                              content:
                                                                  parts.name,
                                                            ),
                                                            InsiteTableRowItem(
                                                              title: " ",
                                                              content:
                                                                  parts.partNo,
                                                            ),
                                                            InsiteTableRowItem(
                                                              title: " ",
                                                              content: parts
                                                                  .quantity
                                                                  .toString(),
                                                            ),
                                                          ]);
                                                    }),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  InsiteButton(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                    title: "Next".toUpperCase(),
                                                    fontSize: 12,
                                                    textColor: white,
                                                    onTap: () {
                                                      _tabController!.index = 1;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                  ),
                                                  viewModel.loadingMore
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child:
                                                              InsiteProgressBar(),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          );
  }

  Widget complete(BuildContext context, viewModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 520,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).textTheme.bodyText1!.color!,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomDatePicker(
                        controller: viewModel.hourMeterDateController,
                        voidCallback: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 1000)),
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
                        title: viewModel.performedBy,
                        onChanged: (value) {
                          viewModel.updatePerformedValue(value);
                        }),
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
                      title: viewModel.hourMeter,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    InsiteText(
                      text: 'Work Order :',
                      size: 13,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    CustomTextBox(
                      title: viewModel.workOrder,
                      onChanged: (value) {
                        viewModel.updateWorkOrder(value);
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
                      title: viewModel.serviceNotes,
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
                          onTap: () {},
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
                          onTap: () {
                            viewModel.onComplete();
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
      ),
    );
  }
}
