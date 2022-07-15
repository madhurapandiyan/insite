import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/multi_custom_dropDown_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class DropDownWidgetWithGoogleMap extends StatefulWidget {
  final String? initialValue;
  final List<CheckBoxDropDown>? items;
  final Function(List<CheckBoxDropDown>?)? onConform;
  final Function(int)? onSelecting;
  final Function? onAddingZone;

  DropDownWidgetWithGoogleMap(
      {this.initialValue,
      this.items,
      this.onConform,
      this.onAddingZone,
      this.onSelecting});
  @override
  State<DropDownWidgetWithGoogleMap> createState() =>
      _DropDownWidgetWithGoogleMapState();
}

class _DropDownWidgetWithGoogleMapState
    extends State<DropDownWidgetWithGoogleMap> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  border: Border.all(
                      width: 1,
                      color: Theme.of(context).textTheme.bodyText1!.color!),

                  ///boxShadow: [BoxShadow(color: black, blurRadius: 3)],
                  borderRadius: BorderRadius.circular(10)),
              child: MultiSelectionDropDownWidget(
                initialValue: "select",
                onConform: (value) {
                  widget.onConform!(value);
                },
                onSelected: (i) {
                  widget.onSelecting!(i);
                },
                items: widget.items!,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InsiteButton(
            onTap: () {
              widget.onAddingZone!();
            },
            title: "Add New Zone",
          )
        ],
      ),
    );
  }
}