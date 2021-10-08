import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/dashboard.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/detail/tabs/dashboard/asset_dashboard.dart';
import 'package:insite/views/detail/tabs/health/health_dashboard/health_dashboard_view.dart';
import 'package:insite/views/detail/tabs/health/health_list/health_list_view.dart';
import 'package:insite/views/detail/tabs/location/asset_location.dart';
import 'package:insite/views/detail/tabs/single_asset_operation/single_asset_operation_view.dart';
import 'package:insite/views/detail/tabs/utilization/single_asset_utilization_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'asset_detail_view_model.dart';

class AssetDetailView extends StatefulWidget {
  final Fleet fleet;
  final int tabIndex;
  final ScreenType type;
  AssetDetailView({this.fleet, this.tabIndex, this.type = ScreenType.FLEET});

  @override
  _TabPageState createState() => _TabPageState();
}

class DetailArguments {
  final Fleet fleet;
  final int index;
  final ScreenType type;
  DetailArguments({this.fleet, this.index, this.type = ScreenType.FLEET});
}

class _TabPageState extends State<AssetDetailView> {
  int selectedTabIndex = 0;
  @override
  void initState() {
    selectedTabIndex = widget.tabIndex;
    super.initState();
  }

  List<Category> typeOne = [
    Category(
      1,
      "DASHBOARD",
      "assets/images/clock.svg",
      ScreenType.DASHBOARD,
    ),
    Category(
      2,
      "UTILIZATION",
      "assets/images/supportmanager.svg",
      ScreenType.UTILIZATION,
    ),
    Category(
      3,
      "ASSET OPERATION",
      "assets/images/assetmanager.svg",
      ScreenType.ASSET_OPERATION,
    ),
    Category(
      4,
      "LOCATION",
      "assets/images/loca.svg",
      ScreenType.LOCATION,
    ),
  ];

  List<Category> typeTwo = [
    Category(
      1,
      "DASHBOARD",
      "assets/images/clock.svg",
      ScreenType.DASHBOARD,
    ),
    Category(
      2,
      "HEALTH",
      "assets/images/supportmanager.svg",
      ScreenType.HEALTH,
    ),
    Category(
      3,
      "LOCATION",
      "assets/images/loca.svg",
      ScreenType.LOCATION,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetDetailViewModel>.reactive(
      builder:
          (BuildContext context, AssetDetailViewModel viewModel, Widget _) {
        return InsiteScaffold(
          screenType: ScreenType.ASSET_DETAIL,
          viewModel: viewModel,
          onFilterApplied: () {},
          onRefineApplied: () {},
          body: viewModel.loading
              ? InsiteProgressBar()
              : Column(
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
                            BoxShadow(blurRadius: 1.0, color: cardcolor)
                          ],
                          border: Border.all(width: 2.5, color: cardcolor),
                          shape: BoxShape.rectangle,
                        ),
                        child: Table(children: [
                          TableRow(children: [
                            Column(
                              children: [
                                Row(children: [
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //       left: 2.0, bottom: 15.0),
                                  //   child: SvgPicture.asset(
                                  //       "assets/images/arrowdown.svg"),
                                  // ),
                                  SizedBox(width: 10.0),
                                  Padding(
                                    padding: EdgeInsets.only(top: 13.0),
                                    child: Container(
                                      width: 58.7,
                                      height: 54,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        boxShadow: [
                                          BoxShadow(
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 38.0),
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                  text: viewModel.assetDetail
                                                      .assetSerialNumber,
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
                                        Text(
                                          viewModel.assetDetail.dealerName,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w700,
                                              color: textcolor,
                                              fontSize: 12.0),
                                        )
                                      ],
                                    ),
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
                            BoxShadow(blurRadius: 1.0, color: cardcolor)
                          ],
                          border: Border.all(width: 2.5, color: cardcolor),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(children: [
                            Text("CUSTOMER NAME : ",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    color: textcolor,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 11.0)),
                            SizedBox(width: 15.0),
                            Expanded(
                              child: Text(
                                viewModel.assetDetail != null
                                    ? viewModel.assetDetail
                                                .universalCustomerName !=
                                            null
                                        ? viewModel
                                            .assetDetail.universalCustomerName
                                        : "-"
                                    : "-",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    color: textcolor,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 11.0),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(height: 13.0),
                    widget.type == ScreenType.HEALTH
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(typeTwo.length, (index) {
                              Category category = typeTwo[index];
                              return _tabcontainer(index, category);
                            }),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(typeOne.length, (index) {
                              Category category = typeOne[index];
                              return _tabcontainer(index, category);
                            }),
                          ),
                    Flexible(
                      child: selectedTabIndex == 0
                          ? widget.type == ScreenType.HEALTH
                              ? HealthDashboardView(
                                  detail: viewModel.assetDetail,
                                  switchTab: (index) {
                                    setState(() {
                                      selectedTabIndex = index;
                                    });
                                  },
                                )
                              : AssetDashbaord(
                                  detail: viewModel.assetDetail,
                                  switchTab: (index) {
                                    setState(() {
                                      selectedTabIndex = index;
                                    });
                                  },
                                )
                          : selectedTabIndex == 1
                              ? widget.type == ScreenType.HEALTH
                                  ? HealthListView(
                                      detail: viewModel.assetDetail,
                                    )
                                  : SingleAssetUtilizationView(
                                      detail: viewModel.assetDetail,
                                    )
                              : selectedTabIndex == 2
                                  ? widget.type == ScreenType.HEALTH
                                      ? AssetLocationView(
                                          detail: viewModel.assetDetail,
                                          screenType: widget.type)
                                      : SingleAssetOperationView(
                                          detail: viewModel.assetDetail,
                                        )
                                  : selectedTabIndex == 3
                                      ? AssetLocationView(
                                          detail: viewModel.assetDetail,
                                        )
                                      : Container(
                                          child: EmptyView(
                                            title: "Coming soon",
                                          ),
                                        ),
                    ),
                  ],
                ),
        );
      },
      viewModelBuilder: () => AssetDetailViewModel(widget.fleet),
    );
  }

  Widget _tabcontainer(int index, Category category) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            child: Card(
              color:
                  selectedTabIndex == index ? mediumgrey : Colors.transparent,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
            ),
          ),
          Container(
              width: 60,
              height: 60,
              child: Card(
                semanticContainer: true,
                color: selectedTabIndex == index ? tango : cardcolor,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset(category.image)],
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
