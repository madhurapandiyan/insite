import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:stacked/stacked.dart';
import 'global_search_view_model.dart';

class GlobalSearchView extends StatefulWidget {
  @override
  _GlobalSearchViewState createState() => _GlobalSearchViewState();

  const GlobalSearchView({
    Key key,
  }) : super(key: key);
}

class _GlobalSearchViewState extends State<GlobalSearchView> {
  final searchController = TextEditingController();
  String dropdownValue = 'All';

  var searchBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ViewModelBuilder<GlobalSearchViewModel>.reactive(
        builder:
            (BuildContext context, GlobalSearchViewModel viewModel, Widget _) {
          return viewModel.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  color: tuna,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: TextFormField(
                          controller: searchController,
                          style: TextStyle(color: mediumgrey),
                          onChanged: (searchText) {
                            viewModel.searchKeyword = searchText;
                            viewModel.getSearchResult();
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: white,
                            border: searchBorder,
                            focusedBorder: searchBorder,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Wrap(
                                children: [
                                  dropDownMenu(),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 2,
                                    height: 50,
                                    color: silver,
                                  ),
                                ],
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                searchController.clear();
                              },
                              child: Icon(
                                Icons.close,
                                color: mediumgrey,
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
                                    return Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1),
                                            child: Text(
                                              viewModel
                                                  .searchData
                                                  .topMatches[index]
                                                  .serialNumber,
                                              style: TextStyle(
                                                  color: white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 30,
                                          thickness: 3,
                                          color: mediumgrey,
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount:
                                      viewModel.searchData.topMatches.length),
                            ),
                      viewModel.searchData == null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Showing ${viewModel.searchData.totalCount} out of ${viewModel.searchData.totalCount} Assets',
                                  style: TextStyle(color: white, fontSize: 18),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Show list',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                );
        },
        viewModelBuilder: () => GlobalSearchViewModel(),
      ),
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
      onChanged: (String newValue) {
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
