import 'package:flutter/material.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class ManageGroupCardWidget extends StatefulWidget {
  final GroupRow? groups;
  final VoidCallback? callback;
  final VoidCallback? favoriteCallBack;
  const ManageGroupCardWidget(
      {this.groups, this.callback, this.favoriteCallBack});

  @override
  _ManageGroupCardWidgetState createState() => _ManageGroupCardWidgetState();
}

class _ManageGroupCardWidgetState extends State<ManageGroupCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callback!();
      },
      child: Card(
        color: cardcolor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: cardcolor)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20.0),
                  //   child: Icon(Icons.arrow_drop_down, color: Colors.white),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: widget.groups!.isSelected!
                                ? Theme.of(context).buttonColor
                                : Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Icon(
                          Icons.crop_square,
                          color: widget.groups!.isSelected!
                              ? Theme.of(context).buttonColor
                              : Colors.black,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.favoriteCallBack!();
                    },
                    child: Icon(
                      Icons.star,
                      color: widget.groups!.groups!.IsFavourite!
                          ? tango
                          : Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: InsiteExpansionTile(
              title: Table(
                border: TableBorder.all(width: 2, color: borderLineColor),
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1)
                },
                children: [
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: 'Name',
                      content: widget.groups!.groups!.GroupName != null
                          ? widget.groups!.groups!.GroupName
                          : "-",
                    ),
                    InsiteTableRowItem(
                      title: '# of Assets',
                      content: widget.groups!.groups!.AssetUID != null
                          ? widget.groups!.groups!.AssetUID!.length.toString()
                          : "-",
                    ),
                    InsiteTableRowItem(
                      title: 'Created by :',
                      content: widget.groups!.groups!.CreatedByUserName != null
                          ? widget.groups!.groups!.CreatedByUserName
                          : "-",
                    ),
                  ]),
                  TableRow(children: [
                    InsiteTableRowItem(
                        title: 'Description :',
                        content: widget.groups!.groups!.Description == null
                            ? "-"
                            : widget.groups!.groups!.Description),
                    InsiteTableRowItem(
                      title: 'Created:',
                      content: widget.groups!.groups!.createdOnUTC != null
                          ? Utils.getLastReportedDateOneUTC(
                              widget.groups!.groups!.createdOnUTC)
                          : "-",
                    ),
                    InsiteTableRowItem(
                      title: "",
                      content: "",
                    )
                  ])
                ],
              ),
              tilePadding: EdgeInsets.all(0),
              childrenPadding: EdgeInsets.all(0),
            ))
          ],
        ),
      ),
    );
  }
}
