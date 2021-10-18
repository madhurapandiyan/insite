import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:logger/logger.dart';

class FilterItem extends StatefulWidget {
  final List<FilterData> data;
  final FilterType filterType;
  final Function(List<FilterData>) onApply;
  final Function onClear;
  final bool isSingleSelection;
  FilterItem({
    this.data,
    this.onApply,
    this.onClear,
    this.filterType,
    this.isSingleSelection = false,
    Key key,
  }) : super(key: key);

  @override
  FilterItemState createState() => FilterItemState();
}

class FilterItemState extends State<FilterItem> {
  TextEditingController _textEditingController = TextEditingController();

  onSearchTextChanged(String text) async {
    Logger().i("query typed " + text);
    if (text != null && text.trim().isNotEmpty) {
      List<FilterData> tempList = [];
      tempList.clear();
      list.forEach((item) {
        if (item.title.toLowerCase().contains(text)) tempList.add(item);
      });
      _displayList = tempList;
      Logger().i("total list size " + list.length.toString());
      Logger().i("searched list size " + _displayList.length.toString());
      setState(() {});
    } else {
      _displayList = list;
      setState(() {});
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
    for (var i = 0; i < _displayList.length; i++) {
      _displayList[i].isSelected = false;
    }
    setState(() {});
  }

  deSelect() {
    for (var i = 0; i < _displayList.length; i++) {
      _displayList[i].isSelected = false;
    }
  }

  deSelectFromOutSide(FilterData value) {
    _displayList
        .firstWhere((element) => element.title == value.title)
        .isSelected = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Theme.of(context).iconTheme.color,
      title: InsiteText(
        text: Utils.getTitle(widget.filterType),
        size: 14,
        fontWeight: FontWeight.normal,
      ),
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).backgroundColor,
              border: Border.all(
                  color: Theme.of(context).textTheme.bodyText1.color)),
          child: Column(
            children: [
              list.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SearchBox(
                        controller: _textEditingController,
                        hint: "Search",
                        onTextChanged: onSearchTextChanged,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InsiteText(
                        text: "Not available",
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        size: 14,
                      ),
                    ),
              _displayList.where((element) => element.isSelected).length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InsiteRichText(
                            title: "",
                            content: "CLEAR FILTERS",
                            textColor: Theme.of(context).buttonColor,
                            onTap: () {
                              Logger().d("clear filter");
                              clearFilter();
                              widget.onClear();
                            },
                          ),
                          // InsiteButton(
                          //   onTap: () {
                          //     widget.onApply(_displayList
                          //         .where((element) => element.isSelected)
                          //         .toList());
                          //   },
                          //   width: 100,
                          //   height: 40,
                          //   title: "APPLY",
                          // )
                        ],
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: 8,
              ),
              ListView.builder(
                itemCount: _displayList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  FilterData data = _displayList[index];
                  return GestureDetector(
                    onTap: () {
                      if (widget.isSingleSelection) {
                        deSelect();
                        _displayList[index].isSelected = true;
                        setState(() {});
                      } else {
                        _displayList[index].isSelected = !data.isSelected;
                        setState(() {});
                      }
                      widget.onApply(_displayList
                          .where((element) => element.isSelected)
                          .toList());
                    },
                    child: Container(
                      color: data.isSelected
                          ? Theme.of(context).buttonColor
                          : Theme.of(context).backgroundColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InsiteTextOverFlow(
                              text: "(" + data.count + ") ",
                              overflow: TextOverflow.ellipsis,
                              color: data.isSelected ? white : null,
                              fontWeight: FontWeight.bold,
                              size: 16),
                          Expanded(
                            child: InsiteText(
                                text: Utils.getFilterTitleForList(data),
                                // overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                color: data.isSelected ? white : null,
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
