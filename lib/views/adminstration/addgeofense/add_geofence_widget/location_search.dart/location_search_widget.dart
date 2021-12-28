import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/location/location_search_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';

class LocationSearchView extends StatefulWidget {
  final Function(List<FilterData>)? onApply;
  final Function(String?, String?)? getLatLong;
  LocationSearchView({this.onApply, this.getLatLong});
  @override
  _LocationSearchViewState createState() => _LocationSearchViewState();
}

class _LocationSearchViewState extends State<LocationSearchView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (BuildContext context, LocationSearchViewModel viewModel, _) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Theme.of(context).backgroundColor,
                border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1!.color!)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBox(
                    controller: viewModel.textEditingController,
                    hint: "Search",
                    onTextChanged: viewModel.onSearchTextChanged,
                  ),
                ),
                viewModel.filterLocations
                            .where((element) => element.isSelected!)
                            .length >
                        0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InsiteRichText(
                              title: "",
                              content: "CLEAR FILTERS",
                              onTap: () {
                                Logger().d("clear filter");
                                viewModel.clearFilter();
                                // widget.onClear();
                              },
                            ),
                            InsiteButton(
                              onTap: () {
                                widget.onApply!(viewModel.filterLocations
                                    .where((element) => element.isSelected!)
                                    .toList());
                              },
                              textColor: Colors.white,
                              width: 100,
                              height: 40,
                              title: "APPLY",
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 8,
                ),
                viewModel.loading
                    ? InsiteProgressBar()
                    : viewModel.filterLocations.isNotEmpty
                        ? viewModel.textEditingController.text.isNotEmpty
                            ? Expanded(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    itemCount: viewModel.filterLocations.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      FilterData data =
                                          viewModel.filterLocations[index];
                                      return GestureDetector(
                                        onTap: () {
                                          viewModel.filterLocations[index]
                                              .isSelected = !data.isSelected!;
                                          widget.getLatLong!(
                                              data.extras![0], data.extras![1]);
                                          setState(() {});
                                        },
                                        child: Container(
                                          color: data.isSelected!
                                              ? Theme.of(context).buttonColor
                                              : Theme.of(context)
                                                  .backgroundColor,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InsiteText(
                                                  text: data.count!.isNotEmpty
                                                      ? "(${data.count}) "
                                                      : "",
                                                  color: data.isSelected!
                                                      ? white
                                                      : null,
                                                  fontWeight: FontWeight.bold,
                                                  size: 16),
                                              Expanded(
                                                child: InsiteText(
                                                    text: data.title,
                                                    color: data.isSelected!
                                                        ? white
                                                        : null,
                                                    fontWeight: FontWeight.bold,
                                                    size: 16),
                                              ),
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {})
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No Results",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No Results",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
              ],
            ),
          );
        },
        viewModelBuilder: () => LocationSearchViewModel(ScreenType.SEARCH));
  }
}
