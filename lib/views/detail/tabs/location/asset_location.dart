import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/detail/tabs/location/asset_location_view_model.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/views/location/location_search_box/location_search_box_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class AssetLocationView extends StatefulWidget {
  final AssetDetail? detail;
  final ScreenType? screenType;
  AssetLocationView({this.detail, this.screenType = ScreenType.FLEET});

  @override
  _AssetLocationViewState createState() => _AssetLocationViewState();
}

class _AssetLocationViewState extends State<AssetLocationView> {
  String _currentSelectedItem = "HYBRID";
  double zoomVal = 5.0;
  double? latitude;
  double? longitude;
  Location currentLocation = Location();

  MapType currentType = MapType.normal;
  List<DateTime>? dateRange;
  //late GoogleMapController mapController;
  BitmapDescriptor? mapMarker;
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
    var mediaQuerry = MediaQuery.of(context);
    return ViewModelBuilder<AssetLocationViewModel>.reactive(
      builder:
          (BuildContext context, AssetLocationViewModel viewModel, Widget? _) {
        if (viewModel.loading) {
          return InsiteProgressBar();
        } else {
          return Container(
            // height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  width: 1,
                  color: Theme.of(context).textTheme.bodyText1!.color!),
              shape: BoxShape.rectangle,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InsiteButton(
                        title: "Refresh",
                        width: 90,
                        height: 30,
                        //bgColor: Theme.of(context).backgroundColor,
                        textColor: Theme.of(context).textTheme.bodyText1!.color,
                        onTap: () async {
                          viewModel
                              .customInfoWindowController.hideInfoWindow!();
                          if (widget.screenType == ScreenType.HEALTH) {
                            viewModel.refreshForAssetView();
                          } else {
                            viewModel.refresh();
                          }
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      // InsiteText(
                      //     text: Utils.getDateInFormatddMMyyyy(
                      //             viewModel.startDate) +
                      //         " - " +
                      //         Utils.getDateInFormatddMMyyyy(
                      //             viewModel.endDate),
                      //     fontWeight: FontWeight.bold,
                      //     size: 12),
                      InsiteButton(
                        title: Utils.getDateFormatForDatePicker(
                                viewModel.startDate,viewModel.userPref) +
                            " - " +
                            Utils.getDateFormatForDatePicker(viewModel.endDate,viewModel.userPref),
                        // width: 90,
                        //bgColor: Theme.of(context).backgroundColor,
                        textColor: Theme.of(context).textTheme.bodyText1!.color,
                        onTap: () async {
                          dateRange = await showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                backgroundColor: transparent,
                                child: DateRangeView()),
                          );
                          if (dateRange != null && dateRange!.isNotEmpty) {
                            setState(() {
                              dateRange = dateRange;
                            });
                            viewModel
                                .customInfoWindowController.hideInfoWindow!();
                            viewModel.refresh();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                viewModel.dataNotFound
                    ? Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: EmptyView(
                          title: "No Data Found",
                        ),
                      )
                    : Expanded(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            GoogleMap(
                                mapToolbarEnabled: false,
                                onTap: (position) {
                                  viewModel.customInfoWindowController
                                      .hideInfoWindow!();
                                },
                                onCameraMove: (position) {
                                  viewModel.customInfoWindowController
                                      .onCameraMove!();
                                },
                                onMapCreated: (GoogleMapController controller) {
                                  // mapController = controller;
                                  viewModel.controller = controller;
                                  viewModel.mapcontroller.complete(controller);
                                  viewModel.customInfoWindowController
                                      .googleMapController = controller;
                                  Future.delayed(Duration(seconds: 1), () {
                                    viewModel.controller!.animateCamera(
                                        CameraUpdate.newLatLngBounds(
                                            viewModel.getBound(), 0));
                                  });
                                },
                                mapType: _changemap(),
                                compassEnabled: true,
                                zoomControlsEnabled: false,
                                markers: viewModel.markers,
                                polylines: viewModel.polyline,
                                initialCameraPosition:
                                    viewModel.assetLocationHistory != null &&
                                            viewModel.assetLocationHistory!
                                                .assetLocation!.isNotEmpty
                                        ? CameraPosition(
                                            target: LatLng(
                                                viewModel
                                                    .assetLocationHistory!
                                                    .assetLocation![0]
                                                    .latitude!,
                                                viewModel
                                                    .assetLocationHistory!
                                                    .assetLocation![0]
                                                    .longitude!),
                                            zoom: 5)
                                        : viewModel.centerPosition != null
                                            ? CameraPosition(
                                                target: LatLng(
                                                viewModel.centerPosition!.target
                                                    .latitude,
                                                viewModel.centerPosition!.target
                                                    .latitude,
                                              ))
                                            : CameraPosition(
                                                target: LatLng(30.666, 76.8127),
                                                zoom: 4)),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 9, left: 15),
                                child: LocationSearchBoxView(
                                  screenType: ScreenType.ASSET_DETAIL,
                                  searchBoxWidth: 0.6,
                                  onSeletingSuggestion: (value, isSerialNo) {
                                    viewModel.customInfoWindowController
                                        .hideInfoWindow!();
                                    if (isSerialNo) {
                                    } else {
                                      viewModel.onSeletingSuggestion(value);
                                    }
                                  },
                                ),
                              ),
                            ),
                            CustomInfoWindow(
                              controller: viewModel.customInfoWindowController,
                              height: widget.screenType == ScreenType.HEALTH
                                  ? 240
                                  : 160,
                              width: 200,
                              offset: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 100,
                                    height: mediaQuerry.size.height * 0.065,
                                    margin: EdgeInsets.only(left: 20, top: 10),
                                    decoration: BoxDecoration(
                                        // border: Border.all(
                                        //     width: 1,
                                        //     color: Theme.of(context).buttonColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color:
                                            Theme.of(context).backgroundColor),
                                    child: CustomDropDownWidget(
                                      items: [
                                        "SATELLITE",
                                        "MAP",
                                        "TERRAIN",
                                        "HYBRID"
                                      ],
                                      value: _currentSelectedItem,
                                      onChanged: (value) {
                                        _currentSelectedItem = value!;
                                        _changemap();
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      AppConfig.instance!.productFlavor ==
                                                  "worksiq" ||
                                              AppConfig.instance!
                                                      .productFlavor ==
                                                  "cummins"
                                          ? SizedBox()
                                          : Align(
                                              alignment: Alignment.centerRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                 viewModel.zoomToCurrentLocation();
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10, bottom: 10),
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .backgroundColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                  ),
                                                  child: Icon(
                                                    Icons.gps_fixed_outlined,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (viewModel
                                                    .assetLocationHistory !=
                                                null) {
                                              zoomVal++;
                                              _plus(
                                                  zoomVal,
                                                  LatLng(
                                                      viewModel
                                                          .assetLocationHistory!
                                                          .assetLocation![0]
                                                          .latitude!,
                                                      viewModel
                                                          .assetLocationHistory!
                                                          .assetLocation![0]
                                                          .longitude!),
                                                  viewModel);
                                            }
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
                                                    .color!,
                                              ),
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
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                            onTap: () {
                                              if (viewModel
                                                      .assetLocationHistory !=
                                                  null) {
                                                zoomVal--;
                                                _minus(
                                                    zoomVal,
                                                    LatLng(
                                                        viewModel
                                                            .assetLocationHistory!
                                                            .assetLocation![0]
                                                            .latitude!,
                                                        viewModel
                                                            .assetLocationHistory!
                                                            .assetLocation![0]
                                                            .longitude!),
                                                    viewModel);
                                              }
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
                                                      .color!,
                                                ),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: SvgPicture.asset(
                                                "assets/images/minus.svg",
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.only(left: 16.0),
                            //   child: DropdownButton(
                            //     dropdownColor: Theme.of(context).backgroundColor,
                            //     icon: Padding(
                            //       padding: EdgeInsets.only(right: 8.0),
                            //       child: Container(
                            //         child: SvgPicture.asset(
                            //           "assets/images/arrowdown.svg",
                            //           width: 10,
                            //           color: Theme.of(context).iconTheme.color,
                            //           height: 10,
                            //         ),
                            //       ),
                            //     ),
                            //     isExpanded: false,
                            //     hint: Text(
                            //       _currentSelectedItem,
                            //       style: TextStyle(
                            //           color: Theme.of(context)
                            //               .textTheme
                            //               .bodyText1
                            //               .color),
                            //     ),
                            //     items: ['MAP', 'TERRAIN', 'SATELLITE', 'HYBRID']
                            //         .map((map) => DropdownMenuItem(
                            //               value: map,
                            //               child: InsiteText(
                            //                 text: map,
                            //                 size: 11.0,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ))
                            //         .toList(),
                            //     value: _currentSelectedItem,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         _currentSelectedItem = value;
                            //       });
                            //     },
                            //     underline: Container(
                            //         height: 1.0,
                            //         decoration: BoxDecoration(
                            //             border: Border(
                            //                 bottom: BorderSide(
                            //                     color: Colors.transparent,
                            //                     width: 0.0)))),
                            //   ),
                            // ),
                            viewModel.refreshing
                                ? InsiteProgressBar()
                                : SizedBox()
                          ],
                        ),
                      )
              ],
            ),
          );
        }
      },
      viewModelBuilder: () =>
          AssetLocationViewModel(widget.detail, widget.screenType),
    );
  }

  Future<void> _minus(double zoomVal, LatLng targetPosition,
      AssetLocationViewModel assetLocationViewModel) async {
    Logger().d("zoom minus value " + zoomVal.toString());
    final GoogleMapController controller = assetLocationViewModel.controller!;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal, LatLng targetPosition,
      AssetLocationViewModel assetLocationViewModel) async {
    Logger().d("zoom plus value " + zoomVal.toString());
    final GoogleMapController controller = assetLocationViewModel.controller!;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
  }

 

  MapType _changemap() {
    switch (_currentSelectedItem) {
      case "MAP":
        Logger().i("map is in normal type ");
        return MapType.normal;

      case "TERRAIN":
        Logger().i("map is in terrain type");

        return MapType.terrain;

      case "SATELLITE":
        Logger().i("map is in satellite type ");
        return MapType.satellite;

      case "HYBRID":
        Logger().i("map is in hybrid type ");
        return MapType.hybrid;

      default:
        return MapType.normal;
    }
  }
}
