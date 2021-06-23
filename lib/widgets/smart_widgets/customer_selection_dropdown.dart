import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/custom_expansion_tile.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:logger/logger.dart';

class AccountSelectionDropDownWidget extends StatefulWidget {
  final AccountType selectionType;
  final AccountData selected;
  final Function(AccountData) onSelected;
  final VoidCallback onReset;
  final List<AccountData> list;
  AccountSelectionDropDownWidget(
      {this.selectionType,
      this.selected,
      this.onSelected,
      this.list,
      this.onReset});

  @override
  _AccountSelectionDropDownWidgetState createState() =>
      _AccountSelectionDropDownWidgetState();
}

class _AccountSelectionDropDownWidgetState
    extends State<AccountSelectionDropDownWidget> {
  TextEditingController _textEditingController = TextEditingController();
  bool isExpanded = false;
  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();

  AccountData selected;
  List<AccountData> _list = [];
  List<AccountData> _displayList = [];

  onSearchTextChanged(String text) async {
    Logger().i("query typeed " + text);
    if (text != null && text.trim().isNotEmpty) {
      List<AccountData> tempList = [];
      tempList.clear();
      _list.forEach((item) {
        if (item.value.DisplayName.toLowerCase().contains(text))
          tempList.add(item);
      });
      _displayList = tempList;
      Logger().i("total list size " + _list.length.toString());
      Logger().i("searched list size " + _displayList.length.toString());
      setState(() {});
    } else {
      _displayList = _list;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    selected = widget.selected != null ? widget.selected : null;
    _list.clear();
    _list = widget.list;
    _displayList = _list;
    if (selected != null) {
      Logger().i(selected.value.DisplayName);
    }
    _textEditingController.addListener(() {
      onSearchTextChanged(_textEditingController.text);
    });
    delayTheListRendering();
  }

  bool showList = false;
  delayTheListRendering() async {
    await Future.delayed(Duration(seconds: 2)).then((_) {
      setState(() {
        showList = true;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  deSelect() {
    for (var i = 0; i < _displayList.length; i++) {
      _displayList[i].isSelected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppExpansionTile(
      backgroundColor: ship_grey,
      title: Text(
        selected != null
            ? selected.value.DisplayName
            : widget.selectionType == AccountType.ACCOUNT
                ? "Select"
                : "Customer",
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      key: expansionTile,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: bgcolor,
          ),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _list.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SearchBox(
                                controller: _textEditingController,
                                hint: "Search",
                                onTextChanged: onSearchTextChanged,
                              ),
                            )
                          : SizedBox(),
                      showList
                          ? ListView.builder(
                              itemCount: _displayList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                AccountData data = _displayList[index];
                                return GestureDetector(
                                  onTap: () {
                                    deSelect();
                                    _displayList[index].isSelected = true;
                                    selected = data;
                                    setState(() {});
                                    // widget.onSelected(AccountData(
                                    //     selectionType: widget.selectionType,
                                    //     value: customer));
                                  },
                                  child: Container(
                                    color: _displayList[index].isSelected
                                        ? tango
                                        : bgcolor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data.value.DisplayName,
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
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              _displayList.isNotEmpty && selected != null
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        children: [
                          widget.selectionType == AccountType.CUSTOMER
                              ? InsiteButton(
                                  bgColor: Colors.white,
                                  textColor: ship_grey,
                                  onTap: () {
                                    deSelect();
                                    selected = null;
                                    setState(() {});
                                    widget.onReset();
                                  },
                                  width: 100,
                                  height: 48,
                                  title: "RESET",
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 20,
                            width: 40,
                          ),
                          InsiteButton(
                            bgColor: tango,
                            height: 48,
                            width: 100,
                            textColor: Colors.white,
                            onTap: () {
                              expansionTile.currentState.collapse();
                              if (selected != null) {
                                widget.onSelected(selected);
                              }
                            },
                            title: "SELECT",
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}

class AccountData {
  final AccountType selectionType;
  final Customer value;
  bool isSelected;
  AccountData({this.selectionType, this.value, this.isSelected});
}

enum AccountType { ACCOUNT, CUSTOMER }
