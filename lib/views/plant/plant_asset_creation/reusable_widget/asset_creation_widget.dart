import 'package:flutter/material.dart';

import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/plant/plant_asset_creation/asset_creation_model.dart';

import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';

class AssetCreationWidget extends StatefulWidget {
  final Function(String) onAssetSerialValueChange;

  final Function(String) onDeviceIdValueChange;
  final Function(String) onHourMeterValueChange;

  final AssetCreationModel data;
  final VoidCallback voidCallback;
  const AssetCreationWidget(
      {this.onAssetSerialValueChange,
      this.onDeviceIdValueChange,
      this.onHourMeterValueChange,
      this.data,
      this.voidCallback})
      : super();

  @override
  _AssetCreationWidgetState createState() => _AssetCreationWidgetState();
}

class _AssetCreationWidgetState extends State<AssetCreationWidget> {
  TextEditingController modelController = new TextEditingController();

  @override
  void didUpdateWidget(covariant AssetCreationWidget oldWidget) {
    modelController.text =
        oldWidget.data.model == null ? "" : oldWidget.data.model;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.voidCallback();
      },
      child: Card(
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
                          color: widget.data.isSelected
                              ? Theme.of(context).buttonColor
                              : Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Icon(Icons.crop_square,
                          color: widget.data.isSelected
                              ? Theme.of(context).buttonColor
                              : Colors.black)),
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
                              width: MediaQuery.of(context).size.width * 0.38,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: CustomTextBox(
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
                              width: MediaQuery.of(context).size.width * 0.38,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: CustomTextBox(
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
                                width: MediaQuery.of(context).size.width * 0.38,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: CustomTextBox(
                                  controller: modelController,
                                )
                                //  InsiteText(
                                //   size: 14,
                                //   fontWeight: FontWeight.w700,
                                //   text: widget.data.model != null
                                //       ? widget.data.model
                                //       : "",
                                // )
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
                              width: MediaQuery.of(context).size.width * 0.38,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: CustomTextBox(
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
      ),
    );
  }
}
