import 'dart:async';
import 'dart:ui';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/views/location/location_view_model.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class LocationView extends StatefulWidget {
  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  String _currentSelectedItem = "MAP";
  double zoomVal = 5.0;
  Completer<GoogleMapController> _controller = Completer();
  MapType currentType = MapType.normal;
  List<DateTime> dateRange;

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
      builder: (BuildContext context, LocationViewModel viewModel, Widget _) {
        if (viewModel.loading) {
          return InsiteScaffold(
              viewModel: viewModel,
              screenType: ScreenType.LOCATION,
              onFilterApplied: () {},
              body: Center(
                child: CircularProgressIndicator(),
              ));
        } else if (viewModel.assetLocation != null) {
          return InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.LOCATION,
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          viewModel.refresh();
                        },
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            color: tuna,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Refresh',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (dateRange == null || dateRange.isEmpty)
                                ? '${Utils.parseDate(DateTime.now().subtract(Duration(days: DateTime.now().weekday)))} - ${Utils.parseDate(DateTime.now())}'
                                : '${Utils.parseDate(dateRange.first)} - ${Utils.parseDate(dateRange.last)}',
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              dateRange = await showDialog(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                    backgroundColor: transparent,
                                    child: DateRangeView()),
                              );
                              if (dateRange != null && dateRange.isNotEmpty) {
                                setState(() {
                                  dateRange = dateRange;
                                  viewModel.startDate =
                                      '${dateRange.first.month}/${dateRange.first.day}/${dateRange.first.year}';
                                  viewModel.endDate =
                                      '${dateRange.last.month}/${dateRange.last.day}/${dateRange.last.year}';
                                  viewModel.refresh();
                                });
                              }
                            },
                            child: Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                color: tuna,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Date Range',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        onCameraMove: (position) {
                          viewModel.customInfoWindowController.onCameraMove();
                          viewModel.manager!=null?viewModel.manager.onCameraMove(position):SizedBox();
                        },
                        onMapCreated: (GoogleMapController controller) async {
                          viewModel.customInfoWindowController
                              .googleMapController = controller;
                          _controller.complete(controller);
                          viewModel.manager!=null?viewModel.manager.setMapController(controller):SizedBox();
                        },
                        onCameraIdle:viewModel.manager!=null?viewModel. manager.updateMap:null,
                        mapType: _changemap(),
                        compassEnabled: true,
                        zoomControlsEnabled: false,
                        markers: viewModel.markers,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                viewModel.assetLocation.mapRecords.first
                                    .lastReportedLocationLatitude,
                                viewModel.assetLocation.mapRecords.first
                                    .lastReportedLocationLongitude),
                            zoom: 5),
                      ),
                      CustomInfoWindow(
                        controller: viewModel.customInfoWindowController,
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: MediaQuery.of(context).size.height * 0.36,
                        offset: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 28.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                zoomVal++;
                                _plus(
                                  zoomVal,
                                  LatLng(
                                      viewModel.assetLocation.mapRecords.first
                                          .lastReportedLocationLatitude,
                                      viewModel.assetLocation.mapRecords.first
                                          .lastReportedLocationLongitude),
                                );
                              },
                              child: Container(
                                width: 27.47,
                                height: 26.97,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 1.0,
                                      color: darkhighlight,
                                    ),
                                  ],
                                  border: Border.all(
                                      width: 1.0, color: darkhighlight),
                                  shape: BoxShape.rectangle,
                                ),
                                child: SvgPicture.asset(
                                  "assets/images/plus.svg",
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
                                        viewModel.assetLocation.mapRecords.first
                                            .lastReportedLocationLatitude,
                                        viewModel.assetLocation.mapRecords.first
                                            .lastReportedLocationLongitude),
                                  );
                                },
                                child: Container(
                                  width: 27.47,
                                  height: 26.97,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1.0,
                                        color: darkhighlight,
                                      ),
                                    ],
                                    border: Border.all(
                                        width: 1.0, color: darkhighlight),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/images/minus.svg",
                                  ),
                                )),
                          ],
                        ),
                      ),
                      viewModel.refreshing
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
      viewModelBuilder: () => LocationViewModel(TYPE.LOCATION),
    );
  }

  Future<void> _minus(double zoomVal, LatLng targetPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal, LatLng targetPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
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
