import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/subscription/replacement/model/device_replacement_status_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class ReplacementStatusTableWidget extends StatelessWidget {
  DeviceReplacementStatusModel modelData;
  ReplacementStatusTableWidget({this.modelData});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: tuna,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.keyboard_arrow_down),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.check_box_outline_blank,
                          color: white,
                        ))
                  ],
                ),
              ),
              Expanded(
                child: InsiteExpansionTile(
                  childrenPadding: EdgeInsets.all(10),
                  title: Table(
                    border: TableBorder.all(width: 1, color: black),
                    columnWidths: {
                      0: FlexColumnWidth(5),
                      1: FlexColumnWidth(5)
                    },
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Old Device ID : ",
                          content: modelData.OldDeviceId ?? "null",
                        ),
                        InsiteTableRowItem(
                          title: "New Device ID :",
                          content: modelData.NewDeviceId ?? "null",
                        ),
                      ]),
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Serial No",
                          content: modelData.VIN ?? "null",
                        ),
                        InsiteTableRowItem(
                          title: "Reason  :",
                          content: modelData.Reason ?? "null",
                        ),
                      ]),
                    ],
                  ),
                  children: [
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            InsiteTableRowItem(
                              title: "Replacement Status : ",
                   
                              content: modelData.State ?? "null",
                            ),
                            InsiteTableRowItem(
                              title: "Description : ",
                              content: modelData.Description ?? "null",
                            ),
                         
                          ],
                        ),
                        TableRow(children: [
                          InsiteTableRowItem(
                            title: "First Name :",
                            content: modelData.FirstName ?? "null",
                          ),
                          InsiteTableRowItem(
                            title: "Last Name : ",
                            content: modelData.LastName ?? "null",
                          ),
                        ]),
                        TableRow(children: [
                          InsiteTableRowItem(
                            title: "User Email :",
                            content: modelData.EmailID ?? "null",
                          ),
                          InsiteTableRowItem(
                            title: "Request Time : ",
                            content: Utils.getLastReportedDateFilterData(
                                    DateTime.parse(modelData.InsertUTC)) ??
                                "null",
                          ),
                        ]),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
