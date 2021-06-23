import 'package:flutter/material.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:logger/logger.dart';
import 'customer_selection_dropdown.dart';

class CustomerSelectableList extends StatefulWidget {
  final Function(AccountData) onSelected;
  final AccountType selectionType;
  final AccountData selectedData;
  final List<AccountData> list;
  CustomerSelectableList(
      {this.onSelected, this.selectionType, this.list, this.selectedData});

  @override
  _CustomerSelectableListState createState() => _CustomerSelectableListState();
}

class _CustomerSelectableListState extends State<CustomerSelectableList> {
  int selectedIndex;
  AccountData selected;
  List<AccountData> _list = [];
  List<AccountData> _searchList = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    Logger().d("customer list");
    Logger().d(widget.list.length);
    selected = widget.selectedData != null ? widget.selectedData : null;
    _list.clear();
    _list = widget.list;
    _searchList = _list;
    Logger().i("init total list size " + _list.length.toString());
    _textEditingController.addListener(() {
      onSearchTextChanged(_textEditingController.text);
    });
    super.initState();
  }

  onSearchTextChanged(String text) async {
    Logger().i("query typeed " + text);
    if (text != null && text.trim().isNotEmpty) {
      List<AccountData> tempList = [];
      tempList.clear();
      _list.forEach((item) {
        if (item.value.DisplayName.toLowerCase().contains(text))
          tempList.add(item);
      });
      _searchList = tempList;
      Logger().i("total list size " + _list.length.toString());
      Logger().i("searched list size " + _searchList.length.toString());
      setState(() {});
    } else {
      if (_searchList.isNotEmpty) {
        _searchList.clear();
        selectedIndex = null;
        if (_textEditingController != null && text.isEmpty) {
          setState(() {});
          return;
        }
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
                    Customer customer = _searchList[index].value;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        widget.onSelected(AccountData(
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
                  itemCount: _list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Customer customer = _list[index].value;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        widget.onSelected(AccountData(
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
