import 'package:flutter/material.dart';
import 'package:insite/core/models/account.dart';
import 'package:insite/theme/colors.dart';
import 'customer_selection_dropdown.dart';

class CustomerSelectableList extends StatefulWidget {
  final Function(SelectedData) onSelected;
  final SelectionType selectionType;

  CustomerSelectableList({this.onSelected, this.selectionType});

  @override
  _CustomerSelectableListState createState() => _CustomerSelectableListState();
}

class _CustomerSelectableListState extends State<CustomerSelectableList> {
  int selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accountList.length,
      itemBuilder: (context, index) {
        Account account = accountList[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onSelected(SelectedData(
                selectionType: widget.selectionType,
                value: accountList[index].name));
          },
          child: Container(
            color:
                selectedIndex != null && selectedIndex == index ? tango : tuna,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  account.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
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
    );
  }
}

class Customer {
  final String name;
  final bool isSelected;
  Customer({this.name, this.isSelected});
}
