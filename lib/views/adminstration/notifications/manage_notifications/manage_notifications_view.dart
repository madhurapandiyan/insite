import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_notification_widget.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'manage_notifications_view_model.dart';

class ManageNotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageNotificationsViewModel>.reactive(
      builder: (BuildContext context, ManageNotificationsViewModel viewModel,
          Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.MANAGE_NOTIFICATION,
            onFilterApplied: () {
              //viewModel.refresh();
            },
            onRefineApplied: () {
              //viewModel.refresh();
            },
            body: Card(
              color: cardcolor,
              margin: EdgeInsets.only(top: 30.0, right: 20, left: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: cardcolor),
              ),
              child: Container(
                height: double.infinity,
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomTextBox(
                        controller: viewModel.searchController,
                        title: "SEARCH",
                        showLoading: viewModel.isSearching,
                        onChanged: (searchText) {
                          if (searchText.isNotEmpty) {
                            viewModel.getSearchListData(searchText);
                          } else {
                            viewModel.getManageNotificationsData();
                          }
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
                              ? ListView.separated(
                                  itemBuilder: (context, int index) {
                                    ConfiguredAlerts? alerts =
                                        viewModel.notifications[index];

                                    return ManageNotificationWidget(
                                      alerts: alerts,
                                      onDelete: () {
                                        viewModel.onDeleteClicked(context,
                                            alerts.alertConfigUID, index);
                                      },
                                      onEdit: () {
                                        //viewModel.editNotification(index)
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) => Divider(
                                        color: backgroundColor3,
                                        thickness: 2.0,
                                      ),
                                  itemCount: viewModel.notifications.length)
                              : EmptyView(title: "No Results"),
                    ),
                    viewModel.loadingMore
                        ? Padding(
                            padding: EdgeInsets.all(8),
                            child: InsiteProgressBar())
                        : SizedBox()
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ManageNotificationsViewModel(),
    );
  }
}
