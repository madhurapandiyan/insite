import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/insite_full_page_popup.dart';
import 'package:insite/views/subscription/options/sub_registration/reusable_autocomplete_search/base_autocomplete.dart';
import 'package:insite/views/subscription/options/sub_registration/reusable_autocomplete_search/reusable_autocomplete_search_view.dart';
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
  final String filterKey;
  final PLANTSUBSCRIPTIONFILTERTYPE filterType;

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
          SingleAssetRegistrationViewModel viewModel, Widget _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters.length,
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
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Device ID:',
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
                                                      child:
                                                          ReusableAutocompleteSearchView(
                                                        reuseController: viewModel
                                                            .deviceIdController,
                                                        onSelected:
                                                            (selectedString) {
                                                          viewModel
                                                              .updateDeviceId(
                                                                  selectedString);
                                                        },
                                                        data: viewModel
                                                            .gpsDeviceId,
                                                        validator:
                                                            defaultCustomFieldValidator,
                                                      )),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Serial No.*:',
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
                                                              .serialNumberController,
                                                          onChanged: (value) {
                                                            viewModel
                                                                .getModelNamebySerialNumber(
                                                                    value);
                                                          },
                                                          validator:
                                                              defaultCustomFieldValidator)),
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
                                                          .bodyText1
                                                          .color,
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
                                                  enableHint: false,
                                                  onChanged: (String value) {
                                                    viewModel.updateModelValue(
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
                                                    height: 35,
                                                    width: 130,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .color,
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
                                                                .pickedDate,
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
                                                          validator:
                                                              defaultCustomFieldValidator)),
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
                                                          .bodyText1
                                                          .color,
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
                                              text: 'Device Details:',
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
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Device Name:',
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
                                                            .deviceNameController,
                                                        onChanged: (value) {
                                                          viewModel
                                                              .getSubcriptionDeviceListPerNameOrCode(
                                                                  name: value,
                                                                  type:
                                                                      "DEALER");
                                                        },
                                                        validator:
                                                            defaultCustomFieldValidator),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Dealer Code:',
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
                                                              .deviceCodeController,
                                                          onChanged: (value) {
                                                            viewModel
                                                                .getSubcriptionDeviceListPerNameOrCode(
                                                                    name: value,
                                                                    type:
                                                                        "DEALER");
                                                          },
                                                          validator:
                                                              defaultCustomFieldValidator)),
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
                                                  validator:
                                                      defaultCustomFieldValidator,
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
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Customer Name:',
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
                                                      child:
                                                          ReusableAutocompleteSearchView(
                                                        reuseController: viewModel
                                                            .customerNameController,
                                                        onSelected:
                                                            (selectedString) {
                                                          viewModel
                                                              .filterCustomerDetails(
                                                                  selectedString);
                                                        },
                                                        onChanged: (value) {
                                                          viewModel
                                                              .getSubcriptionListOfNameAndCode(
                                                                  name: value,
                                                                  type:
                                                                      "CUSTOMER");
                                                        },
                                                        data: viewModel
                                                            .customerCode,
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return "required";
                                                          }
                                                          return null;
                                                        },
                                                      )),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Customer Code:',
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
                                                      child:
                                                          ReusableAutocompleteSearchView(
                                                        reuseController: viewModel
                                                            .customerCodeController,
                                                        onSelected:
                                                            (selectedString) {
                                                          viewModel
                                                              .updateSelectedCode(
                                                                  selectedString);
                                                          viewModel
                                                              .filterCustomerDetails(
                                                                  viewModel
                                                                      .customerCodeController
                                                                      .text);
                                                        },
                                                        onChanged: (value) {
                                                          viewModel
                                                              .getSubcriptionListOfNameAndCode(
                                                                  code:
                                                                      int.parse(
                                                                          value),
                                                                  type:
                                                                      "CUSTOMER");
                                                        },
                                                        data: viewModel
                                                            .customerCode,
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return "required";
                                                          }
                                                          return null;
                                                        },
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
                                                  validator:
                                                      defaultCustomFieldValidator,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState.validate()) {
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
                                                pageTitle: "Preview",
                                                titles:
                                                    viewModel.popUpCardTitles,
                                                data: viewModel.totalList,
                                                onButtonTapped: () async {
                                                  await viewModel
                                                      .subscriptionAssetRegistration();
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
