import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/filter/filter_item.dart';
import 'package:insite/views/filter/filter_view_model.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/views/location/location_search_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:stacked/stacked.dart';
import 'filter_chip_view.dart';

class FilterView extends StatefulWidget {
  final Function(bool) onFilterApplied;
  final ScreenType screenType;
  FilterView({this.onFilterApplied, this.screenType});

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  final GlobalKey<FilterItemState> filterAssetStatusKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterProductFamilyKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterMakeKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterModelKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterModelYearKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterApplicationKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterAssetCommisionDateKey =
      new GlobalKey();
  final GlobalKey<FilterItemState> filterSubscriptionTypesKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterDeviceTypeKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterFuelLevelKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterIdlingLevelKey = new GlobalKey();
  final GlobalKey<FilterItemState> filterSeverityKey = new GlobalKey();

  deSelect(FilterData data) {
    if (data.type == FilterType.ALL_ASSETS) {
      filterAssetStatusKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.PRODUCT_FAMILY) {
      filterProductFamilyKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.MAKE) {
      filterMakeKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.MODEL) {
      filterModelKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.MODEL_YEAR) {
      filterModelYearKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.APPLICATION) {
      filterApplicationKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.ASSET_COMMISION_DATE) {
      filterAssetCommisionDateKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.SUBSCRIPTION_DATE) {
      filterSubscriptionTypesKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.DEVICE_TYPE) {
      filterDeviceTypeKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.FUEL_LEVEL) {
      filterFuelLevelKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.IDLING_LEVEL) {
      filterIdlingLevelKey.currentState.deSelectFromOutSide(data);
    } else if (data.type == FilterType.IDLING_LEVEL) {
      filterSeverityKey.currentState.deSelectFromOutSide(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (BuildContext context, FilterViewModel viewModel, Widget _) {
        return viewModel.loading
            ? Container(
                height: MediaQuery.of(context).size.height * 0.8,
                color: tuna,
                child: Center(child: CircularProgressIndicator()))
            : Stack(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Container(
                        color: tuna,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            viewModel.selectedFilterData.isNotEmpty
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
                            viewModel.selectedFilterData.isNotEmpty
                                ? SizedBox(
                                    height: 8,
                                  )
                                : SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InsiteButton(
                                  bgColor: tango,
                                  textColor: Colors.white,
                                  onTap: () {
                                    viewModel.onFilterApplied();
                                    Future.delayed(Duration(seconds: 2), () {
                                      widget.onFilterApplied(true);
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
                                  bgColor: ship_grey,
                                  textColor: Colors.white,
                                  onTap: () {
                                    widget.onFilterApplied(false);
                                  },
                                  width: 100,
                                  height: 40,
                                  title: "CANCEL",
                                ),
                              ],
                            ),
                            viewModel.selectedFilterData.isNotEmpty
                                ? SizedBox(
                                    height: 8,
                                  )
                                : SizedBox(),
                            FilterItem(
                              filterType: FilterType.ALL_ASSETS,
                              key: filterAssetStatusKey,
                              data: viewModel.filterDataAllAssets,
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.ALL_ASSETS);
                              },
                              onClear: () {
                                viewModel
                                    .onFilterCleared(FilterType.ALL_ASSETS);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FilterItem(
                              filterType: FilterType.PRODUCT_FAMILY,
                              key: filterProductFamilyKey,
                              data: viewModel.filterDataProductFamily,
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.PRODUCT_FAMILY);
                              },
                              onClear: () {
                                viewModel
                                    .onFilterCleared(FilterType.PRODUCT_FAMILY);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FilterItem(
                              filterType: FilterType.MAKE,
                              key: filterMakeKey,
                              data: viewModel.filterDataMake,
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.MAKE);
                              },
                              onClear: () {
                                viewModel.onFilterCleared(FilterType.MAKE);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FilterItem(
                              filterType: FilterType.MODEL,
                              key: filterModelKey,
                              data: viewModel.filterDataModel,
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.MODEL);
                              },
                              onClear: () {
                                viewModel.onFilterCleared(FilterType.MODEL);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FilterItem(
                              filterType: FilterType.MODEL_YEAR,
                              key: filterModelYearKey,
                              data: viewModel.filterDataModelYear,
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.MODEL_YEAR);
                              },
                              onClear: () {
                                viewModel
                                    .onFilterCleared(FilterType.MODEL_YEAR);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            LocationSearch(
                              filterType: FilterType.LOCATION_SEARCH,
                              data: [],
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.LOCATION_SEARCH);
                              },
                              onClear: () {
                                viewModel.onFilterCleared(
                                    FilterType.LOCATION_SEARCH);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FilterItem(
                              filterType: FilterType.APPLICATION,
                              key: filterApplicationKey,
                              data: [],
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.APPLICATION);
                              },
                              onClear: () {
                                viewModel
                                    .onFilterCleared(FilterType.APPLICATION);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FilterItem(
                              filterType: FilterType.ASSET_COMMISION_DATE,
                              key: filterAssetCommisionDateKey,
                              data: [],
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.ASSET_COMMISION_DATE);
                              },
                              onClear: () {
                                viewModel.onFilterCleared(
                                    FilterType.ASSET_COMMISION_DATE);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FilterItem(
                              filterType: FilterType.SUBSCRIPTION_DATE,
                              key: filterSubscriptionTypesKey,
                              data: viewModel.filterDataSubscription,
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.SUBSCRIPTION_DATE);
                              },
                              onClear: () {
                                viewModel.onFilterCleared(
                                    FilterType.SUBSCRIPTION_DATE);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FilterItem(
                              filterType: FilterType.DEVICE_TYPE,
                              key: filterDeviceTypeKey,
                              data: viewModel.filterDataDeviceType,
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.DEVICE_TYPE);
                              },
                              onClear: () {
                                viewModel
                                    .onFilterCleared(FilterType.DEVICE_TYPE);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FilterItem(
                              filterType: FilterType.FUEL_LEVEL,
                              key: filterFuelLevelKey,
                              data: viewModel.filterDataFuelLevel,
                              onApply: (List<FilterData> list) {
                                viewModel.onFilterSelected(
                                    list, FilterType.FUEL_LEVEL);
                              },
                              isSingleSelection: true,
                              onClear: () {
                                viewModel
                                    .onFilterCleared(FilterType.FUEL_LEVEL);
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            widget.screenType != ScreenType.HEALTH
                                ? FilterItem(
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
                            SizedBox(
                              height: 8,
                            ),
                            widget.screenType == ScreenType.HEALTH
                                ? FilterItem(
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
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  viewModel.isRefreshing
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox()
                ],
              );
      },
      viewModelBuilder: () => FilterViewModel(),
    );
  }
}
