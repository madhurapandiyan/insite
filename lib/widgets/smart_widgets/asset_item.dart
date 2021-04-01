import 'package:flutter/material.dart';
import 'package:insite/assetlist/model.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';

class AssetItem extends StatelessWidget {
  final Asset asset;
  const AssetItem({this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      height: 110,
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
              Icon(Icons.crop_square, color: Colors.white),
            ],
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InsiteImage(
                      height: 65,
                      width: 33,
                      path: asset.arrowimage,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          asset.title,
                          style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: textcolor),
                        ),
                        Text(
                          asset.deviceId,
                          style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: textcolor),
                        ),
                      ],
                    ),
                  ],
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: "Serial No. "),
                  TextSpan(
                    text: asset.serialno,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: tango),
                  )
                ])),
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
                      asset.status,
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: textcolor),
                    ),
                    Text(
                      asset.reportingStatus,
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
                      asset.assetState,
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: textcolor),
                    ),
                    Text(
                      asset.assetStatus,
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
    );
  }
}
