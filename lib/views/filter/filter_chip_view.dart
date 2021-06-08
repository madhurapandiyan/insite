import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'filter_chip_item.dart';

class FilterChipView extends StatelessWidget {
  final List<FilterData> data;
  const FilterChipView({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Wrap(
        runSpacing: 4,
        spacing: 4,
        children: [
          FilterChipItem(
            label: "BACKHOE LOADERS",
            onClose: () {},
          ),
          FilterChipItem(
            label: "WHEEL LOADER",
            onClose: () {},
          ),
          FilterChipItem(
            label: "EXCAVATOR",
            onClose: () {},
          ),
          FilterChipItem(
            label: "UNASSIGNED",
            onClose: () {},
          ),
        ],
      ),
    );
  }
}
