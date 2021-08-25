import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/health_list_item.dart';
import 'package:stacked/stacked.dart';
import 'health_list_view_model.dart';

class HealthListView extends StatefulWidget {
  final AssetDetail detail;
  HealthListView({this.detail});

  @override
  _HealthListViewState createState() => _HealthListViewState();
}

class _HealthListViewState extends State<HealthListView> {
  List<DateTime> dateRange = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HealthListViewModel>.reactive(
      builder: (BuildContext context, HealthListViewModel viewModel, Widget _) {
        return Container(
          decoration: BoxDecoration(
            color: mediumgrey,
            border: Border.all(color: black, width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          Utils.getDateInFormatddMMyyyy(viewModel.startDate) +
                              " - " +
                              Utils.getDateInFormatddMMyyyy(viewModel.endDate),
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
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
                  Expanded(
                    child: viewModel.loading
                        ? Container(
                            child: Center(child: CircularProgressIndicator()))
                        : viewModel.faults.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: viewModel.faults.length,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                controller: viewModel.scrollController,
                                itemBuilder: (context, index) {
                                  Fault faultElement = viewModel.faults[index];
                                  return HealthListItem(
                                    faultElement: faultElement,
                                  );
                                },
                              )
                            : EmptyView(
                                title: "No faults found",
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
          ),
        );
      },
      viewModelBuilder: () => HealthListViewModel(widget.detail),
    );
  }
}
