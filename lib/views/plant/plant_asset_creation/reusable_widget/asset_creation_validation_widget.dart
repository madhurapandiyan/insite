import 'package:flutter/material.dart';

import 'package:insite/views/plant/plant_asset_creation/asset_creation_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class AssetCreationValidationWidget extends StatefulWidget {
  final AssetCreationModel? data;
  final VoidCallback? voidCallback;

  const AssetCreationValidationWidget({this.data, this.voidCallback});

  @override
  _AssetCreationValidationWidgetState createState() =>
      _AssetCreationValidationWidgetState();
}

class _AssetCreationValidationWidgetState
    extends State<AssetCreationValidationWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.voidCallback!();
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
                  // Container(
                  //     decoration: BoxDecoration(
                  //         color: widget.data.isSelected
                  //             ? Theme.of(context).buttonColor
                  //             : Theme.of(context).backgroundColor,
                  //         borderRadius: BorderRadius.all(Radius.circular(4))),
                  //     child: Icon(Icons.crop_square,
                  //         color: widget.data.isSelected
                  //             ? Theme.of(context).buttonColor
                  //             : Colors.black)),
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
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InsiteText(
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                    text: widget.data!.assetSerialNo),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InsiteText(
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                    text: widget.data!.deviceId,
                                  ),
                                )),
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
                              padding: const EdgeInsets.only(right: 110.0),
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
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InsiteText(
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                    text: widget.data!.model,
                                  ),
                                )),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InsiteText(
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                    text: widget.data!.hourMeter,
                                  ),
                                )),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ],
                    ),
                    TableRow(children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 110.0),
                            child: InsiteText(
                              text: "Status:",
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
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InsiteText(
                                  size: 14,
                                  fontWeight: FontWeight.w700,
                                  text: widget.data!.status,
                                ),
                              )),
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
                            padding: const EdgeInsets.only(right: 90.0),
                            child: InsiteText(
                              text: "Message:",
                              size: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.38,
                            height: MediaQuery.of(context).size.height * 0.08,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InsiteText(
                                size: 14,
                                fontWeight: FontWeight.w700,
                                text: widget.data!.message,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ])
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
