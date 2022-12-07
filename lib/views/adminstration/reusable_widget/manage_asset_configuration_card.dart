import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class ManageAssetConfigurationCard extends StatelessWidget {
  final AssetSettingsRow? assetSetting;
  final VoidCallback? voidCallback;
  const ManageAssetConfigurationCard({this.assetSetting, this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        voidCallback!();
      },
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Icon(Icons.arrow_drop_down,
                  //     color: Theme.of(context).iconTheme.color),
                  // SizedBox(
                  //   height: 20,
                  // ),

                  Container(
                    // decoration: BoxDecoration(
                    //     color: assetSetting!.isSelected
                    //         ? Theme.of(context).buttonColor
                    //         : Theme.of(context).backgroundColor,
                    //     borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: assetSetting!.isSelected
                        ? Icon(
                            Icons.check_box_rounded,
                            color: Theme.of(context).buttonColor,
                          )
                        : Icon(
                            Icons.check_box_outline_blank,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: InsiteExpansionTile(
              title: Table(
                border: TableBorder.all(width: 2, color: borderLineColor),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1)
                },
                children: [
                  TableRow(children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  new BoxShadow(
                                      blurRadius: 1.0, color: containercolor)
                                ],
                                border: Border.all(
                                    width: 2.5, color: containercolor),
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle),
                            child: Image.asset(Utils()
                                .getImageAssetConfiguration(assetSetting
                                    ?.assetSettings?.assetIconKey))),
                        SizedBox(
                          width: 10,
                        ),
                        InsiteTableRowItem(
                          title: "Asset ID :",
                          content: "-",
                        )
                      ],
                    ),
                    InsiteTableRowItem(
                      title: 'Make :',
                      content:
                          assetSetting!.assetSettings!.assetMakeCode != null
                              ? assetSetting!.assetSettings!.assetMakeCode
                              : "-",
                    ),
                    InsiteTableRowItem(
                      title: 'Model :',
                      content: assetSetting!.assetSettings!.assetModel != null
                          ? assetSetting!.assetSettings!.assetModel
                          : "-",
                    ),
                  ]),
                  TableRow(children: [
                    InsiteRichText(
                      title: "Asset SN :",
                      content:
                          assetSetting!.assetSettings!.assetSerialNumber != null
                              ? assetSetting!.assetSettings!.assetSerialNumber
                              : "-",
                    ),
                    InsiteTableRowItem(
                      title: "Device ID :",
                      content:
                          assetSetting!.assetSettings!.deviceSerialNumber !=
                                  null
                              ? assetSetting!.assetSettings!.deviceSerialNumber
                              : "-",
                    ),
                    InsiteTableRowItem(
                      title: 'Device Type :',
                      content: assetSetting!.assetSettings!.devicetype != null
                          ? assetSetting!.assetSettings!.devicetype
                          : "-",
                    ),
                  ])
                ],
              ),
              tilePadding: EdgeInsets.all(0),
              childrenPadding: EdgeInsets.all(0),
            ))
          ])),
    );
  }
}
