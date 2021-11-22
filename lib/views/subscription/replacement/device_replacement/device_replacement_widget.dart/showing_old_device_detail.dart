import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class ShowingOldDeviceDetail extends StatelessWidget {
  final String deviceId;
  final String Vin;
  final String modelName;
  final String date;
  ShowingOldDeviceDetail({this.deviceId, this.modelName, this.Vin, this.date});
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsiteText(
          fontWeight: FontWeight.w500,
          text: "Device ID :",
          size: 18,
        ),
        SizedBox(height: 5),
        InsiteText(
          fontWeight: FontWeight.w500,
          text: deviceId,
          size: 18,
        ),
        SizedBox(height: 15),
        InsiteText(
          fontWeight: FontWeight.w500,
          text: "Machine Serial No. (VIN)",
          size: 18,
        ),
        SizedBox(height: 5),
        InsiteText(
          fontWeight: FontWeight.w500,
          text: Vin,
          size: 18,
        ),
        SizedBox(height: 15),
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
        SizedBox(height: 15),
        InsiteText(
          fontWeight: FontWeight.w500,
          text: "Subscription Start Date :",
          size: 18,
        ),
        SizedBox(height: 5),
        InsiteText(
          fontWeight: FontWeight.w500,
          text: date,
          size: 18,
        ),
        SizedBox(height: 25),
      ],
    );
  }
}
