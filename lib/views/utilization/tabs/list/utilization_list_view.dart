import 'package:flutter/material.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/utilization/utilization_list_item.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:stacked/stacked.dart';
import 'utilization_list_view_model.dart';

class UtilizationListView extends StatefulWidget {
  const UtilizationListView({Key key}) : super(key: key);

  @override
  UtilizationListViewState createState() => UtilizationListViewState();
}

class UtilizationListViewState extends State<UtilizationListView> {
  List<DateTime> dateRange = [];

  var viewModel;

  @override
  void initState() {
    viewModel = UtilizationListViewModel();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  onFilterApplied() {
    viewModel.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilizationListViewModel>.reactive(
        builder: (BuildContext context, UtilizationListViewModel viewModel,
            Widget _) {
          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Utils.getDateInFormatddMMyyyy(viewModel.startDate) +
                              " - " +
                              Utils.getDateInFormatddMMyyyy(viewModel.endDate),
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () async {
                            dateRange = [];
                            dateRange = await showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                  backgroundColor: transparent,
                                  child: DateRangeView()),
                            );
                            if (dateRange != null && dateRange.isNotEmpty) {
                              viewModel.refresh();
                            }
                          },
                          child: Container(
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                              color: cardcolor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Date Range',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PageHeader(
                    isDashboard: false,
                    total: viewModel.totalCount,
                    count: viewModel.utilLizationListData.length,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 18.0, top: 8, bottom: 16, right: 16),
                    child: Text(
                      'Runtime Hours / Working Hours / Idle Hours: Value includes data occurring outside of selected date range.',
                      style: TextStyle(
                        color: white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: viewModel.loading
                        ? Container(
                            child: Center(child: CircularProgressIndicator()))
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
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(),
                ],
              ),
              viewModel.refreshing
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox()
            ],
          );
        },
        viewModelBuilder: () => viewModel);
  }
}
