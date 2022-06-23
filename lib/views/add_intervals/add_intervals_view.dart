import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/maintenance_checkList.dart' as check;
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:stacked/stacked.dart';
import 'add_intervals_view_model.dart';

class AddIntervalsView extends StatelessWidget {
  final AssetDetail? assetId;
  AddIntervalsView({this.assetId});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddIntervalsViewModel>.reactive(
      builder:
          (BuildContext context, AddIntervalsViewModel viewModel, Widget? _) {
        return PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: viewModel.pageController,
          children: [
            ManageIntervals(
              viewModel: viewModel,
            ),
            AddIntervalsChecklist(
              viewModel: viewModel,
            )
          ],
        );
      },
      viewModelBuilder: () => AddIntervalsViewModel(assetDetail: assetId),
    );
  }
}

Widget onSelectedIntervalsDetails(
    {check.IntervalList? data,
    Function? onEditIntervals,
    BuildContext? context,
    Function? onDelete}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsiteText(
            text: "Interval Name", size: 16, fontWeight: FontWeight.bold),
        InsiteText(text: data!.intervalName, size: 16),
        SizedBox(
          height: 10,
        ),
        InsiteText(text: "Frequency", size: 16, fontWeight: FontWeight.bold),
        InsiteText(text: data.firstOccurrences.toString(), size: 16),
        SizedBox(
          height: 10,
        ),
        InsiteText(text: "Description", size: 16, fontWeight: FontWeight.bold),
        InsiteText(text: data.intervalDescription, size: 16),
        SizedBox(
          height: 10,
        ),
        InsiteText(
            text: "CHECK LIST AND PART LIST",
            size: 16,
            fontWeight: FontWeight.bold),
        SizedBox(
          height: 10,
        ),
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: Expanded(
            child: ListView.builder(
              itemCount: data.checkList!.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                    title: InsiteText(
                      text: data.checkList![index].checkListName,
                    ),
                    children: [
                      Table(
                        border: TableBorder.all(color: Colors.black),
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
                            data.checkList![index].partList!.length, (i) {
                          var part = data.checkList![index].partList![i];
                          return Table(
                            border: TableBorder.all(color: Colors.black),
                            children: [
                              TableRow(children: [
                                InsiteTextWithPadding(
                                  padding: EdgeInsets.all(8),
                                  text: part.partName ?? "",
                                  //  size: 12,
                                ),
                                InsiteTextWithPadding(
                                  padding: EdgeInsets.all(8),
                                  text: part.partNo,
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
              },
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: InsiteButton(
              height: 40,
              onTap: () {
                alertBox(context, onDelete!);
              },
              width: 100,
              textColor: backgroundColor1,
              title: "Delete",
            ),
          ),
          SizedBox(
            width: 10,
          ),
          data.editable == true
              ? Expanded(
                  child: InsiteButton(
                    height: 40,
                    onTap: () {
                      onEditIntervals!();
                    },
                    textColor: backgroundColor1,
                    title: "Edit Intervals",
                  ),
                )
              : SizedBox(),
        ])
      ],
    ),
  );
}

alertBox(BuildContext? context, Function onDelete) {
  showDialog(
      context: context!,
      builder: (ctx) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: AlertDialog(
            title: InsiteText(
              text: "Delete Confirmation",
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyText1!.color,
              size: 18,
            ),
            content: InsiteText(
              text:
                  "Deleting this interval will also delete the associated checklist and parts list.\nAre you sure you want to proceed ?",
              size: 14,
            ),
            actions: [
              Center(
                child: Row(
                  children: [
                    InsiteButton(
                      textColor: white,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      title: "Cancel",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InsiteButton(
                      textColor: white,
                      onTap: () async {
                        await onDelete();
                        Navigator.of(context).pop();
                      },
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      title: "Delete",
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
}

class ManageIntervals extends StatelessWidget {
  final AddIntervalsViewModel? viewModel;
  ManageIntervals({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Card(
              child: viewModel!.isLoading
                  ? Center(
                      child: InsiteProgressBar(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InsiteText(
                                  text: "Intervals",
                                  size: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                InsiteButton(
                                  height: 40,
                                  width: 100,
                                  onTap: () {
                                    viewModel!.onSelectall();
                                  },
                                  textColor: Theme.of(context).backgroundColor,
                                  title: "Select All",
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SearchBox(
                            hint: "Search",
                            controller: viewModel!.controller,
                            onTextChanged: (value) {
                              viewModel!.onSearching();
                            },
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    viewModel!.switchState.length, (index) {
                                  var data = viewModel!.switchState[index];
                                  return ListTile(
                                    onTap: () {
                                      viewModel!.onSwitchTaped(index);
                                    },
                                    leading: Icon(
                                        Icons.check_box_outline_blank_rounded,
                                        color: data.state!
                                            ? Theme.of(context).buttonColor
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color),
                                    title: InsiteText(
                                      text: data.text!,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          InsiteButton(
                            height: 40,
                            onTap: () {
                              viewModel!.onAddingIntervals();
                            },
                            width: double.infinity,
                            textColor: Theme.of(context).backgroundColor,
                            title: "Add Intervals",
                          )
                        ],
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          viewModel!.switchState.any((element) => element.state == true)
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Card(
                    child: onSelectedIntervalsDetails(
                        data: viewModel!.selectedIntervals,
                        onEditIntervals: viewModel!.onEditIntervalsinManage,
                        context: context,
                        onDelete: () {
                          viewModel!.onDeletingIntervals();
                        }),
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}

class AddIntervalsChecklist extends StatefulWidget {
  final AddIntervalsViewModel? viewModel;
  AddIntervalsChecklist({this.viewModel});

  @override
  State<AddIntervalsChecklist> createState() => _AddIntervalsChecklistState();
}

class _AddIntervalsChecklistState extends State<AddIntervalsChecklist> {
  double height = 0.3;
  Widget checkListAndPartList(
      {BuildContext? ctx,
      Function(int?)? onPartListDeleted,
      Function? onPartListAdded,
      CheckAndPartList? checkListData}) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                //width: MediaQuery.of(ctx!).size.width * 0.5,
                child: CustomTextBox(
              controller: checkListData!.checkListName,
              title: "Enter Checklist Name",
            )),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                checkListData.partListData!.isEmpty
                    ? SizedBox()
                    : Column(
                        children: List.generate(
                            checkListData.partListData!.length, (j) {
                          return partListWidget(
                              partListData: checkListData.partListData![j],
                              ctx: ctx,
                              onPartListDeleted: () {
                                onPartListDeleted!(j);
                              });
                        }),
                      ),
                InsiteButton(
                  title: "Add Parts",
                  onTap: () {
                    onPartListAdded!();
                  },
                  height: 40,
                  textColor: Theme.of(ctx!).backgroundColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget partListWidget(
      {BuildContext? ctx,
      Function? onPartListDeleted,
      Function? onPartListAdded,
      PartListData? partListData}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsiteText(
          text: "Part Name",
          size: 14,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            width: MediaQuery.of(ctx!).size.width * 0.5,
            child: CustomTextBox(
              controller: partListData!.partName,
            )),
        SizedBox(
          height: 15,
        ),
        InsiteText(
          text: "Part",
          size: 14,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            width: MediaQuery.of(ctx).size.width * 0.5,
            child: CustomTextBox(
              controller: partListData.part,
            )),
        SizedBox(
          height: 15,
        ),
        InsiteText(
          text: "Quantity",
          size: 14,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            width: MediaQuery.of(ctx).size.width * 0.5,
            child: CustomTextBox(
              keyPadType: TextInputType.number,
              controller: partListData.quantity,
            )),
        SizedBox(
          height: 15,
        ),
        InsiteButton(
          height: 40,
          onTap: () {
            onPartListDeleted!();
          },
          width: MediaQuery.of(ctx).size.width * 0.35,
          textColor: Theme.of(ctx).backgroundColor,
          title: "Delete",
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
                onPressed: () {
                  widget.viewModel!.onClickingBackInAddInterval();
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Theme.of(context).buttonColor,
                ),
                label: InsiteText(
                  text: "Back",
                )),

            InsiteText(
              text: "Add Interval",
              size: 18,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 15,
            ),
            InsiteText(
              text: "Basic Info :",
              size: 18,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 10,
            ),
            InsiteText(
              text: "Name:",
              size: 14,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextBox(
              title: "",
              controller: widget.viewModel!.namecontroller,
            ),
            SizedBox(
              height: 10,
            ),
            InsiteText(
              text: "Frequency:",
              size: 14,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                CustomTextBox(
                  title: "",
                  controller: widget.viewModel!.frequencyController,
                  keyPadType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Icon(
                            Icons.arrow_drop_up,
                            size: 18.0,
                          ),
                          onLongPress: () {
                            widget.viewModel!.getIncrementFrequencyValue();
                          },
                          onTap: () {
                            widget.viewModel!.getIncrementFrequencyValue();
                          }),
                      InkWell(
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 18.0,
                        ),
                        onLongPress: () {
                          widget.viewModel!.getDecrementFrequencyValue();
                        },
                        onTap: () {
                          widget.viewModel!.getDecrementFrequencyValue();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InsiteText(
              text: "Description:(Optional)",
              size: 14,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextBox(
              title: "",
              controller: widget.viewModel!.descriptionController,
            ),
            SizedBox(
              height: 20,
            ),
            InsiteText(
              text: "CHECKLIST AND PARTS LISTS:",
              size: 18,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 10,
            ),
            // ListTile(
            //   title: InsiteText(text: "mappiy"),
            // )
            widget.viewModel!.checkListData.isEmpty
                ? SizedBox()
                : Column(
                    children: List.generate(
                        widget.viewModel!.checkListData.length, (i) {
                      var data = widget.viewModel!.checkListData[i];
                      return Column(
                        children: [
                          ListTile(
                            title: InsiteText(
                                text: data.checkListName!.text.isEmpty
                                    ? "New CheckList"
                                    : data.checkListName!.text,
                                fontWeight: FontWeight.bold),
                            onTap: () {
                              widget.viewModel!.onTileExpanded(i);
                            },
                            trailing: IconButton(
                                onPressed: () {
                                  widget.viewModel!.onCheckListDelete(i);
                                },
                                icon: Icon(Icons.delete)),
                          ),
                          data.expansionState!
                              ? checkListAndPartList(
                                  onPartListAdded: () {
                                    widget.viewModel!.onPartListAdded(i);
                                  },
                                  onPartListDeleted: (partListIndex) {
                                    widget.viewModel!
                                        .onPartListDeleted(i, partListIndex!);
                                  },
                                  ctx: context,
                                  checkListData: data)
                              : SizedBox(),
                        ],
                      );
                    }),
                  ),
            SizedBox(
              height: 10,
            ),
            InsiteButton(
              title: "Add CheckList",
              height: 40,
              width: double.infinity,
              onTap: () {
                widget.viewModel!.onCheckListAdded();
              },
              textColor: Theme.of(context).backgroundColor,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InsiteButton(
                  onTap: () {
                    // viewModel.onCancelButtonClicked();
                  },
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.4,
                  bgColor: Theme.of(context).backgroundColor,
                  title: "Cancel",
                  fontSize: 16,
                ),
                InsiteButton(
                  textColor: white,
                  onTap: () {
                    widget.viewModel!.onIntervalSaved();
                  },
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.4,
                  title: "Save",
                  fontSize: 16,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
