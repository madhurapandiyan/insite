import 'package:flutter/material.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:intl/intl.dart';

class AssetItem extends StatelessWidget {
  final Asset asset;
  final VoidCallback onCallback;
  const AssetItem({this.asset, this.onCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCallback();
      },
      child: Container(
        margin: EdgeInsets.all(6.0),
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
          border: Border.all(width: 2.5, color: cardcolor),
          shape: BoxShape.rectangle,
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_drop_down, color: Colors.white),
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
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: InsiteImage(
                          height: 30,
                          width: 50,
                          path: "assets/images/truck.png",
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              asset != null ? asset.productFamily : "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: textcolor),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: textcolor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "Serial No. "),
                      TextSpan(
                        text: asset != null ? asset.serialNumber : "",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: tango),
                      )
                    ])),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Total Duration",
                        style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: textcolor),
                      ),
                      Text(
                        asset != null && asset.assetLastReceivedEvent != null
                            ? getLastReportedDate(asset
                                .assetLastReceivedEvent.lastReceivedEventUTC)
                            : "",
                        style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: textcolor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Last Known Operator",
                        style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: textcolor),
                      ),
                      Text(
                        asset != null && asset.assetLastReceivedEvent != null
                            ? getLastReportedDate(asset.assetLastReceivedEvent
                                .lastReceivedEventTimeLocal)
                            : "",
                        style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: textcolor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getLastReportedDate(date) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String getLastDuration(date) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
