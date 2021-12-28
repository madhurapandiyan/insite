import 'package:flutter/material.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_card_asset_registration.dart';

class MultipleAssetRegistrationCard extends StatelessWidget {
  final AssetValues? assetValue;

  MultipleAssetRegistrationCard({this.assetValue});

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
            CustoCardMultipleAssetWidget(assetValue: assetValue)
          ],
        ),
      ),
      SizedBox(
        height: 20,
      )
    ]);
  }
}
