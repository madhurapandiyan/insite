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
    return Column(
      children: [
      Card(
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Icon(Icons.keyboard_arrow_down),
                  SizedBox(
                    height: 30,
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
      SizedBox(
        height: 20,
      )
    ]);
  }
}
