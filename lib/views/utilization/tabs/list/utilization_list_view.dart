import 'package:flutter/material.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/views/utilization/utilization_list_item.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:stacked/stacked.dart';
import 'utilization_list_view_model.dart';

class UtilizationListView extends StatefulWidget {
  final List<DateTime> dateRange;
  const UtilizationListView({Key key, this.dateRange}) : super(key: key);

  @override
  _UtilizationListViewState createState() => _UtilizationListViewState();
}

class _UtilizationListViewState extends State<UtilizationListView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilizationListViewModel>.reactive(
      builder:
          (BuildContext context, UtilizationListViewModel viewModel, Widget _) {
        return viewModel.utilLizationListData != null
            // ? Column(
            //     children: [
            ? Expanded(
                child: viewModel.utilLizationListData.isNotEmpty
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
                              viewModel.onDetailPageSelected(utilizationData);
                            },
                          );
                        })
                    : EmptyView(
                        title: "No Assets Found",
                      ),
              )
            //     viewModel.loadingMore
            //         ? Padding(
            //             padding: EdgeInsets.all(8),
            //             child: CircularProgressIndicator())
            //         : SizedBox()
            //   ],
            // )
            : EmptyView(title: "No Results");
      },
      viewModelBuilder: () => UtilizationListViewModel(),
    );
  }
}
