import 'package:flutter/material.dart';

import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';

import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class AssetCreationReusablewidget extends StatefulWidget {
  final Function(String) onAssetSerialValueChange;
  final Function(String) onModelValueChange;
  final Function(String) onDeviceIdValueChange;
  final Function(String) onHourMeterValueChange;
  // final TextEditingController assetSerialNoController;
  // final TextEditingController deviceIdController;
  // final TextEditingController modelController;
  // final TextEditingController hoursMeterController;
  final String modelData;

  const AssetCreationReusablewidget(
      {this.onAssetSerialValueChange,
      this.onModelValueChange,
      this.onDeviceIdValueChange,
      this.onHourMeterValueChange,
      // this.assetSerialNoController,
      // this.deviceIdController,
      // this.modelController,
      // this.hoursMeterController,
      this.modelData});

  @override
  _AssetCreationReusablewidgetState createState() =>
      _AssetCreationReusablewidgetState();
}



class _AssetCreationReusablewidgetState
    extends State<AssetCreationReusablewidget> {
  String assetSerialValue;
  String modelValue;
  String deviceIdValue;
  String hourMeterValue;
  TextEditingController modelController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
   modelController.text=widget.modelData;
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
                            
                              validator: (assetSerialNo) {
                                if (assetSerialNo.isEmpty &&
                                    assetSerialNo.length < 9) {
                                  return "Request contains special character or character length is less than 8, Please recheck & retry!!!";
                                }
                              },
                              onChanged: (String value) {
                                assetSerialValue = value;
                                widget
                                    .onAssetSerialValueChange(assetSerialValue);
                                // Logger().w(assetSerialValue);
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
                            child: 
                            CustomTextBox(
                          
                              validator: (deviceIdValue) {
                                if (deviceIdValue.isEmpty &&
                                    deviceIdValue.length < 9) {
                                  return "Request contains special character or character length is less than 8, Please recheck & retry!!!";
                                }
                              },
                              onChanged: (String value) {
                                deviceIdValue = value;
                                widget.onDeviceIdValueChange(deviceIdValue);
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
                            child:
                             CustomTextBox(
                              controller: modelController,
                              validator: (modelValue) {
                                if (modelValue.isEmpty) {
                                  return "Request contains special character or character length is less than 8, Please recheck & retry!!!";
                                }
                              },
                              onChanged: (String value) {
                                modelValue = value;
                                widget.onModelValueChange(modelValue);
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
                           
                              validator: (hoursValue) {
                                if (hoursValue.isEmpty) {
                                  return "Request contains special character or character length is less than 8, Please recheck & retry!!!";
                                }
                              },
                              onChanged: (String value) {
                                hourMeterValue = value;
                                widget.onHourMeterValueChange(hourMeterValue);
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
