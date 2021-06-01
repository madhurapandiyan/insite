import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/filter/filter_item.dart';
import 'package:insite/views/filter/filter_view_model.dart';
import 'package:stacked/stacked.dart';

class FilterView extends StatefulWidget {
  FilterView({Key key}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (BuildContext context, FilterViewModel viewModel, Widget _) {
        return Container(
          child: SingleChildScrollView(
            child: Container(
              color: tuna,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  FilterItem(
                    filterType: FilterType.ALL_ASSETS,
                    data: [],
                    onApply: () {},
                    onClear: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItem(
                    filterType: FilterType.PRODUCT_FAMILY,
                    data: [],
                    onApply: () {},
                    onClear: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItem(
                    filterType: FilterType.MAKE,
                    data: [],
                    onApply: () {},
                    onClear: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItem(
                    filterType: FilterType.MODEL,
                    data: [],
                    onApply: () {},
                    onClear: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItem(
                    filterType: FilterType.MODEL_YEAR,
                    data: [],
                    onApply: () {},
                    onClear: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItem(
                    filterType: FilterType.LOCATION_SEARCH,
                    data: [],
                    onApply: () {},
                    onClear: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItem(
                    filterType: FilterType.APPLICATION,
                    data: [],
                    onApply: () {},
                    onClear: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItem(
                    filterType: FilterType.ASSET_COMMISION_DATE,
                    data: [],
                    onApply: () {},
                    onClear: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItem(
                    filterType: FilterType.SUBSCRIPTION_DATE,
                    data: [],
                    onApply: () {},
                    onClear: () {},
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItem(
                    filterType: FilterType.DEVICE_TYPE,
                    data: [],
                    onApply: () {},
                    onClear: () {},
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
