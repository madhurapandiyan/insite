import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/detail/tabs/utilization/tabs/list/single_asset_utilization_list_view_model.dart';
import 'package:insite/views/utilization/utilization_list_item.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationListView extends StatefulWidget {
  final AssetDetail detail;
  const SingleAssetUtilizationListView({
    Key key,
    this.detail,
  }) : super(key: key);

  @override
  _SingleAssetUtilizationListViewState createState() =>
      _SingleAssetUtilizationListViewState();
}

class _SingleAssetUtilizationListViewState
    extends State<SingleAssetUtilizationListView> {
  List<DateTime> dateRange = [];
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetUtilizationListViewModel>.reactive(
      builder: (BuildContext context,
          SingleAssetUtilizationListViewModel viewModel, Widget _) {
        if (viewModel.loading)
          return Center(child: CircularProgressIndicator());
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
                              child: DateRangeView()),
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
                Flexible(
                  child: viewModel.loading
                      ? Container(
                          child: Center(child: CircularProgressIndicator()))
                      : viewModel.utilLizationList.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              scrollDirection: Axis.vertical,
                              itemCount: viewModel.utilLizationList.length,
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              itemBuilder: (context, index) {
                                AssetResult utilizationData =
                                    viewModel.utilLizationList[index];
                                return UtilizationListItem(
                                  utilizationData: utilizationData,
                                  isShowingInDetailPage: true,
                                  onCallback: () {},
                                );
                              })
                          : EmptyView(
                              title: "No Assets Found",
                            ),
                ),
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
      viewModelBuilder: () =>
          SingleAssetUtilizationListViewModel(widget.detail),
    );
  }
}
