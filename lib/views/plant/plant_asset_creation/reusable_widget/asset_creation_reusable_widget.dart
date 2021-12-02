import 'package:flutter/material.dart';

import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/plant/plant_asset_creation/asset_creation_model.dart';

import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';

class AssetCreationReusablewidget extends StatefulWidget {
  final Function(String) onAssetSerialValueChange;
  final Function(String) onModelValueChange;
  final Function(String) onDeviceIdValueChange;
  final Function(String) onHourMeterValueChange;

  final AssetCreationModel data;

  const AssetCreationReusablewidget(
      {this.onAssetSerialValueChange,
      this.onModelValueChange,
      this.onDeviceIdValueChange,
      this.onHourMeterValueChange,
      this.data,
     })
      : super();

  @override
  _AssetCreationReusablewidgetState createState() =>
      _AssetCreationReusablewidgetState();
}

class _AssetCreationReusablewidgetState
    extends State<AssetCreationReusablewidget> {
  @override
  Widget build(BuildContext context) {
    // widget.modelController.text=widget.data.model.text;
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Icon(Icons.crop_square, color: Colors.black)),
              ],
            ),
          ),
          Expanded(
            child: InsiteExpansionTile(
              title: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(8),
                  1: FlexColumnWidth(8),
                },
                children: [
                  TableRow(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50.0),
                            child: InsiteText(
                              text: "Asset Serial No. :",
                              size: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: CustomTextBox(
                              // controller: assetSerialController,
                              onChanged: (String value) {
                                widget.data.assetSerialNo = value;

                                widget.onAssetSerialValueChange(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 88.0),
                            child: InsiteText(
                              text: "Device ID :",
                              size: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: CustomTextBox(
                              // controller: deviceIdController,
                              onChanged: (String value) {
                                widget.data.deviceId = value;
                                widget.onDeviceIdValueChange(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 100.0),
                            child: InsiteText(
                              text: "Model:",
                              size: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.41,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InsiteText(
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                    text: widget.data.model.text != null
                                        ? widget.data.model.text
                                        : "",
                                  ))),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 80.0),
                            child: InsiteText(
                              text: "Hour Meter:",
                              size: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: CustomTextBox(
                              //controller: hourMeterController,
                              onChanged: (String value) {
                                widget.data.hourMeter = value;
                                widget.onHourMeterValueChange(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              tilePadding: EdgeInsets.all(0),
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
