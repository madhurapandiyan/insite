import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/asset_settings/estimated_burn_rate/estimated_burn_rate_viewmodel.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:stacked/stacked.dart';

class EstimatedBurnRateWidget extends StatefulWidget {
  final List<String> assetUids;
  EstimatedBurnRateWidget({this.assetUids});

  @override
  _EstimatedBurnRateWidgetState createState() =>
      _EstimatedBurnRateWidgetState();
}

class _EstimatedBurnRateWidgetState extends State<EstimatedBurnRateWidget> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EstimatedBurnRateViewModel>.reactive(
      builder: (BuildContext context, EstimatedBurnRateViewModel viewModel,
          Widget _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(color: cardcolor))),
              child: Row(
                children: [
                  VerticalDivider(
                    color: tango,
                    thickness: 7,
                    width: 8,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InsiteText(
                    text: "Only affects assets with work definitions set to" +
                        "\n" +
                        "movement/sensor readings:",
                    fontWeight: FontWeight.w700,
                    size: 14,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: InsiteText(
                text: "Working Burn Rate",
                size: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          border: Border.all(color: cardcolor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
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
                                    .bodyText1
                                    .color),
                            controller: viewModel.workingcontroller,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                              signed: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
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
                                    viewModel.getIncrementWorkingValue();
                                  },
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 18.0,
                                  ),
                                  onTap: () {
                                    viewModel.getDecrementWorkingValue();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  InsiteText(
                    text: "I/hr",
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: InsiteText(
                text: "Idle Burn Rate",
                size: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          border: Border.all(color: cardcolor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                            controller: viewModel.idleController,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .color),
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                              signed: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
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
                                    }),
                                InkWell(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 18.0,
                                  ),
                                  onTap: () {
                                    viewModel.getDecrementIdleValue();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  InsiteText(
                    text: "I/hr",
                    fontWeight: FontWeight.w700,
                    size: 14,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 32.0),
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
                      viewModel.getAssetSettingFuelBurnRateData(context);
                    },
                  ),
                  SizedBox(
                    width: 30,
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
      viewModelBuilder: () => EstimatedBurnRateViewModel(widget.assetUids),
    );
  }
}
