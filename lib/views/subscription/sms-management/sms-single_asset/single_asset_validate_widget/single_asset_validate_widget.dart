import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_card_sms_asset_widget.dart';

class SingleAssetValidateWidget extends StatelessWidget {
  final String StartDate;
  final String GPSDeviceID;
  final String SerialNumber;
  final String model;
  final String name;
  final String langugae;
  final String modileNo;
  SingleAssetValidateWidget(
      {this.langugae,
      this.modileNo,
      this.name,
      this.GPSDeviceID,
      this.SerialNumber,
      this.StartDate,
      this.model});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: tuna),
        child: Row(
          children: [
            Container(
              width: 40,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: black),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: tuna),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Icon(Icons.keyboard_arrow_down),
                  SizedBox(
                    height: 40,
                  ),
                  Icon(Icons.check_box_outline_blank)
                ],
              ),
            ),
            CustomCardSmsAssetWidget(
              date: StartDate,
              deviceId: GPSDeviceID,
              language: langugae,
              mobileNo: modileNo,
              model: model,
              name: name,
              serialNo: SerialNumber,
            ),
          ],
        ),
      ),
      SizedBox(height: 20,)
    ]);
  }
}
