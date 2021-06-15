import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/filter/filter_item.dart';
import 'package:insite/views/filter/filter_view_model.dart';
import 'package:insite/views/location/location_search_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:stacked/stacked.dart';
import 'filter_chip_view.dart';

class FilterView extends StatefulWidget {
  final VoidCallback onFilterApplied;
  FilterView({this.onFilterApplied});

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (BuildContext context, FilterViewModel viewModel, Widget _) {
        return viewModel.loading
            ? Container(
                height: MediaQuery.of(context).size.height * 0.8,
                color: tuna,
                child: Center(child: CircularProgressIndicator()))
            : Container(
                child: SingleChildScrollView(
                  child: Container(
                    color: tuna,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        viewModel.appliedFilters.isNotEmpty
                            ? FilterChipView(
                                filters: viewModel.appliedFilters,
                              )
                            : SizedBox(),
                        viewModel.appliedFilters.isNotEmpty
                            ? SizedBox(
                                height: 8,
                              )
                            : SizedBox(),
                        viewModel.appliedFilters.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InsiteButton(
                                    bgColor: tango,
                                    textColor: ship_grey,
                                    onTap: () {
                                      widget.onFilterApplied();
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
                                    bgColor: Colors.white,
                                    textColor: ship_grey,
                                    onTap: () {
                                      widget.onFilterApplied();
                                    },
                                    width: 100,
                                    height: 40,
                                    title: "CANCEL",
                                  ),
                                ],
                              )
                            : SizedBox(),
                        viewModel.appliedFilters.isNotEmpty
                            ? SizedBox(
                                height: 8,
                              )
                            : SizedBox(),
                        FilterItem(
                          filterType: FilterType.ALL_ASSETS,
                          data: viewModel.filterDataAllAssets,
                          onApply: (List<FilterData> list) {
                            viewModel.onFilterSelected(
                                list, FilterType.ALL_ASSETS);
                          },
                          onClear: () {
                            viewModel.onFilterCleared(FilterType.ALL_ASSETS);
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FilterItem(
                          filterType: FilterType.PRODUCT_FAMILY,
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
                          data: viewModel.filterDataMake,
                          onApply: (List<FilterData> list) {
                            viewModel.onFilterSelected(list, FilterType.MAKE);
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
                          data: viewModel.filterDataModel,
                          onApply: (List<FilterData> list) {
                            viewModel.onFilterSelected(list, FilterType.MODEL);
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
                          data: viewModel.filterDataModelYear,
                          onApply: (List<FilterData> list) {
                            viewModel.onFilterSelected(
                                list, FilterType.MODEL_YEAR);
                          },
                          onClear: () {
                            viewModel.onFilterCleared(FilterType.MODEL_YEAR);
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
                            viewModel
                                .onFilterCleared(FilterType.LOCATION_SEARCH);
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FilterItem(
                          filterType: FilterType.APPLICATION,
                          data: [],
                          onApply: (List<FilterData> list) {
                            viewModel.onFilterSelected(
                                list, FilterType.APPLICATION);
                          },
                          onClear: () {
                            viewModel.onFilterCleared(FilterType.APPLICATION);
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FilterItem(
                          filterType: FilterType.ASSET_COMMISION_DATE,
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
                          data: viewModel.filterDataSubscription,
                          onApply: (List<FilterData> list) {
                            viewModel.onFilterSelected(
                                list, FilterType.SUBSCRIPTION_DATE);
                          },
                          onClear: () {
                            viewModel
                                .onFilterCleared(FilterType.SUBSCRIPTION_DATE);
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FilterItem(
                          filterType: FilterType.DEVICE_TYPE,
                          data: viewModel.filterDataDeviceType,
                          onApply: (List<FilterData> list) {
                            viewModel.onFilterSelected(
                                list, FilterType.DEVICE_TYPE);
                          },
                          onClear: () {
                            viewModel.onFilterCleared(FilterType.DEVICE_TYPE);
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FilterItem(
                          filterType: FilterType.FUEL_LEVEL,
                          data: viewModel.filterDataFuelLevel,
                          onApply: (List<FilterData> list) {
                            viewModel.onFilterSelected(
                                list, FilterType.FUEL_LEVEL);
                          },
                          onClear: () {
                            viewModel.onFilterCleared(FilterType.FUEL_LEVEL);
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FilterItem(
                          filterType: FilterType.IDLING_LEVEL,
                          data: viewModel.filterDataIdlingLevel,
                          onApply: (List<FilterData> list) {
                            viewModel.onFilterSelected(
                                list, FilterType.IDLING_LEVEL);
                          },
                          onClear: () {
                            viewModel.onFilterCleared(FilterType.IDLING_LEVEL);
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
      viewModelBuilder: () => FilterViewModel(),
    );
  }
}
