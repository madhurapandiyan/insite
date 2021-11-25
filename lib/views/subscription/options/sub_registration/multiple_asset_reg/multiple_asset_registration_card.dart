import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_card_asset_registration.dart';

class MultipleAssetRegistrationCard extends StatelessWidget {
  final String deviceId;
  final String model;
  final String serial;
  final String hRM;
  final String hrmDate;
  final String plantName;
  final String plantCode;
  final String plantEmail;
  final String dealerName;
  final String dealerCode;
  final String dealerEmail;
  final String customerName;
  final String customerCode;
  final String customerEmail;

  MultipleAssetRegistrationCard({
    this.customerCode,
    this.customerEmail,
    this.customerName,
    this.dealerCode,
    this.dealerEmail,
    this.dealerName,
    this.deviceId,
    this.hRM,
    this.hrmDate,
    this.model,
    this.plantCode,
    this.plantEmail,
    this.plantName,
    this.serial,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
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
            CustoCardMultipleAssetWidget(
              deviceId: deviceId,
              model: model,
              serial: serial,
              hRM: hRM,
              hrmDate: hrmDate,
              plantName: plantName,
              plantCode: plantCode,
              plantEmail: plantEmail,
              dealerName: dealerName,
              dealerCode: dealerCode,
              dealerEmail: dealerEmail,
              customerName: customerName,
              customerCode: customerCode,
              customerEmail: customerEmail,
            )
          ],
        ),
      ),
      SizedBox(
        height: 20,
      )
    ]);
    ;
  }
}
