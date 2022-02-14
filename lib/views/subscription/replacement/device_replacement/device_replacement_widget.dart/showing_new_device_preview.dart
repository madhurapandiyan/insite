import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class ShowingNewDeviceDetail extends StatelessWidget {
  final String? oldDeviceId;
  final String? newDeviceId;
  final String? machineSerialNo;
  final String? modelName;
  final String? startDate;
  final Function? onBackPressed;
  final Function? onReplacing;
  ShowingNewDeviceDetail(
      {this.oldDeviceId,
      this.machineSerialNo,
      this.newDeviceId,
      this.modelName,
      this.onBackPressed,
      this.onReplacing,
      this.startDate});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         InsiteText(
            fontWeight: FontWeight.w500,
            text: "Please check the updated details below and click on replace",
            size: 18,
          ),
          SizedBox(height: 20),
          InsiteText(
            fontWeight: FontWeight.w500,
            text: "Old Device ID :",
            size: 18,
          ),
          InsiteText(
            fontWeight: FontWeight.w500,
            text: oldDeviceId,
            size: 18,
          ),
          SizedBox(height: 20),
          InsiteText(
            fontWeight: FontWeight.w500,
            text: "New Device ID :",
            size: 18,
          ),
          InsiteText(
            fontWeight: FontWeight.w500,
            text: newDeviceId,
            size: 18,
          ),
          SizedBox(height: 20),
          InsiteText(
            fontWeight: FontWeight.w500,
            text: "Machine Serial No. (VIN)",
            size: 18,
          ),
          SizedBox(height: 5),
          InsiteText(
            fontWeight: FontWeight.w500,
            text: machineSerialNo,
            size: 18,
          ),
          SizedBox(height: 20),
          InsiteText(
            fontWeight: FontWeight.w500,
            text: "Model : ",
            size: 18,
          ),
          SizedBox(height: 5),
          InsiteText(
            fontWeight: FontWeight.w500,
            text: modelName,
            size: 18,
          ),
          SizedBox(height: 20),
          InsiteText(
            fontWeight: FontWeight.w500,
            text: "Subscription Start Date :",
            size: 18,
          ),
          SizedBox(height: 5),
          InsiteText(
            fontWeight: FontWeight.w500,
            text: startDate,
            size: 18,
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InsiteButton(
                textColor: Theme.of(context).textTheme.bodyText2!.color,
                onTap: () {
                  onBackPressed!();
                },
                bgColor: white,
                title: "Back",
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              InsiteButton(
                textColor: Theme.of(context).textTheme.bodyText1!.color,
                onTap: () {
                onReplacing!();
                },
                // bgColor: white,
                title: "Replace",
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ],
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
