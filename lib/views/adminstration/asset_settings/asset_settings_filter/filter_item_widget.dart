import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/estimated_runtime_widgets.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class FilterItemWidget extends StatefulWidget {
  final String text;
  final Widget body;
  const FilterItemWidget({this.text,this.body});

  @override
  _FilterItemWidgetState createState() => _FilterItemWidgetState();
}

class _FilterItemWidgetState extends State<FilterItemWidget> {
  @override
  Widget build(BuildContext context) {
    return  ExpansionTile(
      title: InsiteText(
        text: widget.text,
        size: 14,
        fontWeight: FontWeight.w700,
      ),
      children: [
        Container(
         
          height: MediaQuery.of(context).size.height,
          child: widget.body)
      ],
    );
    
  }
}
