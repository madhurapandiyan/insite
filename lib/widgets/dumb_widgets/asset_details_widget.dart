import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/service_plan.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class AssetDetailWidgt extends StatelessWidget {
  final AssetDetail? detail;
  final String? group;
  final String? geofence;
  const AssetDetailWidgt({this.detail, this.group, this.geofence});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Row(
              children: [
                // Icon(Icons.keyboard_arrow_down, color: Colors.white),
                SizedBox(
                  width: 20,
                ),
                InsiteText(
                  size: 12,
                  text: "DETAILS",
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).dividerColor,
            thickness: 1,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(8),
            child: Table(
              border: TableBorder.all(),
              defaultColumnWidth: FlexColumnWidth(5),
              children: [
                TableRow(children: [
                  // hiding for now
                  // InsiteTableRowItem(
                  //   title: "Asset Id",
                  //   content: "-",
                  // ),
                  InsiteTableRowItem(
                    title: "Asset Status",
                    content: detail!.status,
                  ),
                  InsiteTableRowItem(
                    title: "Serial No.",
                    content: detail!.assetSerialNumber,
                  )
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                    title: "Manufacturer",
                    content: detail!.manufacturer,
                  ),
                  InsiteTableRowItem(
                    title: "Product Family",
                    content: detail!.productFamily,
                  )
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                    title: "Model ",
                    content: detail!.model != null ? detail!.model : "-",
                  ),
                  InsiteTableRowItem(
                    title: "Year",
                    content:
                        detail!.year != null ? detail!.year.toString() : "-",
                  )
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                    title: "Last Reported time",
                    content: detail!.lastReportedTimeUtc != null
                        ? Utils.getLastReportedDateOneUTC(
                            detail!.lastReportedTimeUtc)
                        : "-",
                  ),
                  InsiteTableRowItem(
                    title: "Hour Meter",
                    content: detail!.hourMeter != null
                        ? detail!.hourMeter!.toString() + " Hrs"
                        : "",
                  ),
                ]),
                TableRow(children: [
                  Container(
                    child: InsiteTableRowItem(
                      title: "Service Plans",
                      content: getServiceNames(),
                    ),
                  ),
                  InsiteTableRowItem(
                    title: "Location",
                    // content: detail.lastReportedLocationLatitude != null &&
                    //         detail.lastReportedLocationLongitude != null
                    //     ? detail.lastReportedLocationLatitude.toString() +
                    //         "/" +
                    //         detail.lastReportedLocationLongitude.toString()
                    //     : "-",
                    content: detail!.lastReportedLocation != null
                        ? detail!.lastReportedLocation
                        : "-",
                  ),
                ]),
                TableRow(children: [
                  InsiteTableRowItem(
                      title: "Groups", content: group != null ? group! : "-"),
                  InsiteTableRowItem(
                      title: "Geofences",
                      content: geofence != null ? geofence : "-"),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getServiceNames() {
    detail!.devices![0].activeServicePlans!.forEach((element) {
      Logger().d("service plans ${element.toJson()} ");
    });

    StringBuffer value = StringBuffer();
    String? servicePlans;
    if (detail!.devices!.isNotEmpty &&
        detail!.devices![0].activeServicePlans != null &&
        detail!.devices![0].activeServicePlans!.isNotEmpty) {
      for (ServicePlan plan in detail!.devices![0].activeServicePlans!) {
        value.write(plan.type! + "\n");
        servicePlans =
            "${servicePlans == null ? plan.type : servicePlans + ",${plan.type}"}";
      }
      return servicePlans!;
    } else {
      return "-";
    }
  }
}
