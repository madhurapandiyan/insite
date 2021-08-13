import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/service_plan.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class AssetDetailHealth extends StatelessWidget {
  final AssetDetail detail;
  const AssetDetailHealth({this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_down, color: Colors.white),
                SizedBox(
                  width: 20,
                ),
                InsiteText(
                  color: Colors.white,
                  size: 12,
                  text: "DETAILS",
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
          Container(
            child: Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  // InsiteTableRowItem(
                  //   title: "Asset Id",
                  //   content: "-",
                  // ),
                  InsiteTableRowItem(
                    title: "Asset Status",
                    content: detail.status,
                  ),
                  InsiteTableRowItem(
                    title: "Serial No.",
                    content: detail.assetSerialNumber,
                  ),
                   InsiteTableRowItem(
                    title: "Geofences",
                    content: "-",
                  )
                ]),
                TableRow(children: [
                  // InsiteTableRowItem(
                  //   title: "Geofences",
                  //   content: "-",
                  // ),
                  InsiteTableRowItem(
                    title: "Manufacturer",
                    content: detail.manufacturer,
                  ),
                  InsiteTableRowItem(
                    title: "Product Family",
                    content: detail.productFamily,
                  ),
                  InsiteTableRowItem(
                    title: "Model ",
                    content: detail.model != null ? detail.model : "-",
                  )
                ]),
                TableRow(children: [
                  // InsiteTableRowItem(
                  //   title: "Model ",
                  //   content: detail.model != null ? detail.model : "-",
                  // ),
                  InsiteTableRowItem(
                    title: "Year",
                    content: detail.year != null ? detail.year.toString() : "-",
                  ),
                  InsiteTableRowItem(
                    title: "Hour Meter",
                    content: detail.hourMeter != null
                        ? detail.hourMeter.round().toString() + "hrs"
                        : "-",
                  ),
                   InsiteTableRowItem(
                    title: "Last Reported time",
                    content: detail.lastReportedTimeUTC != null
                        ? Utils.getLastReportedDateOneUTC(
                            detail.lastReportedTimeUTC)
                        : "-",
                  )

                ]),
                TableRow(children: [
                  // InsiteTableRowItem(
                  //   title: "Last Reported time",
                  //   content: detail.lastReportedTimeUTC != null
                  //       ? Utils.getLastReportedDateOneUTC(
                  //           detail.lastReportedTimeUTC)
                  //       : "-",
                  // ),
                  InsiteTableRowItem(
                    title: "Groups",
                    content: "-",
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Custom Asset State",
                        style: TextStyle(
                            color: textcolor,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.0),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InsiteButton(
                        width: 84,
                        height: 32,
                        title: "in Use",
                        bgColor: bgcolor,
                        textColor: textcolor,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                  InsiteTableRowItem(
                    title: "Service Plans",
                    content: getServiceNames(),
                  )
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                    title: "Service Plans",
                    content: getServiceNames(),
                  ),
                  InsiteTableRowItem(
                    title: "Location",
                    // content: detail.lastReportedLocationLatitude != null &&
                    //         detail.lastReportedLocationLongitude != null
                    //     ? detail.lastReportedLocationLatitude.toString() +
                    //         "/" +
                    //         detail.lastReportedLocationLongitude.toString()
                    //     : "-",
                    content: detail.lastReportedLocation != null
                        ? detail.lastReportedLocation
                        : "-",
                  ),
                  InsiteTableRowItem(
                    title: "",
                    content: "",
                  ),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getServiceNames() {
    Logger().d(detail.devices[0].activeServicePlans);
    StringBuffer value = StringBuffer();
    if (detail.devices.isNotEmpty &&
        detail.devices[0].activeServicePlans != null &&
        detail.devices[0].activeServicePlans.isNotEmpty) {
      for (ServicePlan plan in detail.devices[0].activeServicePlans) {
        value.write(plan.type + "\n");
      }
      return value.toString();
    } else {
      return "-";
    }
  }
}
