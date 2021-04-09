import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:stacked/stacked.dart';
import 'global_search_view_model.dart';

class GlobalSearchView extends StatefulWidget {
  @override
  _GlobalSearchViewState createState() => _GlobalSearchViewState();
}

class _GlobalSearchViewState extends State<GlobalSearchView> {
  bool _isSearchSelected = false;
  final searchController = TextEditingController();
  String dropdownValue = 'All';

  List<String> searchItem = [
    'SP20-56557',
    'SP20-56557',
    'SP20-56557',
    'SP20-56557',
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GlobalSearchViewModel>.reactive(
      builder:
          (BuildContext context, GlobalSearchViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appbarcolor,
            leading: IconButton(
                icon: SvgPicture.asset("assets/images/menubar.svg"),
                onPressed: () {
                  print("button is tapped");
                  // updateCurrentState(ScreenType.HOME, viewModel);
                }),
            title: InsiteImage(
              height: 65,
              width: 65,
              path: "assets/images/hitachi.png",
            ),
            actions: [
              Container(
                color: _isSearchSelected ? mediumgrey : appbarcolor,
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/images/searchs.svg",
                    color: _isSearchSelected ? white : black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isSearchSelected = !_isSearchSelected;
                    });
                  },
                ),
              ),
            ],
          ),
          backgroundColor: bgcolor,
          body: Stack(
            children: [
              _isSearchSelected
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      color: tuna,
                      child: Column(
                        children: [
                          searchBar(),
                          Expanded(
                            child: searchResult(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Showing 5 out of 77 Assets',
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
                    )
                  : Container(),
              Container(),
            ],
          ),
        );
      },
      viewModelBuilder: () => GlobalSearchViewModel(),
    );
  }

  Padding searchBar() {
    var searchBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: TextFormField(
        controller: searchController,
        style: TextStyle(color: mediumgrey),
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
    );
  }

  ListView searchResult() {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    searchItem[index],
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
        itemCount: searchItem.length);
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
}
