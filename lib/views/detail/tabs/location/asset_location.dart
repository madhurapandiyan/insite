import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/tabs/location/asset_location_view_model.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class AssetLocationView extends StatefulWidget {
  final AssetDetail detail;

  AssetLocationView({this.detail});

  @override
  _AssetLocationViewState createState() => _AssetLocationViewState();
}

class _AssetLocationViewState extends State<AssetLocationView> {
  String _currentSelectedItem = "MAP";
  double zoomVal = 5.0;
  Completer<GoogleMapController> _controller = Completer();
  MapType currentType = MapType.normal;

  List<DateTime> dateRange;

  GoogleMapController mapController;
  BitmapDescriptor mapMarker;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetLocationViewModel>.reactive(
      builder:
          (BuildContext context, AssetLocationViewModel viewModel, Widget _) {
        if (viewModel.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(4.0),
                width: double.infinity,
                height: 510,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [BoxShadow(blurRadius: 1.0, color: mediumgrey)],
                  border: Border.all(width: 2.5, color: cardcolor),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
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
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            (dateRange == null || dateRange.isEmpty)
                                ? '${Utils.parseDate(DateTime.now().subtract(Duration(days: DateTime.now().weekday)))} - ${Utils.parseDate(DateTime.now())}'
                                : '${Utils.parseDate(dateRange.first)} - ${Utils.parseDate(dateRange.last)}',
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
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
                                });
                                viewModel.refresh();
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
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          GoogleMap(
                            onTap: (position) {
                              viewModel.customInfoWindowController
                                  .hideInfoWindow();
                            },
                            onCameraMove: (position) {
                              viewModel.customInfoWindowController
                                  .onCameraMove();
                            },
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                              viewModel.customInfoWindowController
                                  .googleMapController = controller;
                            },
                            mapType: _changemap(),
                            compassEnabled: true,
                            zoomControlsEnabled: false,
                            markers: viewModel.markers,
                            initialCameraPosition:
                                viewModel.assetLocationHistory != null
                                    ? CameraPosition(
                                        target: LatLng(
                                            viewModel.assetLocationHistory
                                                .assetLocation[0].latitude,
                                            viewModel.assetLocationHistory
                                                .assetLocation[0].longitude),
                                        zoom: 18)
                                    : CameraPosition(
                                        target: LatLng(21.7679, 78.8718),
                                        zoom: 4),
                          ),
                          CustomInfoWindow(
                            controller: viewModel.customInfoWindowController,
                            height: 100,
                            width: 175,
                            offset: 50,
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
                                    if (viewModel.assetLocationHistory !=
                                        null) {
                                      zoomVal++;
                                      _plus(
                                        zoomVal,
                                        LatLng(
                                            viewModel.assetLocationHistory
                                                .assetLocation[0].latitude,
                                            viewModel.assetLocationHistory
                                                .assetLocation[0].longitude),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 27.47,
                                    height: 26.97,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
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
                                      if (viewModel.assetLocationHistory !=
                                          null) {
                                        zoomVal--;
                                        _minus(
                                          zoomVal,
                                          LatLng(
                                              viewModel.assetLocationHistory
                                                  .assetLocation[0].latitude,
                                              viewModel.assetLocationHistory
                                                  .assetLocation[0].longitude),
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 27.47,
                                      height: 26.97,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
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
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
      viewModelBuilder: () => AssetLocationViewModel(widget.detail),
    );
  }

  Future<void> _minus(double zoomVal, LatLng targetPosition) async {
    Logger().d("zoom minus value " + zoomVal.toString());
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal, LatLng targetPosition) async {
    Logger().d("zoom plus value " + zoomVal.toString());
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
