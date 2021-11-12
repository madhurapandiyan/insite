import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'sms_schedule_multi_asset_view_model.dart';
          
class SmsScheduleMultiAssetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SmsScheduleMultiAssetViewModel>.reactive(
      builder: (BuildContext context, SmsScheduleMultiAssetViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('SmsScheduleMultiAsset View'),
          ),
        );
      },
      viewModelBuilder: () => SmsScheduleMultiAssetViewModel(),
    );
  }
}
