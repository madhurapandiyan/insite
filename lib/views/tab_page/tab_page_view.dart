import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:stacked/stacked.dart';
import 'tab_page_view_model.dart';

class TabPageView extends StatefulWidget {
  final VoidCallback onDetailPageSelected;
  TabPageView({this.onDetailPageSelected});

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPageView> {
  int selectedcard = -1;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabPageViewModel>.reactive(
      builder: (BuildContext context, TabPageViewModel viewModel, Widget _) {
        return Scaffold(
          backgroundColor: bgcolor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 14.0, right: 15.0, top: 20.0),
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
                    child: Table(
                        // border: TableBorder(verticalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),
                        children: [
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
                                            width: 2.5, color: containercolor),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Image.asset(
                                          "assets/images/truck.png"),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 38.0),
                                            child: new Text(
                                              "THEWABDOKHOOOOO",
                                              style: new TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w700,
                                                  color: tango,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15.0),
                                      new Text(
                                        "TATA HITACHI SHINRAI BX80",
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
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          _tabcontainer(0),
                          SizedBox(
                            width: 10.0,
                          ),
                          _cardcontainer(1),
                          SizedBox(
                            width: 10.0,
                          ),
                          _assetcontainer(2),
                          SizedBox(
                            width: 10.0,
                          ),
                          _locacontainer(3),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      new BoxShadow(blurRadius: 1.0, color: mediumgrey)
                    ],
                    border: Border.all(width: 2.5, color: mediumgrey),
                    shape: BoxShape.rectangle,
                  ),
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => TabPageViewModel(),
    );
  }

  Widget _tabcontainer(int index) {
    return GestureDetector(
      onTap: () {
        buttontap(index);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          new Container(
            width: 100,
            height: 180,
            child: Card(
              color: selectedcard == index ? mediumgrey : Colors.transparent,
              semanticContainer: true,
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Container(
              width: 82,
              height: 87.29,
              child: Card(
                semanticContainer: true,
                color: selectedcard == index ? tango : cardcolor,
                elevation: 10.0,
                //margin: EdgeInsets.all(1.0),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset("assets/images/clock.svg")],
                ),
              )),
        ],
      ),
    );
  }

  Widget _cardcontainer(int index) {
    return GestureDetector(
      onTap: () {
        buttontap(index);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          new Container(
            width: 100,
            height: 180,
            child: Card(
              color: selectedcard == index ? mediumgrey : Colors.transparent,
              semanticContainer: true,
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Container(
              width: 82,
              height: 87.29,
              child: Card(
                semanticContainer: true,
                color: selectedcard == index ? tango : cardcolor,
                elevation: 10.0,
                //margin: EdgeInsets.all(1.0),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/supportmanager.svg")
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _assetcontainer(int index) {
    return GestureDetector(
      onTap: () {
        buttontap(index);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          new Container(
            width: 100,
            height: 180,
            child: Card(
              color: selectedcard == index ? mediumgrey : Colors.transparent,
              semanticContainer: true,
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Container(
              width: 82,
              height: 87.29,
              child: Card(
                semanticContainer: true,
                color: selectedcard == index ? tango : cardcolor,
                elevation: 10.0,
                //margin: EdgeInsets.all(1.0),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/assetmanager.svg")
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _locacontainer(int index) {
    return GestureDetector(
      onTap: () {
        buttontap(index);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          new Container(
            width: 100,
            height: 180,
            child: Card(
              color: selectedcard == index ? mediumgrey : Colors.transparent,
              semanticContainer: true,
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Container(
              width: 82,
              height: 87.29,
              child: Card(
                semanticContainer: true,
                color: selectedcard == index ? tango : cardcolor,
                elevation: 10.0,
                //margin: EdgeInsets.all(1.0),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset("assets/images/loca.svg")],
                ),
              )),
        ],
      ),
    );
  }

  void buttontap(int index) {
    if (index == 0) {
      setState(() {
        selectedcard = index;
      });
    }
    if (index == 1) {
      setState(() {
        selectedcard = index;
      });
    }
    if (index == 2) {
      setState(() {
        selectedcard = index;
      });
    }
    if (index == 3) {
      setState(() {
        selectedcard = index;
      });
    }
  }
}
