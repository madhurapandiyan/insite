import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/health_list_response.dart';
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
  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<HealthListViewModel>.reactive(
      builder: (BuildContext context, HealthListViewModel viewModel, Widget _) {
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: viewModel.healthListDataLoading
                  ? Container(child: Center(child: CircularProgressIndicator()))
                  : viewModel.faults.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: viewModel.faults.length,
                          itemBuilder: (context, index) {
                            Fault faultElement = viewModel.faults[index];
                            return HealthListItem(
                              faultElement: faultElement,
                            );
                          },
                        )
                      : EmptyView(
                          title: "No Assets Found",
                        ),
            )
          ],
        );
      },
      viewModelBuilder: () => HealthListViewModel(widget.detail),
    );
  }
}
