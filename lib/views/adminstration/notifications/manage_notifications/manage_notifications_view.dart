import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_notification_widget.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'manage_notifications_view_model.dart';

class ManageNotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return ViewModelBuilder<ManageNotificationsViewModel>.reactive(
      builder: (BuildContext context, ManageNotificationsViewModel viewModel,
          Widget? _) {
             Logger().wtf( viewModel.appliedFilters!.toSet().toList().where((e) => e!.type==FilterType.NOTIFICATION_TYPE).toList().length);
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.where((e) => e!.type==FilterType.NOTIFICATION_TYPE).toList().length,
          child: InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.MANAGE_NOTIFICATION,
            onFilterApplied: () {
              viewModel.refresh();
            },
            onRefineApplied: () {
              viewModel.refresh();
            },
            body: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: InsiteText(
                    text: " (" +
                        viewModel.notifications.length.toString() +
                        " of " +
                        viewModel.totalCount.toString() +
                        " )" +
                        " " +
                        "Notifications",
                    size: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.only(top: 30.0, right: 20, left: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: cardcolor),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(right: 15, left: 15, top: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: CustomTextBox(
                              controller: viewModel.searchController,
                              title: "SEARCH",
                              onChanged: (searchText) {
                                viewModel.onChange();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: viewModel.loading
                                ? InsiteProgressBar()
                                : viewModel.notifications.isNotEmpty
                                    ? Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                                controller:
                                                    viewModel.scrollController,
                                                itemBuilder:
                                                    (context, int index) {
                                                  ConfiguredAlerts? alerts =
                                                      viewModel
                                                          .notifications[index];
                                                  return ManageNotificationWidget(
                                                    dateFormat: viewModel.userPref,
                                                    timeZone: viewModel.zone,
                                                    alerts: alerts,
                                                    onDelete: () {
                                                      viewModel.onDeleteClicked(
                                                          context,
                                                          alerts.alertConfigUID,
                                                          index);
                                                    },
                                                    onEdit: () {
                                                      viewModel
                                                          .editNotification(
                                                              index);
                                                    },
                                                  );
                                                },
                                                itemCount: viewModel
                                                    .notifications.length),
                                          ),
                                          viewModel.loadingMore
                                              ? Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: InsiteProgressBar())
                                              : SizedBox()
                                        ],
                                      )
                                    // ListView.separated(

                                    //     separatorBuilder: (context, index) =>
                                    //         Divider(
                                    //           color: backgroundColor3,
                                    //           thickness: 2.0,
                                    //         ),
                                    //    )
                                    : EmptyView(title: "No Notification Found"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ManageNotificationsViewModel(),
    );
  }
}
