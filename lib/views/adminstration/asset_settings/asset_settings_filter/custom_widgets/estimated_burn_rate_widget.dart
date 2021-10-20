import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class EstimatedBurnRateWidget extends StatefulWidget {
  //const EstimatedBurnRateWidget({ Key? key }) : super(key: key);

  @override
  _EstimatedBurnRateWidgetState createState() =>
      _EstimatedBurnRateWidgetState();
}

class _EstimatedBurnRateWidgetState extends State<EstimatedBurnRateWidget> {
  TextEditingController _workingcontroller = TextEditingController();
  TextEditingController _idleController = TextEditingController();

  @override
  void initState() {
    _workingcontroller.text = "0";
    _idleController.text = "0";
    super.initState();
  }

  @override
  void dispose() {
    _workingcontroller.dispose();
    _idleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
              border:
                  Border.symmetric(horizontal: BorderSide(color: cardcolor))),
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
                        controller: _workingcontroller,
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
                                getIncrementWorkingValue();
                              },
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                                getDecrementWorkingValue();
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
                        controller: _idleController,
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
                                  getIncrementIdleValue();
                                }),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                                getDecrementIdleValue();
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
  }

  void getIncrementWorkingValue() {
    int currentValue = int.parse(_workingcontroller.text);

    currentValue++;
    _workingcontroller.text = (currentValue).toString();
    setState(() {});
  }

  getDecrementWorkingValue() {
    int currentValue = int.parse(_workingcontroller.text);
    currentValue--;
    _workingcontroller.text = (currentValue > 0 ? currentValue : 0).toString();
    setState(() {});
  }

  getIncrementIdleValue() {
    int currentValue = int.parse(_idleController.text);

    currentValue++;
    _idleController.text = (currentValue).toString();
    setState(() {});
  }

  getDecrementIdleValue() {
    int currentValue = int.parse(_idleController.text);
    currentValue--;
    _idleController.text = (currentValue > 0 ? currentValue : 0).toString();
    setState(() {});
  }
}
