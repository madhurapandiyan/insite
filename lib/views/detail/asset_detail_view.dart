import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/dashboard.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/add_intervals/add_intervals_view.dart';
import 'package:insite/views/detail/tabs/dashboard/asset_dashboard.dart';
import 'package:insite/views/detail/tabs/health/health_dashboard/health_dashboard_view.dart';
import 'package:insite/views/detail/tabs/health/health_list/health_list_view.dart';
import 'package:insite/views/detail/tabs/location/asset_location.dart';
import 'package:insite/views/detail/tabs/maintenance_tab/maintenance_tab_view.dart';
import 'package:insite/views/detail/tabs/single_asset_operation/single_asset_operation_view.dart';
import 'package:insite/views/detail/tabs/utilization/single_asset_utilization_view.dart';

import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../core/models/maintenance_list_services.dart';
import 'asset_detail_view_model.dart';

class AssetDetailView extends StatefulWidget {
  final Fleet? fleet;
  final int? tabIndex;
  final ScreenType? type;
  final SummaryData? summaryData;

  AssetDetailView(
      {this.fleet,
      this.tabIndex,
      this.type = ScreenType.FLEET,
      this.summaryData});

  @override
  _TabPageState createState() => _TabPageState();
}

class DetailArguments {
  final Fleet? fleet;
  final int? index;
  final ScreenType? type;
  final SummaryData? summaryData;

  DetailArguments(
      {this.fleet, this.index, this.type = ScreenType.FLEET, this.summaryData});
}

class _TabPageState extends State<AssetDetailView> {
  int? selectedTabIndex = 0;
  @override
  void initState() {
    selectedTabIndex = widget.tabIndex;
    super.initState();
  }

//"assets/images/clock.svg"
//"assets/images/supportmanager.svg",
//"assets/images/location.svg",
//"assets/images/health.svg"
  List<Category> typeOne = [
    Category(
      0,
      "DASHBOARD",
      "assets/images/dashboardicon.svg",
      ScreenType.DASHBOARD,
    ),
    Category(
      1,
      "UTILIZATION",
      "assets/images/utilisationIcon.svg",
      ScreenType.UTILIZATION,
    ),
    Category(
      2,
      "ASSET OPERATION",
      "assets/images/assetOperationIcon.svg",
      ScreenType.ASSET_OPERATION,
    ),
    Category(
      3,
      "LOCATION",
      "assets/images/locationIcon.svg",
      ScreenType.LOCATION,
    ),
    Category(
      4,
      "HEALTH",
      "assets/images/healthicon.svg",
      ScreenType.HEALTH,
    ),
    Category(
      5,
      "MAINTENANCE",
      "assets/images/maintenance.svg",
      ScreenType.HEALTH,
    ),
  ];
//"assets/images/clock.svg"
//"assets/images/health.svg"
//"assets/images/location.svg"
  List<Category> typeTwo = [
    Category(
      0,
      "DASHBOARD",
      "assets/images/dashboardicon.svg",
      ScreenType.DASHBOARD,
    ),
    Category(
      1,
      "HEALTH",
      "assets/images/healthicon.svg",
      ScreenType.HEALTH,
    ),
    Category(
      2,
      "LOCATION",
      "assets/images/locationIcon.svg",
      ScreenType.LOCATION,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetDetailViewModel>.reactive(
      builder:
          (BuildContext context, AssetDetailViewModel viewModel, Widget? _) {
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
                      width: 385,
                      height: 83,
                      margin:
                          EdgeInsets.only(left: 14.0, right: 15.0, top: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1.0,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color!)
                        ],
                        color: Theme.of(context).backgroundColor,
                        border: Border.all(
                            width: 1,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!),
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
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          width: 1, color: containercolor),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Image.asset(Utils()
                                        .getImageWithAssetIconKey(
                                            model: viewModel.assetDetail!.model,
                                            assetIconKey: viewModel
                                                .assetDetail!.assetIcon)),
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
                                            child: InsiteRichText(
                                              title: "",
                                              onTap: () {},
                                              content:
                                                  viewModel.assetDetail != null
                                                      ? viewModel.assetDetail!
                                                          .assetSerialNumber
                                                      : "",
                                            ),
                                            padding:
                                                EdgeInsets.only(right: 38.0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15.0),
                                      Text(
                                        viewModel.assetDetail != null
                                            ? viewModel.assetDetail!.dealerName!
                                            : "",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color,
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
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(children: [
                            InsiteText(
                                text: "CUSTOMER NAME : ",
                                fontWeight: FontWeight.w700,
                                size: 11.0),
                            SizedBox(width: 15.0),
                            Expanded(
                              child: InsiteText(
                                  text: viewModel.assetDetail != null
                                      ? viewModel.assetDetail!
                                                  .universalCustomerName !=
                                              null
                                          ? viewModel.assetDetail!
                                              .universalCustomerName
                                          : "-"
                                      : "-",
                                  fontWeight: FontWeight.w700,
                                  size: 11.0),
                            )
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(height: 13.0),
                    widget.type == ScreenType.HEALTH
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  // spacing: 15,
                                  alignment: WrapAlignment.spaceBetween,
                                  children:
                                      List.generate(typeTwo.length, (index) {
                                    Category category = typeTwo[index];
                                    return _tabcontainer(category.id, category);
                                  }),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    direction: Axis.horizontal,
                                    // spacing: 15,
                                    children:
                                        List.generate(typeOne.length, (index) {
                                      Category category = typeOne[index];
                                      return _tabcontainer(index, category);
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 15,
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
                                  screenType: ScreenType.DASHBOARD,
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
                                      : selectedTabIndex == 4
                                          ? HealthListView(
                                              detail: viewModel.assetDetail,
                                            )
                                          : selectedTabIndex == 5
                                              ? Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    MaintenanceTabView(
                                                      summaryData: SummaryData(
                                                          assetID: viewModel
                                                              .assetDetail!
                                                              .assetUid,
                                                          assetSerialNumber:
                                                              viewModel
                                                                  .assetDetail!
                                                                  .assetSerialNumber),
                                                      serviceCalBack: (value,
                                                          assetDataValue,
                                                          services,
                                                          selectedService) {
                                                        viewModel
                                                            .onServiceSelected(
                                                          ctx: context,
                                                          serviceId: value,
                                                          assetDataValue:
                                                              assetDataValue,
                                                        );
                                                      },
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: PopupMenuButton(
                                                        iconSize: 35,
                                                        icon: Icon(
                                                            Icons.more_vert),
                                                        itemBuilder: (ctx) {
                                                          return List.generate(
                                                              viewModel
                                                                  .popupList
                                                                  .length,
                                                              (index) =>
                                                                  PopupMenuItem(
                                                                    value: viewModel
                                                                            .popupList[
                                                                        index],
                                                                    child:
                                                                        InsiteText(
                                                                      text: viewModel
                                                                              .popupList[
                                                                          index],
                                                                    ),
                                                                  ));
                                                        },
                                                        onSelected: (value) {
                                                          selectedTabIndex = 6;
                                                          viewModel
                                                              .onPopupSelected(
                                                                  value
                                                                      as String);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : viewModel.initialValue ==
                                                      viewModel.popupList[0]
                                                  ? AddIntervalsView(
                                                      assetId: viewModel
                                                          .assetDetail!,
                                                      backCallback: () {
                                                        selectedTabIndex = 5;
                                                        setState(() {});
                                                      },
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
      viewModelBuilder: () => AssetDetailViewModel(widget.fleet, widget.type!),
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
          // Container(
          //   width: 80,
          //   height: 80,
          //   child: Card(
          //     color: selectedTabIndex == index
          //         ? Theme.of(context).buttonColor
          //         : Theme.of(context).backgroundColor,
          //     semanticContainer: true,
          //     shape: RoundedRectangleBorder(
          //       side: BorderSide(
          //           color: Theme.of(context).textTheme.bodyText1!.color!),
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(10),
          //           topRight: Radius.circular(10)),
          //     ),
          //   ),
          // ),
          Container(
              width: 50,
              height: 50,
              child: Card(
                semanticContainer: true,
                color: selectedTabIndex == index
                    ? Theme.of(context).buttonColor
                    : Theme.of(context).backgroundColor,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: selectedTabIndex == index
                          ? Theme.of(context).backgroundColor
                          : Theme.of(context).textTheme.bodyText1!.color!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(category.image,
                        height: 25,
                        width: 25,
                        color: selectedTabIndex == index
                            ? Theme.of(context).backgroundColor
                            : Theme.of(context).iconTheme.color)
                  ],
                ),
              )),
        ],
      ),
    );
  }
  //  PopupMenuButton(
  //                                                     itemBuilder: (ctx){
  //                                                       return List.generate(1, (index) => PopupMenuItem(
  //                                                         child: InsiteText(text: "Add Intervals"),
  //                                                       ));
  //                                                     })

  void onTap(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }
}
