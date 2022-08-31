import 'package:flutter/material.dart';
import 'package:insite/core/models/notification.dart' as notCount;

import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';

import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class NotificationWidget extends StatefulWidget {
  final notCount.NotificationData? notificationType;
  final double? count;
  final bool? isLoading;
  final Function(MAINTENANCETOTAL, String, int count)? onFilterSelected;

  NotificationWidget(
      {this.notificationType,
      this.count,
      this.isLoading,
      this.onFilterSelected});

  @override
  _FaultWidgetState createState() => _FaultWidgetState();
}

class _FaultWidgetState extends State<NotificationWidget> {
  Widget maintenanceDetailCount({notCount.Notification? data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InsiteText(
            text: data!.notificationSubType,
            fontWeight: FontWeight.w700,
            size: 14.0),
       InsiteButton(
        title: data.count!.round().toString(),
        textColor: white,
       )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.33,
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InsiteText(
                    text: "NOTIFICATION",
                    fontWeight: FontWeight.w900,
                    size: 11.0),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2,
                ),
                widget.isLoading!
                    ? Expanded(child: InsiteProgressBar())
                    : widget.notificationType?.notifications != null &&
                            widget.notificationType!.notifications!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget
                                  .notificationType!.notifications!.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = widget
                                    .notificationType!.notifications![index];
                                return Column(
                                  children: [
                                    maintenanceDetailCount(data: data),
                                    // data?. != null &&
                                    //         data!.subCount!.isNotEmpty
                                    //     ? Container(
                                    //         height: 100,
                                    //         margin: EdgeInsets.symmetric(
                                    //             horizontal: 10),
                                    //         child: ListView.builder(
                                    //           shrinkWrap: true,
                                    //           scrollDirection: Axis.vertical,
                                    //           physics:
                                    //               NeverScrollableScrollPhysics(),
                                    //           itemCount: data.subCount?.length,
                                    //           itemBuilder:
                                    //               (BuildContext context,
                                    //                   int i) {
                                    //             return ListTile(
                                    //               title: InsiteText(
                                    //                   text: data.subCount?[i]
                                    //                       .displayName,
                                    //                   fontWeight:
                                    //                       FontWeight.w700,
                                    //                   size: 14.0),
                                    //               trailing: InsiteText(
                                    //                   text: data
                                    //                       .subCount?[i].count
                                    //                       .toString(),
                                    //                   fontWeight:
                                    //                       FontWeight.w700,
                                    //                   size: 14.0),
                                    //               onTap: () {},
                                    //             );
                                    //           },
                                    //         ),
                                    //       )
                                    //     : SizedBox()
                                  ],
                                );
                              },
                            ),
                          )
                        : Expanded(
                            child: EmptyView(
                              title: "No Notification Found",
                            ),
                          ),
                // Divider(
                //   thickness: 2,
                // ),
                // Container(
                //   width: double.maxFinite,
                //   height: MediaQuery.of(context).size.height * 0.05,
                //   child: Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: InsiteTextAlign(
                //           text: "Viewing upcoming data for next 30 days"
                //               .toUpperCase(),
                //           textAlign: TextAlign.center,
                //           fontWeight: FontWeight.w900,
                //           size: 10.0)),
                // ),
              ],
            )));
    // Column(children: [
    //   GestureDetector(
    //     child: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 20.0),
    //       child: Row(
    //         children: [
    //           Expanded(
    //             flex: 1,
    //             child: InsiteText(
    //                 text: widget.notificationType,
    //                 fontWeight: FontWeight.w700,
    //                 size: 14.0),
    //           ),
    //           InsiteButton(
    //             bgColor: Colors.green,
    //             padding: EdgeInsets.all(4),
    //             title: widget.count.toString(),
    //             textColor: darkGrey,
    //             width: 61,
    //             height: 28,
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    //   Container(child: Divider(thickness: 1.0, color: black))
    // ]);
  }
}
