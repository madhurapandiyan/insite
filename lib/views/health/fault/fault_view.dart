import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/views/health/fault/fault_view_model.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/fault_list_item.dart';
import 'package:stacked/stacked.dart';

class FaultView extends StatefulWidget {
  FaultView({Key key}) : super(key: key);

  @override
  FaultViewState createState() => FaultViewState();
}

class FaultViewState extends State<FaultView> {
  onFilterApplied() {
    // viewModel.refresh();
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
        return Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Expanded(
              child: model.loading
                  ? Container(child: Center(child: CircularProgressIndicator()))
                  : model.faults.isNotEmpty
                      ? ListView.builder(
                          itemCount: model.faults.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Fault fault = model.faults[index];
                            return FaultListItem(
                              fault: fault,
                              onCallback: () {
                                viewModel.onDetailPageSelected(fault);
                              },
                            );
                          },
                        )
                      : EmptyView(
                          title: "No Assets Found",
                        ),
            ),
          ],
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
