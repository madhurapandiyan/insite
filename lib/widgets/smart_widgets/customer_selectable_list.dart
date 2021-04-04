import 'package:flutter/material.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/theme/colors.dart';
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

  @override
  void initState() {
    Logger().d("customer list");
    Logger().d(widget.list.length);
    selected = widget.selectedData != null ? widget.selectedData : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        Customer customer = widget.list[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onSelected(SelectedData(
                selectionType: widget.selectionType, value: customer));
          },
          child: Container(
            color: getColor(customer, index),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
