import 'package:flutter/material.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/subscription/options/sub_dash_board_details/subscription_dashboard_details_list_item.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'subscription_dashboard_details_view_model.dart';

class SubDashBoardDetailsView extends StatelessWidget {
  final String filterKey;
  final PLANTSUBSCRIPTIONFILTERTYPE filterType;
  SubDashBoardDetailsView({this.filterKey, this.filterType});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubDashBoardDetailsViewModel>.reactive(
      builder: (BuildContext context, SubDashBoardDetailsViewModel viewModel,
          Widget _) {
        return InsiteScaffold(
          viewModel: viewModel,
          //screenType: ScreenType,
          onFilterApplied: () {
            //viewModel.refresh();
          },
          onRefineApplied: () {
            //viewModel.refresh();
          },
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: viewModel.loading
                        ? InsiteProgressBar()
                        : viewModel.devices.isNotEmpty
                            ? ListView.builder(
                                itemCount: viewModel.devices.length,
                                controller: viewModel.scrollController,
                                itemBuilder: (context, index) {
                                  DetailResult result =
                                      viewModel.devices[index];
                                  return SubscriptionDeviceListItem(
                                    detailResult: result,
                                    onCallback: () {},
                                  );
                                },
                              )
                            : EmptyView(
                                title: "No Results",
                              ),
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
        );
      },
      viewModelBuilder: () =>
          SubDashBoardDetailsViewModel(filterKey, filterType),
    );
  }
}
