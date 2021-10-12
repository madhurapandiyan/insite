import 'package:clippy_flutter/triangle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class SingleInfoView extends StatelessWidget {
  final AssetLocation assetLocation;
  const SingleInfoView({Key key, this.assetLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).backgroundColor,
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1.color)),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4)),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InsiteText(
                            text: "Location Reported Time",
                            fontWeight: FontWeight.w900,
                            size: 10.0),
                        InsiteText(
                            text: assetLocation.locationEventLocalTime
                                    .toString()
                                    .split('T')
                                    .first
                                    .split('-')[2]
                                    .split(' ')
                                    .first +
                                '/' +
                                assetLocation.locationEventLocalTime
                                    .toString()
                                    .split('T')
                                    .first
                                    .split('-')[1] +
                                '/' +
                                assetLocation.locationEventLocalTime
                                    .toString()
                                    .split('T')
                                    .first
                                    .split('-')[0] +
                                ' ' +
                                assetLocation.locationEventLocalTime
                                    .toString()
                                    .split('T')
                                    .last
                                    .split(':')[0]
                                    .split(' ')
                                    .last +
                                ':' +
                                assetLocation.locationEventLocalTime
                                    .toString()
                                    .split('T')
                                    .last
                                    .split(':')[1] +
                                ' ' +
                                assetLocation.locationEventLocalTimeZoneAbbrev,
                            size: 8.0),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InsiteText(
                            text: "Location",
                            fontWeight: FontWeight.w900,
                            size: 10.0),
                        InsiteText(
                            text: assetLocation.address != null
                                ? getAddressText(assetLocation.address)
                                : "",
                            size: 8.0),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InsiteText(
                            text: "Hours: ${assetLocation.hourmeter} Hrs",
                            size: 8.0),
                        InsiteText(
                            text: "Odometer: ${assetLocation.odometer} Hrs",
                            size: 8.0),
                      ],
                    ),
                  ),
                ],
              ),
              width: 100,
              height: 100,
            ),
          ),
          Triangle.isosceles(
            edge: Edge.BOTTOM,
            child: Container(
              color: Theme.of(context).backgroundColor,
              width: 20.0,
              height: 10.0,
            ),
          ),
        ],
      ),
    );
  }

  String getAddressText(Address address) {
    print("getAddressText ${address.streetAddress}");
    String text = "";
    text = address.streetAddress != null
        ? address.streetAddress
        : "" + ',' + address.city != null
            ? address.city
            : "" + ',' + address.county != null
                ? address.county
                : "" + ',' + address.state != null
                    ? address.state
                    : "" + ' ' + address.zip != null
                        ? address.zip
                        : "";
    return text;
  }
}