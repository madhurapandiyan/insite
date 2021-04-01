import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/smart_widgets/customer_selectable_list.dart';

class CustomerSelectionDropDown extends StatefulWidget {
  final SelectionType selectionType;
  final String selected;
  final Function(SelectedData) onSelected;
  final VoidCallback onReset;
  final bool showList;
  CustomerSelectionDropDown(
      {this.selectionType,
      this.selected,
      this.onSelected,
      this.showList,
      this.onReset});

  @override
  _CustomerSelectionDropDownState createState() =>
      _CustomerSelectionDropDownState();
}

class _CustomerSelectionDropDownState extends State<CustomerSelectionDropDown> {
  bool showList = false;

  SelectedData data = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                color: tuna, borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.only(top: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: tuna,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: thunder)),
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showList = !showList;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.selected,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                showList = !showList;
                              });
                            })
                      ],
                    ),
                  ),
                ),
                showList
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: CustomerSelectableList(
                          selectionType: widget.selectionType,
                          onSelected: (SelectedData value) {
                            data = value;
                            setState(() {});
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            )),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              showList &&
                      data != null &&
                      widget.selectionType == SelectionType.CUSTOMER
                  ? InsiteButton(
                      bgColor: Colors.white,
                      textColor: ship_grey,
                      onTap: () {
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
              showList && data != null
                  ? InsiteButton(
                      bgColor: tango,
                      height: 48,
                      width: 100,
                      textColor: Colors.white,
                      onTap: () {
                        setState(() {
                          showList = !showList;
                        });
                        if (data != null) {
                          widget.onSelected(data);
                        }
                      },
                      title: "SELECT",
                    )
                  : SizedBox(),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        )
      ],
    );
  }
}

class SelectedData {
  final SelectionType selectionType;
  final String value;
  SelectedData({this.selectionType, this.value});
}

enum SelectionType { ACCOUNT, CUSTOMER }
