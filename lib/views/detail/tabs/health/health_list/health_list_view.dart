import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/health_list_item.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:stacked/stacked.dart';
import 'health_list_view_model.dart';

class HealthListView extends StatefulWidget {
  final AssetDetail? detail;
  HealthListView({this.detail});

  @override
  _HealthListViewState createState() => _HealthListViewState();
}

class _HealthListViewState extends State<HealthListView> {
  List<DateTime>? dateRange = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HealthListViewModel>.reactive(
      builder:
          (BuildContext context, HealthListViewModel viewModel, Widget? _) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border: Border.all(
                color: Theme.of(context).textTheme.bodyText1!.color!,
                width: 0.0),
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
                        // InsiteText(
                        //     text: Utils.getDateInFormatddMMyyyy(
                        //             viewModel.startDate) +
                        //         " - " +
                        //         Utils.getDateInFormatddMMyyyy(
                        //             viewModel.endDate),
                        //     fontWeight: FontWeight.bold,
                        //     size: 12),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        InsiteButton(
                          title:  Utils.getDateInFormatddMMyyyy(
                                    viewModel.startDate) +
                                " - " +
                                Utils.getDateInFormatddMMyyyy(
                                    viewModel.endDate),
                          //width: 90,
                          //bgColor: Theme.of(context).backgroundColor,
                          textColor:
                              Theme.of(context).textTheme.bodyText1!.color,
                          onTap: () async {
                            dateRange = [];
                            dateRange = await showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                  backgroundColor: transparent,
                                  child: DateRangeView()),
                            );
                            if (dateRange != null && dateRange!.isNotEmpty) {
                              viewModel.refresh();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: viewModel.loading
                        ? Container(child: InsiteProgressBar())
                        : viewModel.faults.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: viewModel.faults.length,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                controller: viewModel.scrollController,
                                itemBuilder: (context, index) {
                                  Fault faultElement = viewModel.faults[index];
                                  return HealthListItem(
                                    dateFormat: viewModel.userPref,
                                    timeZone: viewModel.zone,
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
      viewModelBuilder: () => HealthListViewModel(widget.detail),
    );
  }
}
