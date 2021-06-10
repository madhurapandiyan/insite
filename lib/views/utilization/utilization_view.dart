import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/views/utilization/tabs/graph_view/utilization_graph_view.dart';
import 'package:insite/views/utilization/tabs/list/utilization_list_view.dart';
import 'package:insite/views/utilization/utilization_view_model.dart';
import 'package:insite/widgets/dumb_widgets/toggle_button.dart';
import 'package:insite/widgets/smart_widgets/date_range.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class UtilLizationView extends StatefulWidget {
  @override
  _UtilLizationViewState createState() => _UtilLizationViewState();
}

class _UtilLizationViewState extends State<UtilLizationView> {
  bool isListSelected = true;
  int rangeChoice = 1;
  String startDate = DateFormat('MM/dd/yyyy')
      .format(DateTime.now().subtract(Duration(days: DateTime.now().weekday)));
  String endDate = DateFormat('MM/dd/yyyy').format(DateTime.now());
  List<DateTime> dateRange = [];

  UtilizationGraphType graphType = UtilizationGraphType.IDLEORWORKING;

  bool isRangeSelectionVisible = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilLizationViewModel>.reactive(
        builder:
            (BuildContext context, UtilLizationViewModel viewModel, Widget _) {
          return InsiteScaffold(
            screenType: ScreenType.UTILIZATION,
            viewModel: viewModel,
            body: Container(
              color: bgcolor,
              child: Container(
                decoration: BoxDecoration(
                  color: mediumgrey,
                  border: Border.all(color: black, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          ToggleButton(
                              label1: 'list',
                              label2: 'graph',
                              optionSelected: (bool value) {
                                setState(() {
                                  isListSelected = value;
                                });
                              }),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              dateRange = [];

                              dateRange = await showDialog(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                    backgroundColor: transparent,
                                    child: DateRangeWidget()),
                              );

                              setState(() {
                                if (dateRange.isNotEmpty) {
                                  startDate = DateFormat('MM/dd/yyyy')
                                      .format(dateRange.first);

                                  endDate = DateFormat('MM/dd/yyyy')
                                      .format(dateRange.last);
                                }
                              });

                              print('@@@ After start date: $startDate');
                              print('@@@ After end date: $endDate');
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
                    isListSelected
                        ? UtilizationListView(dateRange: dateRange)
                        : Expanded(
                            child: UtilizationGraphView(
                              startDate: startDate,
                              endDate: endDate,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => UtilLizationViewModel(true));
  }
}

enum UtilizationGraphType {
  IDLEORWORKING,
  RUNTIMEHOURS,
  DISTANCETRAVELLED,
  CUMULATIVE,
  TOTALHOURS,
  TOTALFUELBURNED,
  IDLETREND,
  FUELBURNRATETREND
}
