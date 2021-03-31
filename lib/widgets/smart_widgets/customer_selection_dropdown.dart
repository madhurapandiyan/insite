import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/customer_selectable_list.dart';

class CustomerSelectionDropDown extends StatefulWidget {
  final SelectionType selectionType;
  final String selected;
  final Function(String) onSelected;
  CustomerSelectionDropDown(
      {this.selectionType, this.selected, this.onSelected});

  @override
  _CustomerSelectionDropDownState createState() =>
      _CustomerSelectionDropDownState();
}

class _CustomerSelectionDropDownState extends State<CustomerSelectionDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(color: tuna, borderRadius: BorderRadius.circular(8)),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.selected,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        widget.onSelected("selected");
                      })
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: CustomerSelectableList(),
            ),
          ],
        ));
  }
}

enum SelectionType { ACCOUNT, CUSTOMER }
