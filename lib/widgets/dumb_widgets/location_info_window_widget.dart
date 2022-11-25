import 'package:clippy_flutter/triangle.dart';
import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

import 'insite_text.dart';

class LocationInfoWindowWidget extends StatelessWidget {
  final int? assetCount;
  final String? infoText;
  final VoidCallback? onCustomWindowClose;
  final VoidCallback? onFleetPageSelectedTap;
  final VoidCallback? onTapWithZoom;
  final ScreenType? type;
  LocationInfoWindowWidget(
      {this.assetCount,
      this.type,
      this.onCustomWindowClose,
      this.onFleetPageSelectedTap,
      this.infoText,
      this.onTapWithZoom});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border: Border.all(
                color: Theme.of(context).textTheme.bodyText1!.color!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InsiteText(
                      text: "Cluster Info",
                      size: 13.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                      onTap: onCustomWindowClose,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.close,
                            color: Theme.of(context).textTheme.bodyText1?.color,
                          )))
                ],
              ),
              Container(
                width: 216,
                child: Padding(
                  padding: EdgeInsets.only(left: 38, top: 5.0, bottom: 5.0),
                  child: InsiteText(
                    text: assetCount! > 1
                        ? assetCount.toString() + " " + "Assets"
                        : "Serialnumber \n $infoText",
                    size: 13.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // InsiteButton(
              //     width: MediaQuery.of(context).size.width * 0.30,
              //     height: MediaQuery.of(context).size.height * 0.06,
              //     fontSize: 12,
              //     bgColor: Theme.of(context).buttonColor,
              //     title: assetCount! > 1
              //         ? type == ScreenType.DASHBOARD
              //             ? "  Fleet List  "
              //             : "  Fleet List  "
              //         : "Dashboard",
              //     textColor: appbarcolor,
              //     onTap: onFleetPageSelectedTap),
              SizedBox(
                height: 10,
              ),
              InsiteButton(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.06,
                  fontSize: 12,
                  bgColor: Theme.of(context).buttonColor,
                  title: assetCount! > 1
                      ? type == ScreenType.DASHBOARD
                          ? " Location "
                          : "Zoom to cluster"
                      : "Details",
                  textColor: appbarcolor,
                  onTap: onTapWithZoom)
            ],
          ),
        ),
        Triangle.isosceles(
          edge: Edge.BOTTOM,
          child: Container(
            color: cardcolor,
            width: 20.0,
            height: 10.0,
          ),
        ),
      ],
    );
  }
}
