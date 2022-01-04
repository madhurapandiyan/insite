import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/insite_full_page_popup.dart';
import 'package:insite/views/subscription/options/sub_registration/single_asset_reg/custom_auto_complete_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/date_picker_custom_widget.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'single_asset_registration_view_model.dart';

class SingleAssetRegistrationView extends StatefulWidget {
  //final String status;
  SingleAssetRegistrationView({this.filterKey, this.filterType});
  final String? filterKey;
  final PLANTSUBSCRIPTIONFILTERTYPE? filterType;

  @override
  _SingleAssetRegistrationViewState createState() =>
      _SingleAssetRegistrationViewState();
}

class _SingleAssetRegistrationViewState
    extends State<SingleAssetRegistrationView> {
  final _formKey = GlobalKey<FormState>();

  var defaultCustomFieldValidator = MultiValidator([
    RequiredValidator(errorText: "This Field is Required"),
  ]);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetRegistrationViewModel>.reactive(
      builder: (BuildContext context,
          SingleAssetRegistrationViewModel viewModel, Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
              viewModel: viewModel,
              onFilterApplied: () {
                //viewModel.refresh();
              },
              onRefineApplied: () {
                //viewModel.refresh();
              },
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InsiteText(
                        text: 'SINGLE ASSET REGISTRATION',
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Form(
                        key: _formKey,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardColor,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              viewModel.serialNoList.isNotEmpty
                                                  ? SizedBox()
                                                  : CustomAutoCompleteWidget(
                                                      onChange: (value) {
                                                        viewModel
                                                            .getSubcriptionDeviceListData(
                                                                name: value);
                                                      },
                                                      textBoxTitle:
                                                          "Device ID:",
                                                      validator:
                                                          defaultCustomFieldValidator,
                                                      items:
                                                          viewModel.gpsDeviceId,
                                                      onSelect:
                                                          (selectedString) {
                                                        viewModel
                                                            .onSelectedDeviceId(
                                                                selectedString);
                                                      },
                                                      controller: viewModel
                                                          .deviceIdController,
                                                    ),
                                                    //SizedBox(width: 10,),
                                              viewModel.gpsDeviceId.isNotEmpty
                                                  ? SizedBox()
                                                  : CustomAutoCompleteWidget(
                                                      textBoxTitle:
                                                          "Serial No. :",
                                                      onChange: (value) {
                                                        viewModel
                                                            .getModelNamebySerialNumber(
                                                                value);
                                                      },
                                                      items:
                                                          viewModel.gpsDeviceId,
                                                      onSelect:
                                                          (selectedString) {
                                                        viewModel
                                                            .updateDeviceId(
                                                                selectedString);
                                                      },
                                                      controller: viewModel
                                                          .serialNumberController)
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InsiteText(
                                                text: 'Select Asset Model:',
                                                size: 13,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color!,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: CustomDropDownWidget(
                                                  value: viewModel.assetModel ==
                                                          null
                                                      ? " "
                                                      : viewModel.assetModel,
                                                  items: viewModel.modelNames,
                                                  // enableHint: false,
                                                  onChanged: (String? value) {
                                                    viewModel.updateModelValue(
                                                        value!);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Hour Meter Date:',
                                                    size: 13,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                  ),
                                                  Container(
                                                    //height: 35,
                                                    width: 130,
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .color!,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: CustomDatePicker(
                                                      controller: viewModel
                                                          .hourMeterDateController,
                                                      voidCallback: () =>
                                                          showDatePicker(
                                                        context: context,
                                                        initialDate: viewModel
                                                                    .pickedDate ==
                                                                null
                                                            ? DateTime.now()
                                                            : viewModel
                                                                .pickedDate!,
                                                        firstDate: DateTime
                                                                .now()
                                                            .subtract(Duration(
                                                                days: 1000)),
                                                        lastDate: DateTime.now()
                                                            .subtract(
                                                          Duration(days: 0),
                                                        ),
                                                      ).then((value) {
                                                        viewModel
                                                            .getSelectedDate(
                                                                value);
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Hour Meter:',
                                                    size: 13,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                  ),
                                                  Container(
                                                      height: 35,
                                                      width: 130,
                                                      child: CustomTextBox(
                                                        controller: viewModel
                                                            .hourMeterController,
                                                        textInputFormat: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InsiteText(
                                                text: 'Plant Details:',
                                                size: 13,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color!,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: CustomDropDownWidget(
                                                  value: viewModel.plantDetail,
                                                  items: viewModel.plantDetails,
                                                  enableHint: false,
                                                  onChanged: (value) {
                                                    viewModel.updateplantDEtail(
                                                        value);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.5,
                                      color: thunder,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          InsiteText(
                                              text: 'Dealer Details:',
                                              size: 13,
                                              fontWeight: FontWeight.w700),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              viewModel.dealerCode.isNotEmpty
                                                  ? SizedBox()
                                                  : CustomAutoCompleteWidget(
                                                      controller: viewModel
                                                          .deviceNameController,
                                                      onSelect: (value) {
                                                        viewModel
                                                            .onSelectedDealerNameTile(
                                                                value!);
                                                      },
                                                      items: viewModel.dealerId,
                                                      textBoxTitle:
                                                          'Dealer Name:',
                                                      onChange: (value) {
                                                        viewModel
                                                            .onDealerNameChanges(
                                                                name: value,
                                                                type: "DEALER");
                                                      },
                                                    ),
                                              viewModel.dealerId.isNotEmpty
                                                  ? SizedBox()
                                                  : CustomAutoCompleteWidget(
                                                      isAlign: false,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller: viewModel
                                                          .deviceCodeController,
                                                      onSelect: (value) {
                                                        viewModel
                                                            .onSelectedDealerCodeTile(
                                                                value!);
                                                      },
                                                      items:
                                                          viewModel.dealerCode,
                                                      textBoxTitle:
                                                          'Dealer Code:',
                                                      onChange: (value) {
                                                        viewModel
                                                            .onDealerCodeChanges(
                                                                code: int.parse(
                                                                    value),
                                                                type: "DEALER");
                                                      },
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InsiteText(
                                                text: 'Dealer Email ID:',
                                                size: 13,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 35,
                                                child: CustomTextBox(
                                                  controller: viewModel
                                                      .deviceEmailController,
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.5,
                                      color: thunder,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          InsiteText(
                                              text: 'Customer Details:',
                                              size: 13,
                                              fontWeight: FontWeight.w700),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              viewModel.customerCode.isNotEmpty
                                                  ? SizedBox()
                                                  : CustomAutoCompleteWidget(
                                                      controller: viewModel
                                                          .customerNameController,
                                                      onSelect: (value) {
                                                        viewModel
                                                            .onSelectedNameTile(
                                                                value!);
                                                        //FocusNode().unfocus();
                                                      },
                                                      items:
                                                          viewModel.customerId,
                                                      textBoxTitle:
                                                          "Customer Name",
                                                      onChange: (value) {
                                                        viewModel
                                                            .onCustomerNameChanges(
                                                                name: value,
                                                                type:
                                                                    "CUSTOMER");
                                                      },
                                                    ),
                                              viewModel.customerId.isNotEmpty
                                                  ? SizedBox()
                                                  : CustomAutoCompleteWidget(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      isAlign: false,
                                                      onSelect: (value) {
                                                        viewModel
                                                            .onSelectedCodeTile(
                                                                value!);
                                                      },
                                                      controller: viewModel
                                                          .customerCodeController,
                                                      items: viewModel
                                                          .customerCode,
                                                      textBoxTitle:
                                                          'Customer Code:',
                                                      onChange: (value) {
                                                        viewModel
                                                            .onCustomerCodeChanges(
                                                                code: int.parse(
                                                                    value),
                                                                type:
                                                                    "CUSTOMER");
                                                      },
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InsiteText(
                                                text: 'Customer Email ID:',
                                                size: 13,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 35,
                                                child: CustomTextBox(
                                                  controller: viewModel
                                                      .customerEmailController,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (viewModel
                                            .deviceIdController.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                          return;
                                        } else if (viewModel.assetModel ==
                                            "Select Asset Model") {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                          return;
                                        } else if (viewModel
                                                .customerNameController
                                                .text
                                                .isNotEmpty &&
                                            viewModel.deviceNameController.text
                                                .isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                          return;
                                        } else if (viewModel
                                                .customerEmailController
                                                .text
                                                .isNotEmpty &&
                                            viewModel.deviceEmailController.text
                                                .isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                        } else if (viewModel
                                                .customerCodeController
                                                .text
                                                .isNotEmpty &&
                                            viewModel.deviceCodeController.text
                                                .isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                        } else if (viewModel
                                            .serialNumberController
                                            .text
                                            .isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                          return;
                                        } else {
                                          viewModel.getTotalDataDetails();

                                          Logger().wtf(
                                              ' datalength: ${viewModel.totalList}');

                                          await showGeneralDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            transitionDuration:
                                                Duration(milliseconds: 500),
                                            transitionBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: ScaleTransition(
                                                  scale: animation,
                                                  child: child,
                                                ),
                                              );
                                            },
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return InsitePopUp(
                                                onPop: () {
                                                  Logger().e("running");
                                                  viewModel.onPop();
                                                },
                                                pageTitle: "Preview",
                                                titles:
                                                    viewModel.popUpCardTitles,
                                                data: viewModel.totalList,
                                                onButtonTapped: () async {
                                                  final result = await viewModel
                                                      .subscriptionAssetRegistration();
                                                  if (result != null) {
                                                    Utils.showToast(Utils
                                                        .suceessRegistration);
                                                  }
                                                },
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: InsiteButton(
                                        title: 'PREVIEW',
                                        textColor: white,
                                        margin: EdgeInsets.all(20),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        );
      },
      viewModelBuilder: () =>
          SingleAssetRegistrationViewModel(widget.filterKey, widget.filterType),
    );
  }
}

mixin ReusableAutocompleteSearchViewState {}
