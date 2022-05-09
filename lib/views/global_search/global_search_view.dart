import 'package:flutter/material.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:stacked/stacked.dart';
import 'global_search_view_model.dart';

class GlobalSearchView extends StatefulWidget {
  final Function(TopMatch)? onSelected;
  GlobalSearchView({this.onSelected});
  @override
  _GlobalSearchViewState createState() => _GlobalSearchViewState();
}

class _GlobalSearchViewState extends State<GlobalSearchView> {
  final searchController = TextEditingController();
  String? dropdownValue = 'All';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GlobalSearchViewModel>.reactive(
      builder:
          (BuildContext context, GlobalSearchViewModel viewModel, Widget? _) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border.all(
                  color: Theme.of(context).textTheme.bodyText1!.color!)),
          height: MediaQuery.of(context).size.height * 0.4,
          child: viewModel.loading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Center(
                    child: InsiteProgressBar(),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: TextFormField(
                          controller: searchController,
                          style: TextStyle(color: mediumgrey),
                          onChanged: (searchText) {
                            if (searchText.isNotEmpty) {
                              viewModel.searchKeyword = searchText;
                              viewModel.getSearchResult(dropdownValue);
                            } else {
                              viewModel.updateSearchDataToEmpty();
                            }
                          },
                          
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).textTheme.bodyText1!.color!,
                              ),
                            ),
                            hintText: "Search S/N",
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).textTheme.bodyText1!.color!,
                              ),
                            ),
                            // hiding drop down menu for global search
                            // prefixIcon: Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 20),
                            //   child: Wrap(
                            //     children: [
                            //       dropDownMenu(),
                            //       SizedBox(
                            //         width: 20,
                            //       ),
                            //       Container(
                            //         width: 2,
                            //         height: 50,
                            //         color: silver,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                searchController.clear();
                              },
                              child: Icon(
                                Icons.close,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                      viewModel.searchData == null
                          ? Container()
                          : Expanded(
                              child: ListView.builder(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    TopMatch match =
                                        viewModel.searchData!.topMatches![index];
                                    return GestureDetector(
                                      onTap: () {
                                        // viewModel.onDetailPageSelected(match);
                                        widget.onSelected!(match);
                                      },
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1),
                                              child: InsiteText(
                                                  text: match.serialNumber,
                                                  fontWeight: FontWeight.bold,
                                                  size: 18),
                                            ),
                                          ),
                                          Divider(
                                            height: 30,
                                            thickness: 1,
                                            color:
                                                Theme.of(context).dividerColor,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount:
                                      viewModel.searchData!.topMatches!.length),
                            ),
                      viewModel.searchData == null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InsiteText(
                                    text:
                                        'Showing ${viewModel.searchData!.topMatches!.length} out of ${viewModel.searchData!.totalCount} Assets',
                                    color: white,
                                    size: 12),
                                // TextButton(
                                //   onPressed: () {},
                                //   child: Text(
                                //     'Show list',
                                //     style: TextStyle(
                                //       color: white,
                                //       fontSize: 12,
                                //       decoration: TextDecoration.underline,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                    ],
                  ),
                ),
        );
      },
      viewModelBuilder: () => GlobalSearchViewModel(),
    );
  }

  DropdownButton<String> dropDownMenu() {
    return DropdownButton(
      value: dropdownValue,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: mediumgrey,
      ),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: mediumgrey),
      underline: Container(
        height: 0,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>[
        'All',
        'ID',
        'S/N',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
