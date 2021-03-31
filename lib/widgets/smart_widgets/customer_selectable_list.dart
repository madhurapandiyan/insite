import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class CustomerSelectableList extends StatefulWidget {
  CustomerSelectableList({Key key}) : super(key: key);

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
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            color:
                selectedIndex != null && selectedIndex == index ? tango : tuna,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "THCM Kharagpur Factory",
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
