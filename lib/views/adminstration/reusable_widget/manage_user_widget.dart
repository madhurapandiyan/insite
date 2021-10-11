import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class ManageUserWidget extends StatelessWidget {
  final UserRow user;
  final VoidCallback callback;

  const ManageUserWidget({this.user, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Card(
          color: cardcolor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: cardcolor)),
          child: Row(children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: user.isSelected ? tango : Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Icon(
                        Icons.crop_square,
                        color: user.isSelected ? tango : Colors.black,
                      )),
                ],
              ),
            ),
            Expanded(
                child: InsiteExpansionTile(
              title: Table(
                border: TableBorder.all(width: 2, color: borderLineColor),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1)
                },
                children: [
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: 'Name :',
                      content: user.user.first_name + " " + user.user.last_name,
                    ),
                    InsiteTableRowItem(
                      title: 'User Type:',
                      content: user.user.user_type.toString(),
                    ),
                    InsiteTableRowItem(
                      title: 'Job Type :',
                      content: user.user.job_type.toString(),
                    ),
                  ]),
                  TableRow(children: [
                    InsiteTableRowItem(
                      title: 'Email ID :',
                      content: user.user.loginId,
                    ),
                    InsiteTableRowItem(
                      title: 'Job Title:',
                      content: "-",
                    ),
                    Column()
                  ])
                ],
              ),
              tilePadding: EdgeInsets.all(0),
              childrenPadding: EdgeInsets.all(0),
            ))
          ])),
    );
  }
}
