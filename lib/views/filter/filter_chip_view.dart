import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'filter_chip_item.dart';

class FilterChipView extends StatelessWidget {
  final List<FilterData> filters;
  final Function(FilterData) onClosed;
  const FilterChipView({this.filters, this.onClosed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Wrap(
        runSpacing: 4,
        spacing: 4,
        children: List.generate(
          filters.length,
          (index) {
            FilterData data = filters[index];
            return FilterChipItem(
              label: data.title,
              onClose: () {
                onClosed(data);
              },
            );
          },
        ),
      ),
    );
  }
}
