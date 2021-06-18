import 'package:flutter/material.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/utilization/utilization_list_item.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/smart_widgets/date_range.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'utilization_list_view_model.dart';

class UtilizationListView extends StatefulWidget {
  const UtilizationListView({Key key}) : super(key: key);

  @override
  _UtilizationListViewState createState() => _UtilizationListViewState();
}

class _UtilizationListViewState extends State<UtilizationListView> {
  List<DateTime> dateRange = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilizationListViewModel>.reactive(
      builder:
          (BuildContext context, UtilizationListViewModel viewModel, Widget _) {
        return Stack(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () async {
                        dateRange = [];
                        dateRange = await showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                              backgroundColor: transparent,
                              child: DateRangeWidget()),
                        );
                        if (dateRange != null && dateRange.isNotEmpty) {
                          viewModel.startDate =
                              DateFormat('MM/dd/yyyy').format(dateRange.first);
                          viewModel.endDate =
                              DateFormat('MM/dd/yyyy').format(dateRange.last);
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
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
                          ? ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              controller: viewModel.scrollController,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: viewModel.utilLizationListData.length,
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              itemBuilder: (context, index) {
                                AssetResult utilizationData =
                                    viewModel.utilLizationListData[index];
                                return UtilizationListItem(
                                  utilizationData: utilizationData,
                                  isShowingInDetailPage: false,
                                  onCallback: () {
                                    viewModel
                                        .onDetailPageSelected(utilizationData);
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
      viewModelBuilder: () => UtilizationListViewModel(),
    );
  }
}