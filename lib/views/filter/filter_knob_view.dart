import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/widgets/dumb_widgets/fleet_knob.dart';

class FleetKnobView extends StatefulWidget {
  final List<FilterData> data;
  const FleetKnobView({this.data});

  @override
  _FleetKnobViewState createState() => _FleetKnobViewState();
}

class _FleetKnobViewState extends State<FleetKnobView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        FilterData data = widget.data[index];
        return FleetKnob(filterData: data);
      },
      itemCount: widget.data.length,
    );
  }
}
