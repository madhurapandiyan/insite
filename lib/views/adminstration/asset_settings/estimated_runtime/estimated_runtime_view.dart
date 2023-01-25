import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_date_picker.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/days_reusable_widget.dart';
import 'package:insite/views/adminstration/asset_settings/estimated_runtime/estimated_runtime_viewmodel.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class EstimatedRunTimeWidgetView extends StatefulWidget {
  final List<String>? assetUids;

  EstimatedRunTimeWidgetView({this.assetUids});

  @override
  _EstimatedRunTimeWidgetViewState createState() =>
      _EstimatedRunTimeWidgetViewState();
}

class _EstimatedRunTimeWidgetViewState
    extends State<EstimatedRunTimeWidgetView> {
  String dropDownValue = "Hours";
  DateTime? startDate;
  DateTime? endDate;
  late var viewModel;

  @override
  void initState() {
    viewModel = EstimatedRuntimeViewModel(
      widget.assetUids,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EstimatedRuntimeViewModel>.reactive(
      builder: (BuildContext context, EstimatedRuntimeViewModel viewModel,
          Widget? _) {
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                InsiteText(
                  text: "Start Time",
                  fontWeight: FontWeight.w700,
                  size: 14,
                  color: Theme.of(context).textTheme.bodyText1!.backgroundColor,
                ),
                SizedBox(
                  width: 120,
                ),
                InsiteText(
                  text: "End Time",
                  fontWeight: FontWeight.w700,
                  size: 14,
                  color: Theme.of(context).textTheme.bodyText1!.backgroundColor,
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
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!)),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CustomDatePicker(
                          controller: viewModel.startDateController,
                          voidCallback: () {
                            getStartDatePicker(viewModel);
                          },
                        )),
                  ),
                ),
                SizedBox(
                  width: 28,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: MediaQuery.of(context).size.height * 0.05,
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
                                Theme.of(context).textTheme.bodyText1!.color!)),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CustomDatePicker(
                          controller: viewModel.endDateController,
                          voidCallback: () async {
                            await getEndDatePicker(viewModel);
                            // viewModel.getDateFilter(startDate!, endDate!);
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
                  width: 20,
                ),
                GestureDetector(
                    onTap: () {
                      viewModel.onChangeStateRuntime();
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
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!)),
                      child: Container(
                        color: viewModel.isSelectedFullWeekTarget
                            ? Theme.of(context).buttonColor
                            : null,
                      ),
                    )),
                SizedBox(
                  width: 5,
                ),
                InsiteText(
                  text: "Target Runtime",
                  size: 14,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () {
                      viewModel.onChangeStateIdle();
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
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!)),
                      child: Container(
                        color: viewModel.isSelectedFullWeekIdle
                            ? Theme.of(context).buttonColor
                            : null,
                      ),
                    )),
                SizedBox(
                  width: 5,
                ),
                InsiteText(
                  text: "Target Idling",
                  size: 14,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
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
                                Theme.of(context).textTheme.bodyText1!.color!)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: CustomDropDownWidget(
                        items: ["Hours", "%"],
                        value: dropDownValue,
                        onChanged: (String? value) {
                          dropDownValue = value!;
                          viewModel.onChangeStateValue();
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
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
                  width: 10,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.25,
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
                                Theme.of(context).textTheme.bodyText1!.color!)),
                    child: viewModel.isSelectedFullWeekTarget
                        ? Stack(
                            children: [
                              TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                ),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color),
                                controller: viewModel.fulltargetTimeController,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: false,
                                  signed: true,
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                          viewModel.getIncrementRuntimeValue();
                                          viewModel.getRuntimeAllValueData();
                                        }),
                                    InkWell(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 18.0,
                                      ),
                                      onTap: () {
                                        viewModel.getDecrementRuntimeValue();
                                        viewModel.getRuntimeAllValueData();
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : SizedBox()),
                SizedBox(
                  width: 30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.25,
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
                                Theme.of(context).textTheme.bodyText1!.color!)),
                    child: viewModel.isSelectedFullWeekIdle
                        ? Stack(
                            children: [
                              TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                ),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color),
                                controller: viewModel.fullIdleTimeController,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: false,
                                  signed: true,
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                          viewModel.getIncrementIdleValue();
                                          viewModel.getIdleAllValue();
                                        }),
                                    InkWell(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 18.0,
                                      ),
                                      onTap: () {
                                        viewModel.getDecrementIdleValue();
                                        viewModel.getIdleAllValue();
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : SizedBox())
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                  itemCount: 7,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final days = viewModel.countValue[index];
                    return DaysReusableWidget(
                      isChangingState: viewModel.changedState,
                      countRuntimeValue: days.runTimecount,
                      days: days.runtimeDays,
                      value: dropDownValue,
                      percentCountValue: days.percentCount,
                      onRuntimeValueChanged: (String value) {
                        viewModel.getRuntimeListValueData(value, index);                        
                      },
                      onIdleValueChanged: (String value) {
                        viewModel.getIdleListValue(value, index);
                      },
                      onPercentCountValueChange: (String value) {
                        viewModel.getPercentCountValue(value, index);
                      },
                      countIdleValue: days.idleCount,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 32.0, bottom: 150),
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
                    bgColor: Theme.of(context).buttonColor,
                    onTap: () {
                      viewModel.onClickValueRunTimeApply();
                      viewModel.onIdleClickValueApply();
                      viewModel.getFullWeekTargetDataApply();
                      viewModel.getFullWeekIdleDataApply();
                      viewModel.getAssetSettingTargetData(
                          startDate, endDate, context);
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
          ],
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }

  getStartDatePicker(EstimatedRuntimeViewModel viewModel) async {
    DateTime pickedStartDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101))
        .then((value) => (startDate = value)!);

    if (pickedStartDate != null) {
      print(pickedStartDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedStartDate);
      print(formattedDate);
      viewModel.getStartDateData(formattedDate);
    } else {
      print("Date is not selected");
    }
  }

  getEndDatePicker(EstimatedRuntimeViewModel viewModel) async {
    DateTime pickedEndDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101))
        .then((value) => (endDate = value)!);

    if (pickedEndDate != null) {
      print(pickedEndDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedEndDate);
      viewModel.getEndDateData(formattedDate);
    } else {
      print("Date is not selected");
    }
  }
}
