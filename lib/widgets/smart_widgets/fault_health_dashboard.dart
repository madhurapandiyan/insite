import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/fault_health_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class FaultHealthDashboard extends StatefulWidget {
  final ScreenType screenType;
  final List<Count> countData;
  final bool isRefreshing;
  final bool loading;
  final Function(FilterData) onFilterSelected;
  FaultHealthDashboard(
      {this.countData,
      this.loading,
      this.onFilterSelected,
      this.screenType,
      this.isRefreshing});

  @override
  _FaultHealthDashboardState createState() => _FaultHealthDashboardState();
}

class _FaultHealthDashboardState extends State<FaultHealthDashboard> {
  var buttonColor = [burntSienna, Colors.orange, mustard];
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: widget.countData.length >= 3
            ? MediaQuery.of(context).size.height * 0.35
            : MediaQuery.of(context).size.height * 0.28,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // SvgPicture.asset("assets/images/arrowdown.svg"),
                      SizedBox(
                        width: 10,
                      ),
                      InsiteText(
                          text: "FAULT CODES",
                          fontWeight: FontWeight.w900,
                          size: 11.0),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () => print("button is tapped"),
                  //       child: SvgPicture.asset(
                  //         "assets/images/menu.svg",
                  //         width: 20,
                  //         height: 20,
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
              color: Theme.of(context).dividerColor,
            ),
            // Container(
            //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            //     height: MediaQuery.of(context).size.height * .05,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5.0),
            //       boxShadow: [
            //         new BoxShadow(blurRadius: 1.0, color: cardcolor)
            //       ],
            //       border: Border.all(width: 2.5, color: silver),
            //       shape: BoxShape.rectangle,
            //     ),
            //     child: FaultDropDown()),
            SizedBox(
              height: 10,
            ),
            (widget.loading || widget.isRefreshing)
                ? Expanded(child: InsiteProgressBar())
                : Expanded(
                    child: ListView.builder(
                        itemCount: widget.countData.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          Count countResponse = widget.countData[index];
                          return FaultWidget(
                            data: countResponse,
                            showAssetCount: false,
                            screenType: widget.screenType,
                            onSelected: () {
                              if (countResponse.faultCount > 0) {
                                widget.onFilterSelected(FilterData(
                                    isSelected: true,
                                    count: countResponse.assetCount.toString(),
                                    title: countResponse.countOf,
                                    type: FilterType.SEVERITY));
                              }
                            },
                            buttonColor: buttonColor[index],
                            level: Utils.getFaultLabel(countResponse.countOf),
                          );
                        }),
                  ),
            Divider(
              thickness: 1.0,
              color: Theme.of(context).dividerColor,
            ),
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InsiteTextAlign(
                      text: "VIEWING DATA FOR 7 DAYS",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w900,
                      size: 10.0)),
            ),
          ],
        ),
      ),
    );
  }
}
