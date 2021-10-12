import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/utils/helper_methods.dart';
import 'filter_chip_item.dart';

class FilterChipView extends StatelessWidget {
  final List<FilterData> filters;
  final Function(FilterData) onClosed;
  final Color backgroundColor;
  final EdgeInsets padding;
  const FilterChipView(
      {this.filters, this.onClosed, this.backgroundColor, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: padding,
      child: Wrap(
        runSpacing: 4,
        spacing: 4,
        children: List.generate(
          filters.length,
          (index) {
            FilterData data = filters[index];
            return FilterChipItem(
              label: Utils.getFilterTitleForChipView(data),
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
