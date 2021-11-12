import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'report_summary_view_model.dart';
          
class ReportSummaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportSummaryViewModel>.reactive(
      builder: (BuildContext context, ReportSummaryViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('ReportSummary View'),
          ),
        );
      },
      viewModelBuilder: () => ReportSummaryViewModel(),
    );
  }
}
