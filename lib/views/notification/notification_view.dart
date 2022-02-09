import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/main_notification.dart' as main_notification;
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/notification_item.dart';
import 'package:stacked/stacked.dart';
import 'notification_view_model.dart';

class NotificationView extends StatelessWidget {
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
                //viewModel.refresh();
              },
              onRefineApplied: () {
                //viewModel.refresh();
              },
              screenType: ScreenType.NOTIFICATION,
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 21.0),
                                child: InsiteText(
                                  text:
                                      "Notifications ( ${viewModel.assets.length.toString()} of ${viewModel.totalCount})",
                                  size: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InsitePopMenuItemButton(
                                              width: 40,
                                              height: 40,
                                              //icon: Icon(Icons.more_vert),
                                              widget: onContextMenuSelected(
                                                  viewModel, context),
                                            ),
                                          ))
                                      : SizedBox()
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
                                            },
                                            showDetails: () {
                                              viewModel.onDetailPageSelected(
                                                  notifications);
                                            },
                                          );
                                        }),
                                  )
                                : EmptyView(
                                    title: "No User found",
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
      viewModelBuilder: () => NotificationViewModel(),
    );
  }

  Widget onContextMenuSelected(
      NotificationViewModel viewModel, BuildContext context) {
    return PopupMenuButton<String>(
      offset: Offset(30, 50),
      itemBuilder: (context) => [
        viewModel.showMenu
            ? PopupMenuItem(
                value: "Deselect",
                child: InsiteText(
                  text: "eselect",
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
        viewModel.onSelectedItemClicK(value, context);
      },
      icon: Icon(
        Icons.more_vert,
        color: appbarcolor,
        size: 25,
      ),
    );
  }
}
