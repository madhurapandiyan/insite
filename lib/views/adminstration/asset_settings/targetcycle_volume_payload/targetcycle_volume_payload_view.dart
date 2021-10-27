import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_date_picker.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/target_reusable_widget.dart';
import 'package:insite/views/adminstration/asset_settings/targetcycle_volume_payload/target_volume_payload_viewmodel.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class TargetCycleVolumePayloadWidget extends StatefulWidget {
  //const TargetCycleVolumePayloadWidget({ Key? key }) : super(key: key);

  @override
  _TargetCycleVolumePayloadWidgetState createState() =>
      _TargetCycleVolumePayloadWidgetState();
}

class _TargetCycleVolumePayloadWidgetState
    extends State<TargetCycleVolumePayloadWidget> {
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();

  @override
  void initState() {
    startDateInput.text = "";
    endDateInput.text = "";

    super.initState();
  }

  @override
  void dispose() {
    startDateInput.dispose();
    endDateInput.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TargetCycleVolumePayloadViewModel>.reactive(
      builder: (BuildContext context,
          TargetCycleVolumePayloadViewModel viewModel, Widget _) {
        return Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                InsiteText(
                  text: "Start Time",
                  fontWeight: FontWeight.w700,
                  size: 14,
                  color: Theme.of(context).textTheme.bodyText1.backgroundColor,
                ),
                SizedBox(
                  width: 120,
                ),
                InsiteText(
                  text: "End Time",
                  fontWeight: FontWeight.w700,
                  size: 14,
                  color: Theme.of(context).textTheme.bodyText1.backgroundColor,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(
                            color:
                                Theme.of(context).textTheme.bodyText1.color)),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 3),
                        child: CustomDatePicker(
                          controller: startDateInput,
                          voidCallback: () {
                            getStartDatePicker();
                          },
                        )),
                  ),
                ),
                SizedBox(
                  width: 28,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(
                            color:
                                Theme.of(context).textTheme.bodyText1.color)),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 3),
                        child: CustomDatePicker(
                          controller: endDateInput,
                          voidCallback: () {
                            getEndDatePicker();
                          },
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.getChangeCycleState();
                  },
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        border: Border.all(
                            color:
                                Theme.of(context).textTheme.bodyText1.color)),
                    child: Container(
                      color: viewModel.isChangeCycleState ? tango : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InsiteText(
                  text: "Target" + "\n" + " Cycles",
                  size: 14,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.getChangeVolumeState();
                  },
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        border: Border.all(
                            color:
                                Theme.of(context).textTheme.bodyText1.color)),
                    child: Container(
                      color: viewModel.isChangeVolumeState ? tango : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InsiteText(
                  text: "Target" + "\n" "Volumes" + "\n" + "(cu.m)",
                  size: 14,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  width: 18,
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.getChangePayloadState();
                  },
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        border: Border.all(
                            color:
                                Theme.of(context).textTheme.bodyText1.color)),
                    child: Container(
                      color: viewModel.isChangePayLoadSate ? tango : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InsiteText(
                  text: "Target" + "\n" + " Payload" + "\n" + " (tonne)",
                  size: 14,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                InsiteText(
                  text: "Full" + "\n" + "Week",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ),
                SizedBox(
                  width: 18,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1.color)),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: textcolor),
                          controller: viewModel.cycleController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  size: 18.0,
                                ),
                                onTap: () {
                                  viewModel.getIncrementCycleValue();
                                }),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                                viewModel.getDecrementCycleValue();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 18,
                ),
                Flexible(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          border: Border.all(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color)),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.0),
                              ),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: textcolor),
                              controller: viewModel.volumeController,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: false,
                                signed: true,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 18.0,
                                    ),
                                    onTap: () {
                                      viewModel.getIncrementVolumeValue();
                                    }),
                                InkWell(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 18.0,
                                  ),
                                  onTap: () {
                                    viewModel.getDecrementVolumeValue();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  width: 18,
                ),
                Flexible(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          border: Border.all(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color)),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.0),
                              ),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: textcolor),
                              controller: viewModel.payLoadController,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: false,
                                signed: true,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 18.0,
                                    ),
                                    onTap: () {
                                      viewModel.getIncrementPayLoadValue();
                                    }),
                                InkWell(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 18.0,
                                  ),
                                  onTap: () {
                                    viewModel.getDecrementPayLoadValue();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (_, index) {
                    final targetCycleVolumePayload =
                        viewModel.countValue[index];
                    return TargetReusableWidget(
                      onValueCycleChange: (String value) {
                        viewModel.getSingleItemData(value, index);
                      },
                      onValueVolumeChange: (String value) {},
                      onValuePayLoadChange: (String value) {},
                      days: targetCycleVolumePayload.runTimeDays,
                      fullWeekCountCycleValue:
                          targetCycleVolumePayload.targetCyclesCount,
                    );
                  }),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    InsiteButton(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.04,
                      title: "apply".toUpperCase(),
                      fontSize: 12,
                      textColor: textcolor,
                      bgColor: tango,
                      onTap: () {
                        viewModel.onClickCycleApply();
                        viewModel.getFullWeekTCycleDataApply();
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InsiteButton(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.04,
                      title: "cancel".toUpperCase(),
                      fontSize: 12,
                      textColor: textcolor,
                      bgColor: tuna,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        );
      },
      viewModelBuilder: () => TargetCycleVolumePayloadViewModel(),
    );
  }

  getStartDatePicker() async {
    DateTime pickedStartdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedStartdate != null) {
      print(pickedStartdate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedStartdate);
      print(formattedDate);
      setState(() {
        startDateInput.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  getEndDatePicker() async {
    DateTime pickedEndDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedEndDate != null) {
      print(pickedEndDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedEndDate);
      print(formattedDate);
      setState(() {
        endDateInput.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}
