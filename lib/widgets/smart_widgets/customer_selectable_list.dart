import 'package:flutter/material.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:logger/logger.dart';
import 'customer_selection_dropdown.dart';

class CustomerSelectableList extends StatefulWidget {
  final Function(SelectedData) onSelected;
  final SelectionType selectionType;
  final SelectedData selectedData;
  final List<Customer> list;
  CustomerSelectableList(
      {this.onSelected, this.selectionType, this.list, this.selectedData});

  @override
  _CustomerSelectableListState createState() => _CustomerSelectableListState();
}

class _CustomerSelectableListState extends State<CustomerSelectableList> {
  int selectedIndex;
  SelectedData selected;
  List<Customer> list = [];
  List<Customer> _searchList = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    Logger().d("customer list");
    Logger().d(widget.list.length);
    selected = widget.selectedData != null ? widget.selectedData : null;
    if (list.isNotEmpty) {
      list.clear();
      list.addAll(widget.list);
    } else {
      list.addAll(widget.list);
    }
    Logger().i("init total list size " + list.length.toString());
    _textEditingController.addListener(() {
      onSearchTextChanged(_textEditingController.text);
    });
    super.initState();
  }

  onSearchTextChanged(String text) async {
    Logger().i("query typeed " + text);
    if (text != null && text.trim().isNotEmpty) {
      list.forEach((item) {
        if (item.DisplayName.contains(text) || item.DisplayName.contains(text))
          _searchList.add(item);
      });
      Logger().i("total list size " + list.length.toString());
      Logger().i("searched list size " + _searchList.length.toString());
      setState(() {});
    } else {
      _searchList.clear();
      selectedIndex = null;
      if (_textEditingController != null && text.isEmpty) {
        setState(() {});
        return;
      }
    }
  }

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchBox(
            controller: _textEditingController,
            hint: "Search",
            onTextChanged: onSearchTextChanged,
          ),
        ),
        Expanded(
          child: _searchList.length != 0 ||
                  _textEditingController.text.isNotEmpty
              ? ListView.builder(
                  itemCount: _searchList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Customer customer = _searchList[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        widget.onSelected(SelectedData(
                            selectionType: widget.selectionType,
                            value: customer));
                      },
                      child: Container(
                        color: getColor(customer, index),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                customer.DisplayName,
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
              : ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Customer customer = list[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        widget.onSelected(SelectedData(
                            selectionType: widget.selectionType,
                            value: customer));
                      },
                      child: Container(
                        color: getColor(customer, index),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                customer.DisplayName,
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
                ),
        ),
      ],
    );
  }

  Color getColor(customer, index) {
    if (selectedIndex != null && selected != null) {
      return selectedIndex == index ? tango : tuna;
    } else {
      return selectedIndex != null && selectedIndex == index
          ? tango
          : selected != null &&
                  selected.value.CustomerUID == customer.CustomerUID
              ? tango
              : tuna;
    }
  }
}
