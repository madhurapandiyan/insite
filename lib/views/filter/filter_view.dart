import 'package:flutter/material.dart';
import 'package:insite/widgets/smart_widgets/customer_selection_dropdown.dart';

class FilterView extends StatefulWidget {
  FilterView({Key key}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              CustomerSelectionDropDown(
                selectionType: SelectionType.ACCOUNT,
                onSelected: (SelectedData value) {},
                onReset: () {},
                selected: null,
                list: [],
              ),
              SizedBox(
                height: 16,
              ),
              CustomerSelectionDropDown(
                selectionType: SelectionType.ACCOUNT,
                onSelected: (SelectedData value) {},
                onReset: () {},
                selected: null,
                list: [],
              ),
              SizedBox(
                height: 16,
              ),
              CustomerSelectionDropDown(
                selectionType: SelectionType.ACCOUNT,
                onSelected: (SelectedData value) {},
                onReset: () {},
                selected: null,
                list: [],
              ),
              SizedBox(
                height: 16,
              ),
              CustomerSelectionDropDown(
                selectionType: SelectionType.ACCOUNT,
                onSelected: (SelectedData value) {},
                onReset: () {},
                selected: null,
                list: [],
              ),
              SizedBox(
                height: 16,
              ),
              CustomerSelectionDropDown(
                selectionType: SelectionType.ACCOUNT,
                onSelected: (SelectedData value) {},
                onReset: () {},
                selected: null,
                list: [],
              ),
              SizedBox(
                height: 16,
              ),
              CustomerSelectionDropDown(
                selectionType: SelectionType.ACCOUNT,
                onSelected: (SelectedData value) {},
                onReset: () {},
                selected: null,
                list: [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
