import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/location/location_search_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/views/location/location_view_model.dart';

class LocationSearch extends StatefulWidget {
  final List<FilterData> data;
  final FilterType filterType;
  final Function(List<FilterData>) onApply;
  final Function onClear;
  LocationSearch({this.data, this.onApply, this.onClear, this.filterType});

  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationSearchViewModel>.reactive(
      builder: (context, viewModel, _) {
        return ExpansionTile(
          title: Text(
            Utils.getTitle(widget.filterType),
            style: TextStyle(color: Colors.white),
          ),
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: bgcolor,
              ),
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
                              .where((element) => element.isSelected)
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
                                textColor: Colors.white,
                                onTap: () {
                                  Logger().d("clear filter");
                                  viewModel.clearFilter();
                                  // widget.onClear();
                                },
                              ),
                              InsiteButton(
                                onTap: () {
                                  widget.onApply(viewModel.filterLocations
                                      .where((element) => element.isSelected)
                                      .toList());
                                },
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
                      ? CircularProgressIndicator()
                      : viewModel.filterLocations.isNotEmpty
                          ? ListView.builder(
                              itemCount: viewModel.filterLocations.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                FilterData data =
                                    viewModel.filterLocations[index];
                                return GestureDetector(
                                  onTap: () {
                                    viewModel.filterLocations[index]
                                        .isSelected = !data.isSelected;
                                    setState(() {});
                                  },
                                  child: Container(
                                    color: data.isSelected ? tango : bgcolor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.count.isNotEmpty
                                              ? "($data.count) "
                                              : "",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
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
            ),
          ],
        );
      },
      viewModelBuilder: () => LocationSearchViewModel(TYPE.SEARCH),
    );
  }
}
