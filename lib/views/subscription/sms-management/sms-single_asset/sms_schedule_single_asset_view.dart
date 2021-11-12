import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'single_asset_form_widget/singleasseformwidget.dart';
import 'single_asset_validate_widget/single_asset_validate_widget.dart';
import 'sms_schedule_single_asset_view_model.dart';

class SmsScheduleSingleAssetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SmsScheduleSingleAssetViewModel>.reactive(
      builder: (BuildContext context, SmsScheduleSingleAssetViewModel viewModel,
          Widget _) {
        return InsiteScaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InsiteText(
                    size: 18,
                    fontWeight: FontWeight.bold,
                    text: "SMS SCHEDULE FOR\nSINGLE ASSET",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InsiteText(
                          size: 18,
                          fontWeight: FontWeight.bold,
                          text: "1. Enter Details",
                        ),
                        InsiteText(
                          size: 18,
                          fontWeight: FontWeight.bold,
                          text: "2. Validate & Subscribe\nfor scheduled SMS",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.02,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: tuna),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.02,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: tango),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  !viewModel.dummy?
                  SingleAssetFormWidget(viewModel.onSavingForm):SingleAssetValidateWidget()
                ],
              ),
            ),
          ),
          viewModel: SmsScheduleSingleAssetViewModel(),
        );
      },
      viewModelBuilder: () => SmsScheduleSingleAssetViewModel(),
    );
  }
}
