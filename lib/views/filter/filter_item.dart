import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:logger/logger.dart';

class FilterItem extends StatefulWidget {
  final List<FilterData> data;
  final FilterType filterType;
  final Function onApply;
  final Function onClear;
  FilterItem({this.data, this.onApply, this.onClear, this.filterType});

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  TextEditingController _textEditingController = TextEditingController();

  onSearchTextChanged(String text) async {
    Logger().i("query typeed " + text);
    if (text != null && text.trim().isNotEmpty) {
      list.forEach((item) {
        if (item.title.contains(text) || item.title.contains(text))
          _searchList.add(item);
      });
      Logger().i("total list size " + list.length.toString());
      Logger().i("searched list size " + _searchList.length.toString());
      setState(() {});
    } else {
      if (_searchList.isNotEmpty) {
        _searchList.clear();
        if (_textEditingController != null && text.isEmpty) {
          setState(() {});
          return;
        }
      }
    }
  }

  List<FilterData> list;
  List<FilterData> _searchList;

  @override
  void initState() {
    list = widget.data;
    _searchList = list;
    _textEditingController.addListener(() {
      onSearchTextChanged(_textEditingController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(getTitle(widget.filterType)),
      children: [
        Column(
          children: [
            SearchBox(
              controller: _textEditingController,
              hint: "Search",
              onTextChanged: onSearchTextChanged,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InsiteRichText(
                  title: "",
                  content: "CLEAR FILTERS",
                  textColor: Colors.white,
                ),
                InsiteButton(
                  onTap: () {},
                  width: 100,
                  height: 40,
                  title: "APPLY",
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                FilterData data = list[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: data.isSelected ? tango : tuna,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.count + " ",
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
          ],
        ),
      ],
    );
  }

  String getTitle(FilterType type) {
    String title = "";
    switch (type) {
      case FilterType.PRODUCT_FAMILY:
        title = "PRODUCT FAMILY";
        break;
      case FilterType.MAKE:
        title = "MAKE";
        break;
      case FilterType.MODEL:
        title = "MODEL";
        break;
      case FilterType.MODEL_YEAR:
        title = "MODEL YEAR";
        break;
      case FilterType.LOCATION_SEARCH:
        title = "LOCATION SEARCH";
        break;
      case FilterType.APPLICATION:
        title = "APPLICATION";
        break;
      case FilterType.ASSET_COMMISION_DATE:
        title = "ASSET COMMISSIONING DATE";
        break;
      case FilterType.SUBSCRIPTION_DATE:
        title = "SUBSCRIPTION DATE";
        break;
      case FilterType.DEVICE_TYPE:
        title = "DEVICE TYPE";
        break;
      case FilterType.ALL_ASSETS:
        title = "ALL ASSETS";
        break;
      default:
    }
    return title;
  }
}
