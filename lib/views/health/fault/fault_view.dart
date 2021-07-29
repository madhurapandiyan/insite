import 'package:flutter/material.dart';
import 'package:insite/views/health/fault/fault_view_model.dart';
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
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FaultListItem();
                },
              ),
            ),
          ],
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
