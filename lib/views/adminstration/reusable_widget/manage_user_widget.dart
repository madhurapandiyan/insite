import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class ManageUserWidget extends StatelessWidget {
  final UserRow? user;
  final VoidCallback? callback;

  const ManageUserWidget({this.user, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          callback!();
        },
        child: user!.user!.emailVerified == "YES"
            ? Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Icon(Icons.arrow_drop_down),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // user!.isSelected
                        //     ? Icon(
                        //         Icons.check_box_rounded,
                        //         color: Theme.of(context).buttonColor,
                        //       )
                        //     : Icon(
                        //         Icons.check_box_outline_blank,
                        //         color: Theme.of(context)
                        //             .textTheme
                        //             .bodyText1!
                        //             .color,
                        //       ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: InsiteExpansionTile(
                    title: Table(
                      border: TableBorder.all(width: 2, color: borderLineColor),
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2)
                      },
                      children: [
                        TableRow(children: [
                          InsiteTableRowItem(
                            title: 'Name :',
                            content: user!.user!.first_name! +
                                " " +
                                user!.user!.last_name!,
                          ),
                          InsiteTableRowItem(
                            title: 'Email ID :',
                            content: user!.user!.loginId,
                          ),
                          InsiteTableRowItem(
                            title: "Created At",
                            content: Utils.getDateInFormatddMMyyyy(
                                user!.user!.createdOn),
                          ),
                        ]),
                        TableRow(children: [
                          InsiteTableRowItem(
                            title: 'Job Type :',
                            content: user!.user!.job_type == "UnKnown"
                                ? "-"
                                : user!.user!.job_type.toString(),
                          ),
                          InsiteTableRowItem(
                            title: 'Job Title:',
                            content: "-",
                          ),
                          InsiteTableRowItem(
                            title: "Last login",
                            content: user!.user!.lastLoginDate == null
                                ? "-"
                                : Utils.getDateInFormatddMMyyyy(
                                    user!.user!.lastLoginDate),
                          )
                        ])
                      ],
                    ),
                    children: [
                      Table(
                        border:
                            TableBorder.all(width: 2, color: borderLineColor),
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1)
                        },
                        children: [
                          TableRow(children: [
                            InsiteTableRowItem(
                              title: 'Created By',
                              content: user!.user!.createdBy,
                            ),
                            InsiteTableRowItem(title: "", content: ""),
                          ])
                        ],
                      )
                    ],
                    tilePadding: EdgeInsets.all(0),
                    childrenPadding: EdgeInsets.all(0),
                  ))
                ]))
            : Card(
                
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Icon(Icons.arrow_drop_down),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // user!.isSelected
                        //     ? Icon(
                        //         Icons.check_box_rounded,
                        //         color: Theme.of(context).buttonColor,
                        //       )
                        //     : Icon(
                        //         Icons.check_box_outline_blank,
                        //         color: Theme.of(context)
                        //             .textTheme
                        //             .bodyText1!
                        //             .color,
                        //       ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: InsiteExpansionTile(
                    title: Table(
                      border: TableBorder.all(width: 2, color: borderLineColor),
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2)
                      },
                      children: [
                        TableRow(children: [
                          InsiteTableRowItem(
                            title: 'Name :',
                            content: user!.user!.first_name! +
                                " " +
                                user!.user!.last_name!,
                                unVerifiedUserColor: Colors.black.withOpacity(0.3),
                          ),
                          InsiteTableRowItem(
                            title: 'Email ID :',
                            content: user!.user!.loginId,
                              unVerifiedUserColor: Colors.black.withOpacity(0.3),
                          ),
                          InsiteTableRowItem(
                            title: "Created At",
                            content: Utils.getDateInFormatddMMyyyy(
                                user!.user!.createdOn),
                                  unVerifiedUserColor: Colors.black.withOpacity(0.3),
                          ),
                        ]),
                        TableRow(children: [
                          InsiteTableRowItem(
                            title: 'Job Type :',
                            content: user!.user!.job_type == "UnKnown"
                                ? "-"
                                : user!.user!.job_type.toString(),
                                  unVerifiedUserColor: Colors.black.withOpacity(0.3),
                          ),
                          InsiteTableRowItem(
                            title: 'Job Title:',
                            content: "-",
                              unVerifiedUserColor: Colors.black.withOpacity(0.3),
                          ),
                          InsiteTableRowItem(
                            title: "Last login",
                            content: user!.user!.lastLoginDate == null
                                ? "-"
                                : Utils.getDateInFormatddMMyyyy(
                                    user!.user!.lastLoginDate),
                                      unVerifiedUserColor: Colors.black.withOpacity(0.3),
                          )
                        ])
                      ],
                    ),
                    children: [
                      Table(
                        border:
                            TableBorder.all(width: 2, color: borderLineColor),
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1)
                        },
                        children: [
                          TableRow(children: [
                            InsiteTableRowItem(
                              title: 'Created By',
                              content: user!.user!.createdBy,
                                unVerifiedUserColor: Colors.black.withOpacity(0.3),
                            ),
                            InsiteTableRowItem(title: "", content: ""),
                          ])
                        ],
                      )
                    ],
                    tilePadding: EdgeInsets.all(0),
                    childrenPadding: EdgeInsets.all(0),
                  ))
                ])));
  }
}
