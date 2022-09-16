import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/main_notification.dart' as main_notification;
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/notification_item.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'notification_view_model.dart';

class NotificationView extends StatefulWidget {
  final String? filterValue;
  final String ?productFamily;
  NotificationView({this.filterValue,this.productFamily});
  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  int? selectedIndex;
  List<DateTime>? dateRange = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      builder:
          (BuildContext context, NotificationViewModel viewModel, Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
              viewModel: viewModel,
              onFilterApplied: () {
                viewModel.refresh();
              },
              onRefineApplied: () {
                //viewModel.refresh();
              },
              screenType: ScreenType.NOTIFICATIONS,
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: InsiteTextOverFlow(
                            text: "NOTIFICATIONS",
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            size: 16,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InsiteText(
                                  text:
                                      "Notifications ( ${viewModel.assets.length.toString()} of ${viewModel.totalCount})",
                                  size: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // InsiteText(
                                    //     text: Utils.getDateInFormatddMMyyyy(
                                    //             viewModel.startDate) +
                                    //         " - " +
                                    //         Utils.getDateInFormatddMMyyyy(
                                    //             viewModel.endDate),
                                    //     fontWeight: FontWeight.bold,
                                    //     size: 11),
                                    // SizedBox(
                                    //   width: 4,
                                    // ),
                                    InsiteButton(
                                      title: Utils.getDateInFormatddMMyyyy(
                                              viewModel.startDate) +
                                          " - " +
                                          Utils.getDateInFormatddMMyyyy(
                                              viewModel.endDate),
                                      //  bgColor: Theme.of(context).backgroundColor,
                                      textColor: white,
                                      onTap: () async {
                                     
                                        dateRange = [];
                                        dateRange = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              Dialog(
                                                  backgroundColor: transparent,
                                                  child: DateRangeView()),
                                        );
                                        viewModel.startDate =
                                            dateRange!.first.toString();
                                        viewModel.endDate =
                                            dateRange!.last.toString();
                                        viewModel.refresh();
                                      },
                                      
                                    ),
                                  ],
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.only(right: 10.0),
                                //   child: Row(
                                //     children: [
                                //       viewModel.showDelete
                                //           ? ClipRRect(
                                //               borderRadius: BorderRadius.only(
                                //                 topLeft: Radius.circular(10),
                                //                 topRight: Radius.circular(10),
                                //                 bottomRight: Radius.circular(10),
                                //                 bottomLeft: Radius.circular(10),
                                //               ),
                                //               child: InsiteButton(
                                //                 title: "RESOLVE",
                                //                 onTap: () {
                                //                   viewModel.onItemDeselect();
                                //                 },
                                //                 // icon: Icon(
                                //                 //   Icons.edit,
                                //                 //   color: appbarcolor,
                                //                 // )
                                //               ),
                                //             )
                                //           : SizedBox(),
                                //       SizedBox(
                                //         width: 10,
                                //       ),
                                //       viewModel.showDelete
                                //           ? ClipRRect(
                                //               borderRadius: BorderRadius.only(
                                //                 topLeft: Radius.circular(10),
                                //                 topRight: Radius.circular(10),
                                //                 bottomRight: Radius.circular(10),
                                //                 bottomLeft: Radius.circular(10),
                                //               ),
                                //               child: InsiteButton(
                                //                   title: "",
                                //                   onTap: () {
                                //                     // viewModel
                                //                     //     .onDeleteClicked(context);
                                //                   },
                                //                   icon: Icon(
                                //                     Icons.delete_outline,
                                //                     color: appbarcolor,
                                //                   )),
                                //             )
                                //           : SizedBox(),
                                //       SizedBox(
                                //         width: 10,
                                //       ),
                                //       viewModel.showDeSelect
                                //           ? ClipRRect(
                                //               borderRadius: BorderRadius.only(
                                //                 topLeft: Radius.circular(10),
                                //                 topRight: Radius.circular(10),
                                //                 bottomRight: Radius.circular(10),
                                //                 bottomLeft: Radius.circular(10),
                                //               ),
                                //               child: InsiteButton(
                                //                   title: "",
                                //                   onTap: () {
                                //                     viewModel.onItemDeselect();
                                //                   },
                                //                   icon: Icon(
                                //                     Icons.close,
                                //                     color: appbarcolor,
                                //                   )),
                                //             )
                                //           : SizedBox(),
                                //       !viewModel.showDeSelect &&
                                //               !viewModel.showDelete &&
                                //               !viewModel.showEdit
                                //           ? Container()
                                //           : SizedBox(),
                                //       SizedBox(
                                //         width: 10,
                                //       )
                                //     ],
                                //   ),
                                // )
                              ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            viewModel.showEdit
                                ? ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: InsitePopMenuItemButton(
                                        width: 40,
                                        height: 40,
                                        //icon: Icon(Icons.more_vert),
                                        widget: onContextMenuSelected(
                                            viewModel, context, selectedIndex!),
                                      ),
                                    ))
                                : SizedBox()
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        viewModel.loading
                            ? Padding(
                                padding: const EdgeInsets.only(top: 60.0),
                                child: InsiteProgressBar(),
                              )
                            : viewModel.assets.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount: viewModel.assets.length,
                                        controller: viewModel.scrollController,
                                        padding: EdgeInsets.all(8),
                                        itemBuilder: (context, index) {
                                          main_notification.Notification
                                              notifications =
                                              viewModel.assets[index];
                                          return NotificationItem(
                                            notifications: notifications,
                                            onCallback: () {
                                              viewModel.onItemSelected(index);
                                              selectedIndex = index;
                                            },
                                            showDetails: () {
                                              viewModel.onDetailPageSelected(
                                                  notifications);
                                            },
                                          );
                                        }),
                                  )
                                : EmptyView(
                                    title: "No Notification Found",
                                  ),
                        viewModel.loadingMore
                            ? Padding(
                                padding: EdgeInsets.all(8),
                                child: InsiteProgressBar())
                            : SizedBox()
                      ],
                    ),
                    viewModel.refreshing ? InsiteProgressBar() : SizedBox()
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => NotificationViewModel(value: widget.filterValue,filterData: widget.productFamily),
    );
  }

  Widget onContextMenuSelected(
      NotificationViewModel viewModel, BuildContext context, int? index) {
    return PopupMenuButton<String>(
      offset: Offset(30, 50),
      itemBuilder: (context) => [
        viewModel.showMenu
            ? PopupMenuItem(
                value: "Deselect",
                child: InsiteText(
                  text: "Deselect",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ))
            : PopupMenuItem(
                child: SizedBox(),
                height: 0,
              ),
        viewModel.showEdit
            ? PopupMenuItem(
                value: "Resolve",
                child: InsiteText(
                  text: "Resolve",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ),
              )
            : PopupMenuItem(
                child: SizedBox(),
                height: 0,
              ),
        viewModel.showEdit
            ? PopupMenuItem(
                value: "Delete",
                child: InsiteText(
                  text: "Delete",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ),
              )
            : PopupMenuItem(
                child: SizedBox(),
                height: 0,
              ),
      ],
      onSelected: (value) {
        viewModel.onSelectedItemClicK(value, context, index!);
      },
      icon: Icon(
        Icons.more_vert,
        color: appbarcolor,
        size: 25,
      ),
    );
  }
}
