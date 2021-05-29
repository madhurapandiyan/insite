import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'single_asset_operation_view_model.dart';

class SingleAssetOperationView extends StatefulWidget {
  SingleAssetOperationView({Key key}) : super(key: key);

  @override
  _SingleAssetOperationViewState createState() =>
      _SingleAssetOperationViewState();
}

class _SingleAssetOperationViewState extends State<SingleAssetOperationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetOperationViewModel>.reactive(
      builder: (BuildContext context, SingleAssetOperationViewModel viewModel,
          Widget _) {
        return Container(
          child: Center(
            child: Text('SingleAssetOperation View'),
          ),
        );
      },
      viewModelBuilder: () => SingleAssetOperationViewModel(),
    );
  }
}
