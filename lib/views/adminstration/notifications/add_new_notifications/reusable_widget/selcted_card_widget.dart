import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/model/fault_code_type_search.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class SelectedCardWidget extends StatefulWidget {
  final List<FaultCodeDetails>? items;
  final Function(int)? onDeleting;
  SelectedCardWidget({this.items,this.onDeleting});

  @override
  State<SelectedCardWidget> createState() => _SelectedCardWidgetState();
}

class _SelectedCardWidgetState extends State<SelectedCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.items!.length,
          itemBuilder: (BuildContext context, int i) {
            return InsiteExpansionTile(
                onExpansionChanged: (value) {
                  //widget.onExpanded!(value, i);
                },
                children: [
                  Table(
                    children: [
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Full Description",
                          content: widget.items![i].faultDescription,
                        )
                      ]),
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Code Type",
                          content: widget.items![i].faultCodeType,
                        )
                      ]),
                      TableRow(children: [
                        InsiteTableRowItem(
                          title: "Fault code",
                          content: widget.items![i].faultCodeIdentifier,
                        )
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InsiteButton(
                            onTap: () {
                              widget.onDeleting!(i);
                            },
                            title: "Delete",
                          ),
                        )
                      ])
                    ],
                  )
                ],
                title: ListTile(
                  leading: Container(
                    child: Icon(
                      widget.items![i].isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                  //trailing: InsiteButton(title: "Add",),
                  title: InsiteText(
                    fontWeight: FontWeight.bold,
                    text: widget.items![i].faultDescription,
                  ),
                ));
          },
        ),
      ),
    );
  }
}
