import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/user_preference.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/preference/model/time_zone.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';

class ManageUserWidget extends StatelessWidget {
   final UserPreference?dateFormat;
  final UserPreferedData?timeZone;
  final UserRow? user;
  final VoidCallback? callback;

  const ManageUserWidget({this.user, this.callback, this.dateFormat, this.timeZone});

  @override
  Widget build(BuildContext context) {
    getRoleName(List<ApplicationAccess>? userDetail, moduleName) {
      if (userDetail != null) {
        final index = userDetail
            .indexWhere((element) => element.applicationName == moduleName);
        Logger().wtf(index);
        if (index != -1) {
          return userDetail[index].role_name;
        } else {
          return '-';
        }
      } else {
        return "-";
      }
    }

    return GestureDetector(
      onTap: () {
        callback!();
      },
      child: Card(
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
                  user!.isSelected
                      ? Icon(
                          Icons.check_box_rounded,
                          color: Theme.of(context).buttonColor,
                        )
                      : Icon(
                          Icons.check_box_outline_blank,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                ],
              ),
            ),
            Container(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: InsiteExpansionTile(
                      title: Theme(
                        data: ThemeData(
                            textTheme: TextTheme(
                                bodyText1: TextStyle(
                                    color: user!.user!.verifiedUser!
                                        ? null
                                        : black.withOpacity(0.2)))),
                        child: Table(
                          border: TableBorder.all(
                              width: 1,
                              color: user!.user!.verifiedUser!
                                  ? black.withOpacity(0.2)
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!),
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
                                content: Utils.getPreferenceDate(
                                    user!.user!.createdOn,dateFormat,timeZone),
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
                                    : Utils.getPreferenceDate(
                                        user!.user!.lastLoginDate,dateFormat,timeZone),
                              )
                            ])
                          ],
                        ),
                      ),
                      children: [
                        Theme(
                          data: ThemeData(
                              textTheme: TextTheme(
                                  bodyText1: TextStyle(
                                      color: user!.user!.verifiedUser!
                                          ? null
                                          : black.withOpacity(0.2)))),
                          child: Column(
                            children: [
                              Table(
                                border: TableBorder.all(
                                    width: 1,
                                    color: user!.user!.verifiedUser!
                                        ? black.withOpacity(0.2)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!),
                                columnWidths: {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(1),
                                  2: FlexColumnWidth(1)
                                },
                                children: [
                                  TableRow(children: [
                                    InsiteTableRowItem(
                                        title: 'Administrator :',
                                        content: getRoleName(
                                            user!.user!.application_access,
                                            'Frame-Administrator-IND')),
                                    InsiteTableRowItem(
                                      title: 'Fleet:',
                                      content: getRoleName(
                                          user!.user!.application_access,
                                          'Frame-Fleet-IND'),
                                    ),
                                    InsiteTableRowItem(
                                      title: "Service:",
                                      content: getRoleName(
                                          user!.user!.application_access,
                                          'Frame-Service-IND'),
                                    )
                                  ]),
                                  // TableRow(children: [
                                  //   InsiteTableRowItem(
                                  //     title: 'Created By',
                                  //     content: user!.user!.createdBy,
                                  //   ),
                                  //   InsiteTableRowItem(title: "", content: ""),
                                  // ])
                                ],
                              ),
                              Table(
                                border: TableBorder.all(
                                    width: 1,
                                    color: user!.user!.verifiedUser!
                                        ? black.withOpacity(0.2)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!),
                                columnWidths: {
                                  0: FlexColumnWidth(1),
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
                              ),
                            ],
                          ),
                        )
                      ],
                      tilePadding: EdgeInsets.all(0),
                      childrenPadding: EdgeInsets.all(0),
                    )))
          ])),
    );
  }
}
