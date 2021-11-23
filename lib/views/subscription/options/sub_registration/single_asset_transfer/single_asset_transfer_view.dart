import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/insite_full_page_popup.dart';
import 'package:insite/views/subscription/options/sub_registration/reusable_autocomplete_search/reusable_autocomplete_search_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/date_picker_custom_widget.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'single_asset_transfer_view_model.dart';

class SingleAssetTransferView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var defaultCustomFieldValidator = MultiValidator([
    RequiredValidator(errorText: "This Field is Required"),
  ]);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetTransferViewModel>.reactive(
      builder: (BuildContext context, SingleAssetTransferViewModel viewModel,
          Widget _) {
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
                        text: 'SINGLE ASSET TRANSFER',
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.allowAssetTransferClicked();
                        },
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: viewModel.allowTransferAsset
                                        ? Theme.of(context).buttonColor
                                        : Theme.of(context).backgroundColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Icon(
                                  Icons.crop_square,
                                  color: viewModel.allowTransferAsset
                                      ? Theme.of(context).buttonColor
                                      : Colors.black,
                                  size: 20,
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Expanded(
                              child: InsiteText(
                                text:
                                    "Transfer Asset by retaining current Customer details",
                                fontWeight: FontWeight.w700,
                                size: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Form(
                        key: _formKey,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.80,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InsiteText(
                                            text: 'Asset Details:',
                                            size: 13,
                                            fontWeight: FontWeight.w700,
                                          ),
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
                                                        onChanged: (value) {
                                                          viewModel
                                                              .getDeviceIds(
                                                                  value);
                                                        },
                                                        data: viewModel
                                                            .gpsDeviceIdList,
                                                        onSelected:
                                                            (selectedValue) {
                                                          viewModel
                                                              .updateDeviceIdValues(
                                                                  selectedValue);

                                                          viewModel
                                                                  .allowTransferAsset
                                                              ? viewModel
                                                                  .getCustomerDetailValues(
                                                                      selectedValue)
                                                              : null;
                                                        },
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
                                                    text: 'Serial No.:',
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
                                                            .machineSerialNumberController,
                                                        onChanged: (value) {
                                                          viewModel
                                                              .getSerialNumbers(
                                                                  value);
                                                        },
                                                        data: viewModel
                                                            .serialNoList,
                                                        onSelected:
                                                            (selectedValue) {
                                                          viewModel
                                                              .updateSerialNumberValues(
                                                                  selectedValue);
                                                        },
                                                        validator:
                                                            defaultCustomFieldValidator,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Machine Model:',
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
                                                            .machineModelController,
                                                        isenabled: false,
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
                                                    text:
                                                        'Asset Commissioning Date:',
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
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                .color,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: CustomDatePicker(
                                                        controller: viewModel
                                                            .commisioningDateController,
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
                                                          lastDate:
                                                              DateTime.now()
                                                                  .subtract(
                                                            Duration(days: 0),
                                                          ),
                                                        ).then((value) {
                                                          viewModel
                                                              .getSelectedDate(
                                                                  value);
                                                        }),
                                                      )),
                                                ],
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
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Dealer Name:',
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
                                                          .dealerNameController,
                                                      onChanged: (value) {
                                                        viewModel
                                                            .getDealerNamesData(
                                                                name: value,
                                                                type: "DEALER");
                                                      },
                                                      data:
                                                          viewModel.dealerName,
                                                      onSelected:
                                                          (selectedValue) {
                                                        viewModel
                                                            .filterDealerDetails(
                                                                selectedValue);
                                                      },
                                                      validator:
                                                          defaultCustomFieldValidator,
                                                    ),
                                                  )
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
                                                    child:
                                                        ReusableAutocompleteSearchView(
                                                      reuseController: viewModel
                                                          .dealerCodeController,
                                                      onChanged: (value) {
                                                        viewModel
                                                            .getDealerNamesData(
                                                                code: int.parse(
                                                                    value),
                                                                type: "DEALER");
                                                      },
                                                      data:
                                                          viewModel.dealerCode,
                                                      onSelected:
                                                          (selectedValue) {
                                                        viewModel
                                                            .filterDealerDetails(
                                                                selectedValue);
                                                      },
                                                      validator:
                                                          defaultCustomFieldValidator,
                                                    ),
                                                  ),
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Dealer Email ID :',
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
                                                            .dealerEmailController,
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
                                                    text: 'Dealer Mobile No.:',
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
                                                            .dealerMobileNoController,
                                                        validator:
                                                            defaultCustomFieldValidator,
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
                                                text: 'SMS Languge',
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
                                                width: 130,
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
                                                  value:
                                                      viewModel.initialLanguge,
                                                  items: viewModel.languages,
                                                  onChanged: (value) {
                                                    viewModel
                                                        .updateLanguage(value);
                                                  },
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
                                                      onChanged: (value) {
                                                        viewModel
                                                            .getDealerNamesData(
                                                                name: value,
                                                                type:
                                                                    "CUSTOMER");
                                                      },
                                                      data:
                                                          viewModel.dealerName,
                                                      isEnabled: viewModel
                                                          .enableCustomerDetails,
                                                      onSelected:
                                                          (selectedValue) {
                                                        viewModel
                                                            .filterCustomerDeatails(
                                                                selectedValue);
                                                      },
                                                      validator:
                                                          defaultCustomFieldValidator,
                                                    ),
                                                  ),
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
                                                      isEnabled: viewModel
                                                          .enableCustomerDetails,
                                                      onChanged: (value) {
                                                        viewModel
                                                            .getDealerNamesData(
                                                                code: int.parse(
                                                                    value),
                                                                type:
                                                                    "CUSTOMER");
                                                      },
                                                      data:
                                                          viewModel.dealerCode,
                                                      onSelected:
                                                          (selectedValue) {
                                                        viewModel
                                                            .filterCustomerDeatails(
                                                                selectedValue);
                                                      },
                                                      validator:
                                                          defaultCustomFieldValidator,
                                                    ),
                                                  ),
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InsiteText(
                                                    text: 'Customer Email ID :',
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
                                                            .customerEmailController,
                                                        isenabled: viewModel
                                                            .enableCustomerDetails,
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
                                                    text:
                                                        'Customer Mobile No.:',
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
                                                            .customerMobileNoController,
                                                        isenabled: viewModel
                                                            .enableCustomerDetails,
                                                        validator:
                                                            defaultCustomFieldValidator,
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
                                                text: 'SMS Languge',
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
                                                width: 130,
                                                height: 29,
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
                                                  value: viewModel
                                                      .initialCustLanguge,
                                                  items: viewModel.languages,
                                                  isEnabled: viewModel
                                                      .enableCustomerDetails,
                                                  onChanged: (value) {
                                                    viewModel
                                                        .updateCustomerLanguage(
                                                            value);
                                                  },
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
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Divider(
                                      thickness: 1.5,
                                      color: thunder,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InsiteText(
                                            text: 'Industry Details:',
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
                                                    BorderRadius.circular(10)),
                                            child: CustomDropDownWidget(
                                              value: viewModel
                                                  .initialIndustryDetail,
                                              items: viewModel.industryDetails,
                                              onChanged: (value) {
                                                viewModel.updateIndustry(value);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),
                                          viewModel.showSubIndustry
                                              ? Container(
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
                                                    enableHint: false,
                                                    value:
                                                        'Select Secondary Details',
                                                    items: [
                                                      "Select Secondary Details"
                                                    ],
                                                    onChanged: (value) {},
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState.validate()) {
                                          viewModel.getTotalDataDetails();

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
                                                  final result = await viewModel
                                                      .subscriptionAssetTransfer();
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
      viewModelBuilder: () => SingleAssetTransferViewModel(),
    );
  }
}
