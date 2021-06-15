import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:logger/logger.dart';

class FilterItem extends StatefulWidget {
  final List<FilterData> data;
  final FilterType filterType;
  final Function(List<FilterData>) onApply;
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
          _displayList.add(item);
      });
      Logger().i("total list size " + list.length.toString());
      Logger().i("searched list size " + _displayList.length.toString());
      setState(() {});
    } else {
      if (_displayList.isNotEmpty) {
        _displayList.clear();
        if (_textEditingController != null && text.isEmpty) {
          setState(() {});
          return;
        }
      }
    }
  }

  List<FilterData> list;
  List<FilterData> _displayList;

  @override
  void initState() {
    list = widget.data;
    _displayList = list;
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

  clearFilter() {
    for (var i = 0; i < list.length; i++) {
      list[i].isSelected = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: _textEditingController,
                  hint: "Search",
                  onTextChanged: onSearchTextChanged,
                ),
              ),
              list.where((element) => element.isSelected).length > 0
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
                              clearFilter();
                              widget.onClear();
                            },
                          ),
                          InsiteButton(
                            onTap: () {
                              widget.onApply(list
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
              ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  FilterData data = list[index];
                  return GestureDetector(
                    onTap: () {
                      list[index].isSelected = !data.isSelected;
                      setState(() {});
                    },
                    child: Container(
                      color: data.isSelected ? tango : bgcolor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "(" + data.count + ") ",
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
        ),
      ],
    );
  }
}
