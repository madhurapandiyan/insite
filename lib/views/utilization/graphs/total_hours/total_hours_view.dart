import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:insite/widgets/smart_widgets/total_hours_chart.dart';
import 'package:stacked/stacked.dart';
import 'total_hours_view_model.dart';

class TotalHoursView extends StatefulWidget {
  final String startDate;
  final String endDate;
  const TotalHoursView({Key key, this.startDate, this.endDate})
      : super(key: key);

  @override
  TotalHoursViewState createState() => TotalHoursViewState();
}

class TotalHoursViewState extends State<TotalHoursView> {
  int rangeChoice = 1;
  List<String> rangeTexts = ['daily', 'weekly', 'monthly'];
  var viewModel;
  @override
  void initState() {
    viewModel = TotalHoursViewModel(widget.startDate, widget.endDate);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  refresh(String startDate, String endDate) {
    viewModel.updateDate(startDate, endDate);
    viewModel.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TotalHoursViewModel>.reactive(
      builder: (BuildContext context, TotalHoursViewModel viewModel, Widget _) {
        if (viewModel.loading) return Center(child: CircularProgressIndicator());
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RangeSelectionWidget(
                          label1: 'Day',
                          label2: 'Week',
                          label3: 'month',
                          rangeChoice: (int choice) {
                            setState(() {
                              rangeChoice = choice;
                              viewModel.range = rangeTexts[rangeChoice - 1];
                              viewModel.getTotalHours();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: UtilizationLegends(
                          label1: 'Working',
                          label2: 'Idle',
                          label3: 'Runtime',
                          color1: emerald,
                          color2: burntSienna,
                          color3: creamCan,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TotalHoursChart(
                      rangeSelection: rangeChoice,
                      totalHours: viewModel.totalHours),
                ),
              ],
            ),
            viewModel.isRefreshing
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
