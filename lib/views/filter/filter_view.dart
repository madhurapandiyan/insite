import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/filter/filter_item.dart';
import 'package:insite/views/filter/filter_view_model.dart';
import 'package:insite/views/location/location_search_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:stacked/stacked.dart';
import 'filter_chip_view.dart';

class FilterView extends StatefulWidget {
  final Function(bool)? onFilterApplied;
  final ScreenType? screenType;
  FilterView({this.onFilterApplied, this.screenType});

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  final GlobalKey<FilterItemState> filterAssetStatusKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterProductFamilyKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterMakeKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterModelKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterManufacturerKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterModelYearKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterApplicationKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterAssetCommisionDateKey =
      new GlobalKey();
  final GlobalKey<FilterItemState> filterSubscriptionTypesKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterDeviceTypeKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterFuelLevelKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterIdlingLevelKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterSeverityKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterJobTypeKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterUserTypeKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterFrequencyTypeKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterFormatTypeKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterReportTypeKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterServiceStatusTypeKey = new GlobalKey();

  deSelect(FilterData data) {
    if (data.type == FilterType.ALL_ASSETS) {
      filterAssetStatusKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.PRODUCT_FAMILY) {
      filterProductFamilyKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.MAKE) {
      filterMakeKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.MODEL) {
      filterModelKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.MODEL_YEAR) {
      filterModelYearKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.APPLICATION) {
      filterApplicationKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.ASSET_COMMISION_DATE) {
      filterAssetCommisionDateKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.SUBSCRIPTION_DATE) {
      filterSubscriptionTypesKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.DEVICE_TYPE) {
      filterDeviceTypeKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.FUEL_LEVEL) {
      filterFuelLevelKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.IDLING_LEVEL) {
      filterIdlingLevelKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.SEVERITY) {
      filterSeverityKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.JOBTYPE) {
      filterJobTypeKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.USERTYPE) {
      filterUserTypeKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.FREQUENCYTYPE) {
      filterFrequencyTypeKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.REPORT_FORMAT) {
      filterFormatTypeKey.currentState!.deSelectFromOutSide(data);
    } else if (data.type == FilterType.REPORT_TYPE) {
      filterReportTypeKey.currentState!.deSelectFromOutSide(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (BuildContext context, FilterViewModel viewModel, Widget? _) {
        return viewModel.loading
            ? Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border.all(
                        color: Theme.of(context).textTheme.bodyText1!.color!)),
                child: InsiteProgressBar())
            : Stack(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            viewModel.selectedFilterData!.isNotEmpty
                                ? FilterChipView(
                                    filters: viewModel.selectedFilterData,
                                    onClosed: (value) {
                                      viewModel.removeSelectedFilter(value);
                                      deSelect(value);
                                    },
                                    backgroundColor: chipBackgroundTwo,
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                  )
                                : SizedBox(),
                            viewModel.selectedFilterData!.isNotEmpty
                                ? SizedBox(
                                    height: 8,
                                  )
                                : SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InsiteButton(
                                  textColor: Colors.white,
                                  onTap: () {
                                    viewModel.onFilterApplied();
                                    Future.delayed(Duration(seconds: 2), () {
                                      widget.onFilterApplied!(true);
                                    });
                                  },
                                  width: 100,
                                  height: 40,
                                  title: "APPLY",
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                ),
                                InsiteButton(
                                  bgColor: Theme.of(context).backgroundColor,
                                  onTap: () {
                                    widget.onFilterApplied!(false);
                                  },
                                  width: 100,
                                  height: 40,
                                  title: "CANCEL",
                                ),
                              ],
                            ),
                            viewModel.selectedFilterData!.isNotEmpty
                                ? SizedBox(
                                    height: 8,
                                  )
                                : SizedBox(),
                            widget.screenType != ScreenType.USER_MANAGEMENT &&
                                    widget.screenType !=
                                        ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.ALL_ASSETS,
                                    key: filterAssetStatusKey,
                                    data: viewModel.filterDataAllAssets,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.ALL_ASSETS);
                                    },
                                    onClear: () {
                                      viewModel.onFilterCleared(
                                          FilterType.ALL_ASSETS);
                                    },
                                  )
                                : SizedBox(),

                            widget.screenType != ScreenType.USER_MANAGEMENT &&
                                    widget.screenType !=
                                        ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.PRODUCT_FAMILY,
                                    key: filterProductFamilyKey,
                                    data: viewModel.filterDataProductFamily,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.PRODUCT_FAMILY);
                                    },
                                    onClear: () {
                                      viewModel.onFilterCleared(
                                          FilterType.PRODUCT_FAMILY);
                                    },
                                  )
                                : SizedBox(),

                            // widget.screenType != ScreenType.USER_MANAGEMENT &&
                            //         widget.screenType !=
                            //             ScreenType.MANAGE_REPORT
                            //     // widget.screenType != ScreenType.FLEET &&
                            //     // widget.screenType !=
                            //     //     ScreenType.UTILIZATION &&
                            //     // widget.screenType !=
                            //     //     ScreenType.ASSET_OPERATION &&
                            //     // widget.screenType != ScreenType.LOCATION &&
                            //     // widget.screenType != ScreenType.HEALTH
                            //     ? FilterItem(
                            //         isExpand: viewModel.isShowing,
                            //         filterType: FilterType.MAKE,
                            //         key: filterMakeKey,
                            //         data: viewModel.filterDataMake,
                            //         onApply: (List<FilterData> list) {
                            //           viewModel.onFilterSelected(
                            //               list, FilterType.MAKE);
                            //         },
                            //         onClear: () {
                            //           viewModel
                            //               .onFilterCleared(FilterType.MAKE);
                            //         },
                            //       )
                            //     : SizedBox(),

                            widget.screenType != ScreenType.USER_MANAGEMENT &&
                                    widget.screenType !=
                                        ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.MODEL,
                                    key: filterModelKey,
                                    data: viewModel.filterDataModel,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.MODEL);
                                    },
                                    onClear: () {
                                      viewModel
                                          .onFilterCleared(FilterType.MODEL);
                                    },
                                  )
                                : SizedBox(),

                            // FilterItem(
                            //   filterType: FilterType.MODEL_YEAR,
                            //   key: filterModelYearKey,
                            //   data: viewModel.filterDataModelYear,
                            //   onApply: (List<FilterData> list) {
                            //     viewModel.onFilterSelected(
                            //         list, FilterType.MODEL_YEAR);
                            //   },
                            //   onClear: () {
                            //     viewModel
                            //         .onFilterCleared(FilterType.MODEL_YEAR);
                            //   },
                            // ), widget.screenType != ScreenType.USER_MANAGEMENT &&
                            widget.screenType != ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.MANUFACTURER,
                                    key: filterManufacturerKey,
                                    data: viewModel.filterDataManufacturer,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.MANUFACTURER);
                                    },
                                    onClear: () {
                                      viewModel.onFilterCleared(
                                          FilterType.MANUFACTURER);
                                    },
                                  )
                                : SizedBox(),
                            // widget.screenType != ScreenType.USER_MANAGEMENT &&
                            //         widget.screenType !=
                            //             ScreenType.MANAGE_REPORT
                            //     // widget.screenType != ScreenType.FLEET &&
                            //     // widget.screenType !=
                            //     //     ScreenType.UTILIZATION &&
                            //     // widget.screenType !=
                            //     //     ScreenType.ASSET_OPERATION &&

                            //     // widget.screenType != ScreenType.HEALTH
                            //     ? LocationSearch(
                            //         filterType: FilterType.LOCATION_SEARCH,
                            //         data: [],
                            //         onApply: (List<FilterData> list) {
                            //           viewModel.onFilterSelected(
                            //               list, FilterType.LOCATION_SEARCH);
                            //         },
                            //         onClear: () {
                            //           viewModel.onFilterCleared(
                            //               FilterType.LOCATION_SEARCH);
                            //         },
                            //       )
                            //     : SizedBox(),

                            // FilterItem(
                            //   filterType: FilterType.APPLICATION,
                            //   key: filterApplicationKey,
                            //   data: [],
                            //   onApply: (List<FilterData> list) {
                            //     viewModel.onFilterSelected(
                            //         list, FilterType.APPLICATION);
                            //   },
                            //   onClear: () {
                            //     viewModel
                            //         .onFilterCleared(FilterType.APPLICATION);
                            //   },
                            // ),

                            // widget.screenType != ScreenType.USER_MANAGEMENT &&
                            //         widget.screenType !=
                            //             ScreenType.MANAGE_REPORT
                            //     //  widget.screenType != ScreenType.FLEET &&
                            //     //   widget.screenType !=
                            //     //       ScreenType.UTILIZATION &&
                            //     //   widget.screenType !=
                            //     //       ScreenType.ASSET_OPERATION &&
                            //     //   widget.screenType != ScreenType.HEALTH&&
                            //     //   widget.screenType!=ScreenType.LOCATION
                            //     ? FilterItem(
                            //         isExpand: viewModel.isShowing,
                            //         filterType: FilterType.ASSET_COMMISION_DATE,
                            //         key: filterAssetCommisionDateKey,
                            //         data: [],
                            //         onApply: (List<FilterData> list) {
                            //           viewModel.onFilterSelected(list,
                            //               FilterType.ASSET_COMMISION_DATE);
                            //         },
                            //         onClear: () {
                            //           viewModel.onFilterCleared(
                            //               FilterType.ASSET_COMMISION_DATE);
                            //         },
                            //       )
                            //     : SizedBox(),

                            // widget.screenType != ScreenType.USER_MANAGEMENT &&
                            //         widget.screenType !=
                            //             ScreenType.MANAGE_REPORT
                            //     //  widget.screenType != ScreenType.FLEET &&
                            //     //   widget.screenType !=
                            //     //       ScreenType.UTILIZATION &&
                            //     //   widget.screenType !=
                            //     //       ScreenType.ASSET_OPERATION &&
                            //     //   widget.screenType != ScreenType.HEALTH &&
                            //     //   widget.screenType != ScreenType.LOCATION
                            //     ? FilterItem(
                            //         isExpand: viewModel.isShowing,
                            //         filterType: FilterType.SUBSCRIPTION_DATE,
                            //         key: filterSubscriptionTypesKey,
                            //         data: viewModel.filterDataSubscription,
                            //         onApply: (List<FilterData> list) {
                            //           viewModel.onFilterSelected(
                            //               list, FilterType.SUBSCRIPTION_DATE);
                            //         },
                            //         onClear: () {
                            //           viewModel.onFilterCleared(
                            //               FilterType.SUBSCRIPTION_DATE);
                            //         },
                            //       )
                            //     : SizedBox(),

                            widget.screenType != ScreenType.USER_MANAGEMENT &&
                                    widget.screenType !=
                                        ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.DEVICE_TYPE,
                                    key: filterDeviceTypeKey,
                                    data: viewModel.filterDataDeviceType,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.DEVICE_TYPE);
                                    },
                                    onClear: () {
                                      viewModel.onFilterCleared(
                                          FilterType.DEVICE_TYPE);
                                    },
                                  )
                                : SizedBox(),

                            widget.screenType != ScreenType.USER_MANAGEMENT &&
                                    widget.screenType !=
                                        ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.FUEL_LEVEL,
                                    key: filterFuelLevelKey,
                                    data: viewModel.filterDataFuelLevel,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.FUEL_LEVEL);
                                    },
                                    isSingleSelection: true,
                                    onClear: () {
                                      viewModel.onFilterCleared(
                                          FilterType.FUEL_LEVEL);
                                    },
                                  )
                                : SizedBox(),

                            widget.screenType != ScreenType.USER_MANAGEMENT &&
                                    widget.screenType !=
                                        ScreenType.MANAGE_REPORT
                                // widget.screenType != ScreenType.FLEET&&
                                //  widget.screenType !=
                                //     ScreenType.UTILIZATION &&
                                // widget.screenType !=
                                //     ScreenType.ASSET_OPERATION &&
                                // widget.screenType != ScreenType.HEALTH &&
                                // widget.screenType != ScreenType.LOCATION

                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.IDLING_LEVEL,
                                    key: filterIdlingLevelKey,
                                    data: viewModel.filterDataIdlingLevel,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.IDLING_LEVEL);
                                    },
                                    isSingleSelection: true,
                                    onClear: () {
                                      viewModel.onFilterCleared(
                                          FilterType.IDLING_LEVEL);
                                    },
                                  )
                                : SizedBox(),

                            widget.screenType == ScreenType.HEALTH &&
                                    widget.screenType !=
                                        ScreenType.USER_MANAGEMENT &&
                                    widget.screenType !=
                                        ScreenType.MANAGE_REPORT &&
                                    widget.screenType != ScreenType.FLEET
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.SEVERITY,
                                    key: filterSeverityKey,
                                    data: viewModel.filterSeverity,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.SEVERITY);
                                    },
                                    isSingleSelection: true,
                                    onClear: () {
                                      viewModel
                                          .onFilterCleared(FilterType.SEVERITY);
                                    },
                                  )
                                : SizedBox(),
                            widget.screenType == ScreenType.USER_MANAGEMENT &&
                                    widget.screenType !=
                                        ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.JOBTYPE,
                                    key: filterJobTypeKey,
                                    data: viewModel.filterDataJobType,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.JOBTYPE);
                                    },
                                    isSingleSelection: true,
                                    onClear: () {
                                      viewModel
                                          .onFilterCleared(FilterType.JOBTYPE);
                                    },
                                  )
                                : SizedBox(),
                            widget.screenType == ScreenType.USER_MANAGEMENT &&
                                    widget.screenType !=
                                        ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.USERTYPE,
                                    key: filterUserTypeKey,
                                    data: viewModel.filterDataUserType,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.USERTYPE);
                                    },
                                    isSingleSelection: true,
                                    onClear: () {
                                      viewModel
                                          .onFilterCleared(FilterType.USERTYPE);
                                    },
                                  )
                                : SizedBox(),

                            widget.screenType == ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.FREQUENCYTYPE,
                                    key: filterFrequencyTypeKey,
                                    data: viewModel.filterFrequencyType,
                                    isSingleSelection: true,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.FREQUENCYTYPE);
                                    },
                                    onClear: () {
                                      viewModel.onFilterCleared(
                                          FilterType.FREQUENCYTYPE);
                                    },
                                  )
                                : SizedBox(),

                            widget.screenType == ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.REPORT_FORMAT,
                                    key: filterFormatTypeKey,
                                    data: viewModel.filterFormatType,
                                    isSingleSelection: true,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.REPORT_FORMAT);
                                    },
                                    onClear: () {
                                      viewModel.onFilterCleared(
                                          FilterType.REPORT_FORMAT);
                                    },
                                  )
                                : SizedBox(),

                            widget.screenType == ScreenType.MANAGE_REPORT
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.REPORT_TYPE,
                                    key: filterReportTypeKey,
                                    data: viewModel.filterReportType,
                                    isSingleSelection: true,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.REPORT_TYPE);
                                    },
                                    onClear: () {
                                      viewModel.onFilterCleared(
                                          FilterType.REPORT_TYPE);
                                    },
                                  )
                                : SizedBox(),

                            widget.screenType == ScreenType.MAINTENANCE
                                ? FilterItem(
                                    isExpand: viewModel.isShowing,
                                    filterType: FilterType.SERVICE_TYPE,
                                    key: filterServiceStatusTypeKey,
                                    data: viewModel.serviceTypeReportType,
                                    isSingleSelection: true,
                                    onApply: (List<FilterData> list) {
                                      viewModel.onFilterSelected(
                                          list, FilterType.SERVICE_TYPE);
                                    },
                                    onClear: () {
                                      viewModel.onFilterCleared(
                                          FilterType.SERVICE_TYPE);
                                    },
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  viewModel.isRefreshing ? InsiteProgressBar() : SizedBox()
                ],
              );
      },
      viewModelBuilder: () => FilterViewModel(true, widget.screenType),
    );
  }
}
