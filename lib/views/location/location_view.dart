import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/location/location_view_model.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../theme/colors.dart';

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: InsiteTextOverFlow(
                              text: Utils.getPageTitle(ScreenType.LOCATION),
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              size: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: PageHeader(
                                  isDashboard: true,
                                  total: viewModel
                                      .assetLocation!.mapRecords!.length,
                                  screenType: ScreenType.LOCATION,
                                  count: 0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16, right: 16),
                                child: InsiteButton(
                                  fontSize: 13,
                                  width: 100,
                                  height: 40,
                                  textColor: white,
                                  title: "Refresh",
                                  onTap: () {
                                    viewModel.customInfoWindowController
                                        .hideInfoWindow!();
                                    viewModel.refresh();
                                  },
                                ),
                              )
                            ],
                          ),

                          // viewModel.showingCard
                          //     ? Container(
                          //         margin: EdgeInsets.all(16.0),
                          //         color: Theme.of(context).cardColor,
                          //         width: MediaQuery.of(context).size.width * 1,
                          //         height:
                          //             MediaQuery.of(context).size.height * 0.05,
                          //         child: Center(
                          //           child: InsiteText(
                          //             text: viewModel.assetInvalidLocationCount
                          //                     .toString() +
                          //                 " out of " +
                          //                 viewModel.totalCount.toString() +
                          //                 " assets do not have location information",
                          //           ),
                          //         ),
                          //       )
                          //     : SizedBox(),
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
                                  padding: const EdgeInsets.only(
                                      right: 10, top: 10, bottom: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color:
                                              Theme.of(context).backgroundColor,

                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          // decoration: BoxDecoration(
                                          //     border:
                                          //         Border.all(width: 2, color: tuna)),
                                          child: DropdownButton(
                                            dropdownColor: Theme.of(context)
                                                .backgroundColor,
                                            icon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.0),
                                              child: Container(
                                                child: SvgPicture.asset(
                                                  "assets/images/arrowdown.svg",
                                                  width: 10,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color,
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                            color: Colors
                                                                .transparent,
                                                            width: 0.0)))),
                                          ),
                                        ),
                                        Column(
                                          children: [
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
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
                                      ],
                                    ),
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
