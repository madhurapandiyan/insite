import 'dart:async';
import 'dart:ui';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/location/location_view_model.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class LocationView extends StatefulWidget {
  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  String _currentSelectedItem = "MAP";
  double zoomVal = 5.0;
  MapType currentType = MapType.normal;
  List<DateTime>? dateRange;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationViewModel>.reactive(
      builder: (BuildContext context, LocationViewModel viewModel, Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.LOCATION,
            onFilterApplied: () {
              viewModel.refresh();
            },
            onRefineApplied: () {
              viewModel.refresh();
            },
            body: viewModel.loading
                ? InsiteProgressBar()
                : viewModel.assetLocation != null
                    ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(16.0),
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, bottom: 5),
                              child: InsiteText(
                                text: viewModel
                                        .assetLocation!.mapRecords!.length
                                        .toString() +
                                    " of " +
                                    viewModel.totalCount.toString()+" assets",
                                size: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InsiteButton(
                                  title: "Refresh",
                                  width: 90,
                                  height: 30,
                                  bgColor: Theme.of(context).backgroundColor,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  onTap: () {
                                    viewModel.customInfoWindowController
                                        .hideInfoWindow!();
                                    viewModel.refresh();
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // // // Text(
                                    // // //   Utils.getDateInFormatddMMyyyy(
                                    // // //           viewModel.startDate) +
                                    // // //       " - " +
                                    // // //       Utils.getDateInFormatddMMyyyy(
                                    // // //           viewModel.endDate),
                                    // // //   style: TextStyle(
                                    // // //       color: white,
                                    // // //       fontWeight: FontWeight.bold,
                                    // // //       fontSize: 12),
                                    // // // ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // // // GestureDetector(
                                    // // //   onTap: () async {
                                    // // //     dateRange = await showDialog(
                                    // // //       context: context,
                                    // // //       builder: (BuildContext context) =>
                                    // // //           Dialog(
                                    // // //               backgroundColor: transparent,
                                    // // //               child: DateRangeView()),
                                    // // //     );
                                    // // //     if (dateRange != null &&
                                    // // //         dateRange.isNotEmpty) {
                                    // // //       viewModel.customInfoWindowController
                                    // // //           .hideInfoWindow();
                                    // // //       viewModel.refresh();
                                    // // //     }
                                    // // //   },
                                    // // //   child: Container(
                                    // // //     width: 90,
                                    // // //     height: 30,
                                    // // //     decoration: BoxDecoration(
                                    // // //       color: tuna,
                                    // // //       borderRadius: BorderRadius.all(
                                    // // //         Radius.circular(4),
                                    // // //       ),
                                    // // //     ),
                                    // // //     child: Center(
                                    // // //       child: Text(
                                    // // //         'Date Range',
                                    // // //         style: TextStyle(
                                    // // //           color: white,
                                    // // //           fontSize: 12,
                                    // // //           fontWeight: FontWeight.bold,
                                    // // //         ),
                                    // // //       ),
                                    // // //     ),
                                    // // //   ),
                                    // // // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.all(16.0),
                          //   color: Theme.of(context).cardColor,
                          //   width: MediaQuery.of(context).size.width * 1,
                          //   height: MediaQuery.of(context).size.height * 0.05,
                          //   child: Center(
                          //     child: InsiteText(
                          //       text: viewModel
                          //               .assetLocation!.countData!.first.count!
                          //               .toString() +
                          //           "out of " +
                          //           viewModel.totalCount.toString() +
                          //           " assets do not have location information",
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Stack(
                              children: [
                                GoogleMap(
                                  zoomGesturesEnabled: true,
                                  onCameraMove: (position) {
                                    viewModel.customInfoWindowController
                                        .onCameraMove!();
                                    viewModel.manager != null
                                        ? viewModel.manager!
                                            .onCameraMove(position)
                                        : SizedBox();
                                  },
                                  onTap: (argument) {
                                    viewModel.customInfoWindowController
                                        .hideInfoWindow!();
                                  },
                                  onMapCreated:
                                      (GoogleMapController controller) async {
                                    viewModel.customInfoWindowController
                                        .googleMapController = controller;
                                    viewModel.controller.complete(controller);
                                    viewModel.manager != null
                                        ? viewModel.manager!
                                            .setMapId(controller.mapId)
                                        : SizedBox();
                                    viewModel.zoomToMarkers();
                                  },
                                  onCameraIdle: viewModel.manager != null
                                      ? viewModel.manager!.updateMap
                                      : null,
                                  mapType: _changemap(),
                                  compassEnabled: true,
                                  zoomControlsEnabled: false,
                                  markers: viewModel.markers,
                                  initialCameraPosition: viewModel
                                                  .assetLocation !=
                                              null &&
                                          viewModel.assetLocation!.mapRecords!
                                              .isNotEmpty &&
                                          viewModel.assetLocation!.mapRecords!
                                                  .first !=
                                              null &&
                                          viewModel
                                                  .assetLocation!
                                                  .mapRecords!
                                                  .first!
                                                  .lastReportedLocationLatitude !=
                                              null
                                      ? CameraPosition(
                                          target: LatLng(
                                              viewModel
                                                  .assetLocation!
                                                  .mapRecords!
                                                  .first!
                                                  .lastReportedLocationLatitude!,
                                              viewModel
                                                  .assetLocation!
                                                  .mapRecords!
                                                  .first!
                                                  .lastReportedLocationLongitude!),
                                          zoom: 5)
                                      : CameraPosition(
                                          target: LatLng(30.666, 76.8127),
                                          zoom: 4),
                                ),
                                CustomInfoWindow(
                                  controller:
                                      viewModel.customInfoWindowController,
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  height:
                                      MediaQuery.of(context).size.height * 0.36,
                                  offset: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          zoomVal++;
                                          _plus(
                                              zoomVal,
                                              LatLng(
                                                  viewModel
                                                      .assetLocation!
                                                      .mapRecords!
                                                      .first!
                                                      .lastReportedLocationLatitude!,
                                                  viewModel
                                                      .assetLocation!
                                                      .mapRecords!
                                                      .first!
                                                      .lastReportedLocationLongitude!),
                                              viewModel);
                                        },
                                        child: Container(
                                          width: 27.47,
                                          height: 26.97,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 1.0,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color!,
                                              ),
                                            ],
                                            border: Border.all(
                                                width: 1.0,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color!),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/images/plus.svg",
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            zoomVal--;
                                            _minus(
                                                zoomVal,
                                                LatLng(
                                                    viewModel
                                                        .assetLocation!
                                                        .mapRecords!
                                                        .first!
                                                        .lastReportedLocationLatitude!,
                                                    viewModel
                                                        .assetLocation!
                                                        .mapRecords!
                                                        .first!
                                                        .lastReportedLocationLongitude!),
                                                viewModel);
                                          },
                                          child: Container(
                                            width: 27.47,
                                            height: 26.97,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 1.0,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color!,
                                                ),
                                              ],
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color!),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/images/minus.svg",
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Theme.of(context).backgroundColor,
                                  margin: EdgeInsets.only(left: 10, top: 5),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  // decoration: BoxDecoration(
                                  //     border:
                                  //         Border.all(width: 2, color: tuna)),
                                  child: DropdownButton(
                                    dropdownColor:
                                        Theme.of(context).backgroundColor,
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 4.0),
                                      child: Container(
                                        child: SvgPicture.asset(
                                          "assets/images/arrowdown.svg",
                                          width: 10,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          height: 10,
                                        ),
                                      ),
                                    ),
                                    isExpanded: false,
                                    hint: Text(
                                      _currentSelectedItem,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .backgroundColor),
                                    ),
                                    items: [
                                      'MAP',
                                      'TERRAIN',
                                      'SATELLITE',
                                      'HYBRID'
                                    ]
                                        .map((map) => DropdownMenuItem(
                                              value: map,
                                              child: InsiteText(
                                                text: map,
                                                size: 11.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ))
                                        .toList(),
                                    value: _currentSelectedItem,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _currentSelectedItem = value!;
                                      });
                                    },
                                    underline: Container(
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0.0)))),
                                  ),
                                ),
                                viewModel.refreshing
                                    ? InsiteProgressBar()
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ],
                      )
                    : EmptyView(title: "No Location Found"),
          ),
        );
      },
      viewModelBuilder: () => LocationViewModel(ScreenType.LOCATION),
    );
  }

  Future<void> _minus(double zoomVal, LatLng targetPosition,
      LocationViewModel viewModel) async {
    final GoogleMapController mapController = await viewModel.controller.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal, LatLng targetPosition,
      LocationViewModel viewModel) async {
    final GoogleMapController mapController = await viewModel.controller.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
  }

  MapType _changemap() {
    switch (_currentSelectedItem) {
      case "MAP":
        Logger().i("map is in normal type ");
        return MapType.normal;
        break;
      case "TERRAIN":
        Logger().i("map is in terrain type");
        return MapType.terrain;
        break;
      case "SATELLITE":
        Logger().i("map is in satellite type ");
        return MapType.satellite;
        break;
      case "HYBRID":
        Logger().i("map is in hybrid type ");
        return MapType.hybrid;
      default:
        return MapType.normal;
    }
  }
}
