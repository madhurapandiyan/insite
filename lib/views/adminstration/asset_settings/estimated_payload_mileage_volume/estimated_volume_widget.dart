import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class EstimatedVolumeWidget extends StatefulWidget {
  //const EstimatedVolumeWidget({ Key? key }) : super(key: key);

  @override
  _EstimatedVolumeWidgetState createState() => _EstimatedVolumeWidgetState();
}

class _EstimatedVolumeWidgetState extends State<EstimatedVolumeWidget> {
 TextEditingController cubeController = TextEditingController();

  @override
  void initState() {
   cubeController.text="0";
    super.initState();
  }
  @override
  void dispose() {
   cubeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left:18.0),
          child: InsiteText(
            text: "Estimated Volume per cycle ",
            size: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left:16.0),
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
                        controller: cubeController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: false,
                          signed: true,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          // ignore: deprecated_member_use
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
                                getIncrementVolumeValue();
                              },
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                               getDecrementVolumeValue();
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
                text: "cu.m",
                fontWeight: FontWeight.w700,
                size: 14,
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
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
   getIncrementVolumeValue() {
    int currentValue = int.parse(cubeController.text);

    currentValue++;
    cubeController.text = (currentValue).toString();
    setState(() {});
  }

  getDecrementVolumeValue() {
    int currentValue = int.parse(cubeController.text);
    currentValue--;
    cubeController.text = (currentValue > 0 ? currentValue : 0).toString();
    setState(() {});
  }
}