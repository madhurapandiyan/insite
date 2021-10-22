import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/views/health/fault/fault_view_model.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/fault_list_item.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:stacked/stacked.dart';

class FaultView extends StatefulWidget {
  FaultView({Key key}) : super(key: key);

  @override
  FaultViewState createState() => FaultViewState();
}

class FaultViewState extends State<FaultView> {
  onFilterApplied() {
    viewModel.refresh();
  }

  List<DateTime> dateRange = [];
  var viewModel;

  @override
  void initState() {
    viewModel = FaultViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FaultViewModel>.reactive(
      builder: (BuildContext context, FaultViewModel model, Widget _) {
        return Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InsiteText(
                          text: Utils.getDateInFormatddMMyyyy(
                                  viewModel.startDate) +
                              " - " +
                              Utils.getDateInFormatddMMyyyy(viewModel.endDate),
                          fontWeight: FontWeight.bold,
                          size: 12),
                      SizedBox(
                        width: 4,
                      ),
                      InsiteButton(
                        width: 90,
                        title: "Date Range",
                        bgColor: Theme.of(context).backgroundColor,
                        textColor: Theme.of(context).textTheme.bodyText1.color,
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
                      ),
                    ],
                  ),
                ),
                PageHeader(
                  isDashboard: false,
                  total: viewModel.totalCount,
                  screenType: ScreenType.HEALTH,
                  count: viewModel.faults.length,
                ),
                Expanded(
                  child: viewModel.loading
                      ? Container(child: InsiteProgressBar())
                      : viewModel.faults.isNotEmpty
                          ? ListView.builder(
                              controller: viewModel.scrollController,
                              itemCount: viewModel.faults.length,
                              padding:
                                  EdgeInsets.only(left: 12, right: 12, top: 4),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Fault fault = viewModel.faults[index];
                                return FaultListItem(
                                  fault: fault,
                                  onCallback: () {
                                    viewModel.onDetailPageSelected(fault);
                                  },
                                );
                              },
                            )
                          : EmptyView(
                              title: "No fault codes to display",
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
            viewModel.refreshing
                ? Center(
                    child: InsiteProgressBar(),
                  )
                : SizedBox()
          ],
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
