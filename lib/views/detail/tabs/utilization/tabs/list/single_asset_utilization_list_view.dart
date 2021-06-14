import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/views/detail/tabs/utilization/tabs/list/single_asset_utilization_list_view_model.dart';
import 'package:insite/views/utilization/utilization_list_item.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationListView extends StatefulWidget {
  final AssetDetail detail;
  final List<DateTime> dateRange;
  const SingleAssetUtilizationListView(
      {Key key, @required this.detail, @required this.dateRange})
      : super(key: key);

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
        if (viewModel.loading) return CircularProgressIndicator();
        return viewModel.utilLizationList.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
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
              );
      },
      viewModelBuilder: () => SingleAssetUtilizationListViewModel(
        widget.detail,
        DateFormat('yyyy-MM-dd').format(widget.dateRange.first),
        DateFormat('yyyy-MM-dd').format(widget.dateRange.last),
      ),
    );
  }
}
