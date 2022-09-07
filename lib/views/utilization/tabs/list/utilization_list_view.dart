import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/utilization/utilization_list_item.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'utilization_list_view_model.dart';

class UtilizationListView extends StatefulWidget {
  const UtilizationListView({Key? key}) : super(key: key);

  @override
  UtilizationListViewState createState() => UtilizationListViewState();
}

class UtilizationListViewState extends State<UtilizationListView> {
  List<DateTime>? dateRange = [];

   UtilizationListViewModel? viewModelClass;

   @override
  void didUpdateWidget(covariant UtilizationListView oldWidget) {
   viewModelClass=UtilizationListViewModel();
   //onFilterApplied();
    super.didUpdateWidget(oldWidget);
  }
   

  // @override
  // void initState() {
  //    viewModelClass = UtilizationListViewModel();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   viewModelClass.dispose();
  //   super.dispose();
  // }

  onFilterApplied() {
    Logger().v("refresh");
    viewModelClass!.refresh();
  }

  @override
  Widget build(BuildContext context) {
    Logger().v("inside utilization listview item");
    return ViewModelBuilder<UtilizationListViewModel>.reactive(
        builder: (BuildContext context, UtilizationListViewModel viewModel,
            Widget? _) {
      // viewModelClass=viewModel;
          return Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 24),
                      child: Row(
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
                            //width: 90,
                            //bgColor: Theme.of(context).backgroundColor,
                            textColor: white,
                            onTap: () async {
                              dateRange = [];
                              dateRange = await showDialog(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                    backgroundColor: transparent,
                                    child: DateRangeView(
                                      filterType: FilterType.UTILIZATION_COUNT,
                                    )),
                              );
                              if (dateRange != null && dateRange!.isNotEmpty) {
                                viewModel.refresh();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    PageHeader(
                      isDashboard: false,
                      total: viewModel.totalCount,
                      screenType: ScreenType.UTILIZATION,
                      count: viewModel.utilLizationListData.length,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 18.0, top: 8, bottom: 16, right: 16),
                      child: InsiteText(
                        text:
                            'Runtime Hours / Working Hours / Idle Hours: Value includes data occurring outside of selected date range.',
                        size: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: viewModel.loading
                          ? Container(child: InsiteProgressBar())
                          : viewModel.utilLizationListData.isNotEmpty
                              ? ListView.builder(
                                  controller: viewModel.scrollController,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      viewModel.utilLizationListData.length,
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  itemBuilder: (context, index) {
                                    AssetResult utilizationData =
                                        viewModel.utilLizationListData[index];
                                    return UtilizationListItem(
                                      utilizationData: utilizationData,
                                      isShowingInDetailPage: false,
                                      onCallback: () {
                                        viewModel.onDetailPageSelected(
                                            utilizationData);
                                      },
                                    );
                                  })
                              : EmptyView(
                                  title: "No Assets Found",
                                ),
                    ),
                    viewModel.loadingMore
                        ? Padding(
                            padding: EdgeInsets.all(8),
                            child: InsiteProgressBar(),
                          )
                        : SizedBox(),
                  ],
                ),
                viewModel.refreshing ? InsiteProgressBar() : SizedBox()
              ],
            ),
          );
        },
        viewModelBuilder: () => UtilizationListViewModel());
  }
}
