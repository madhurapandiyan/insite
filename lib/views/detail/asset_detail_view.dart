import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/appbar/appvar_view.dart';
import 'package:insite/views/detail/tabs/asset_dashboard.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:stacked/stacked.dart';
import 'asset_detail_view_model.dart';

class AssetDetailView extends StatefulWidget {
  final Fleet fleet;
  AssetDetailView({this.fleet});

  @override
  _TabPageState createState() => _TabPageState();
}

class DetailArguments {
  final Fleet fleet;
  DetailArguments({this.fleet});
}

class _TabPageState extends State<AssetDetailView> {
  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetDetailViewModel>.reactive(
      builder:
          (BuildContext context, AssetDetailViewModel viewModel, Widget _) {
        return Scaffold(
          backgroundColor: bgcolor,
          appBar: InsiteAppBar(
            screenType: ScreenType.ASSET_DETAIL,
            height: 56,
          ),
          body: viewModel.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        margin:
                            EdgeInsets.only(left: 14.0, right: 15.0, top: 20.0),
                        child: Container(
                          width: 385,
                          height: 83,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              new BoxShadow(blurRadius: 1.0, color: cardcolor)
                            ],
                            border: Border.all(width: 2.5, color: cardcolor),
                            shape: BoxShape.rectangle,
                          ),
                          child: Table(children: [
                            TableRow(children: [
                              Column(
                                children: [
                                  Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, bottom: 15.0),
                                      child: SvgPicture.asset(
                                          "assets/images/arrowdown.svg"),
                                    ),
                                    SizedBox(width: 10.0),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 13.0),
                                      child: new Container(
                                        width: 58.7,
                                        height: 54,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          boxShadow: [
                                            new BoxShadow(
                                                blurRadius: 1.0,
                                                color: containercolor)
                                          ],
                                          border: Border.all(
                                              width: 2.5,
                                              color: containercolor),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Image.asset(
                                            "assets/images/truck.png"),
                                      ),
                                    ),
                                    SizedBox(width: 15.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 38.0),
                                              child: new RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                  text: widget
                                                      .fleet.assetSerialNumber,
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: tango),
                                                )
                                              ])),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15.0),
                                        new Text(
                                          widget.fleet.dealerName,
                                          style: new TextStyle(
                                              fontFamily: 'Roboto',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w700,
                                              color: textcolor,
                                              fontSize: 12.0),
                                        )
                                      ],
                                    ),
                                  ]),
                                ],
                              ),
                            ]),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: 14.0, right: 15.0),
                        child: Container(
                          width: 385,
                          height: 41,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              new BoxShadow(blurRadius: 1.0, color: cardcolor)
                            ],
                            border: Border.all(width: 2.5, color: cardcolor),
                            shape: BoxShape.rectangle,
                          ),
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 14.99),
                              child: new Text("UCID NAME :",
                                  style: new TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 11.0)),
                            ),
                            SizedBox(width: 15.0),
                            new Text(
                              "TRAINING DEPT",
                              style: new TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  color: textcolor,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 11.0),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(height: 13.0),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: 10.0),
                        child: Container(
                          height: 110,
                          child: Container(
                            width: 82,
                            height: 87.29,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _tabcontainer(0, "assets/images/clock.svg"),
                                _tabcontainer(
                                    1, "assets/images/supportmanager.svg"),
                                _tabcontainer(
                                    2, "assets/images/assetmanager.svg"),
                                _tabcontainer(3, "assets/images/loca.svg"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      selectedTabIndex == 0
                          ? AssetDashbaord(
                              detail: viewModel.assetDetail,
                            )
                          : EmptyView(
                              title: "Coming soon",
                            ),
                    ],
                  ),
                ),
        );
      },
      viewModelBuilder: () => AssetDetailViewModel(widget.fleet),
    );
  }

  Widget _tabcontainer(int index, iconPath) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          new Container(
            width: 100,
            height: 180,
            child: Card(
              color:
                  selectedTabIndex == index ? mediumgrey : Colors.transparent,
              semanticContainer: true,
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
            ),
          ),
          Container(
              width: 82,
              height: 87.29,
              child: Card(
                semanticContainer: true,
                color: selectedTabIndex == index ? tango : cardcolor,
                elevation: 10.0,
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset(iconPath)],
                ),
              )),
        ],
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }
}
