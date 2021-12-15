import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:load/load.dart';
import 'package:stacked/stacked.dart';

import 'single_asset_form_widget/single_asset_form_widget.dart';
import 'single_asset_validate_widget/single_asset_validate_widget.dart';
import 'sms_schedule_single_asset_view_model.dart';

class SmsScheduleSingleAssetView extends StatefulWidget {
  @override
  _SmsScheduleSingleAssetViewState createState() =>
      _SmsScheduleSingleAssetViewState();
}

class _SmsScheduleSingleAssetViewState
    extends State<SmsScheduleSingleAssetView> {
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
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(
                              width: 1,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.02,
                        decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  viewModel.singleAssetModelResponce.isEmpty
                      ? SingleAssetFormWidget(
                          mobileNoController: viewModel.mobileNoController,
                          nameController: viewModel.nameController,
                          onSaving: viewModel.onSavingForm,
                          serialNoController: viewModel.serialNoController)
                      : Column(
                          children: [
                            Column(
                              children: List.generate(
                                  viewModel.singleAssetModelResponce.length,
                                  (i) {
                                final model =
                                    viewModel.singleAssetModelResponce;
                                return model.isEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 90,
                                          ),
                                          Center(
                                              child: EmptyView(
                                            title: "No Result Found",
                                          )),
                                        ],
                                      )
                                    : SingleAssetValidateWidget(
                                        GPSDeviceID: model[0].GPSDeviceID,
                                        SerialNumber: model[0].SerialNumber,
                                        StartDate: model[0].StartDate,
                                        model: model[0].Model,
                                        langugae: viewModel.language,
                                        modileNo: viewModel.mobileNo,
                                        name: viewModel.name);
                              }),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            viewModel.singleAssetModelResponce.isEmpty
                                ? SizedBox()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InsiteButton(
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                        onTap: () {
                                          viewModel.onBackPressed();
                                        },
                                        bgColor: white,
                                        title: "Back",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                      InsiteButton(
                                        onTap: () async {
                                          showLoadingDialog();
                                          List status = await viewModel
                                              .onSavingSmsModel();
                                          if (status.isEmpty) {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .backgroundColor,
                                                      content: InsiteText(
                                                          text:
                                                              "Moblie number Updated successfully!!!."
                                                          //"Moblie number Updated successfully!!!.",
                                                          ),
                                                    )
                                                // dialogWidget(
                                                //     dialogCtx: ctx,
                                                //     content:
                                                //         ,
                                                //     ctx: context,
                                                //     onPress: viewModel
                                                //         .onClosingDialog())
                                                );
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .backgroundColor,
                                                      content: InsiteText(
                                                          text:
                                                              "Serial number, Mobile number, Language and Recipient’s Name combination is already exists. Do you want to download?"
                                                          //"Moblie number Updated successfully!!!.",
                                                          ),
                                                    )

                                                // dialogWidget(
                                                //       dialogCtx: ctx,
                                                //       ctx: context,
                                                //       onPress: viewModel
                                                //           .onClosingDialog(),
                                                //       content:
                                                //           ,
                                                //     ));
                                                );
                                          }
                                        },
                                        textColor: white,
                                        title: viewModel
                                                .singleAssetModelResponce
                                                .isEmpty
                                            ? "Next"
                                            : "Register",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                    ],
                                  )
                          ],
                        )
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

Widget dialogWidget(
    {String content,
    BuildContext ctx,
    Function onPress,
    BuildContext dialogCtx}) {
  return AlertDialog(
    backgroundColor: Theme.of(ctx).backgroundColor,
    content: InsiteText(text: content
        //"Moblie number Updated successfully!!!.",
        ),
  );
}
