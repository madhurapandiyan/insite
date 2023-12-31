import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
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
import 'single_asset_transfer_view_model.dart';

class SingleAssetTransferView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetTransferViewModel>.reactive(
      builder: (BuildContext context, SingleAssetTransferViewModel viewModel,
          Widget? _) {
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
                                         border: Border.all(color: viewModel.allowTransferAsset
                                        ? Theme.of(context).backgroundColor
                                        :  Colors.black
                                         ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Icon(
                                  Icons.check,
                                  color:
                                  //  viewModel.allowTransferAsset
                                  //     ? Theme.of(context).buttonColor
                                  //     :
                                       Colors.white,
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
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomAutoCompleteWidget(
                                                isShowingBorderColor: false,
                                                isShowingHelperText: viewModel
                                                    .gpsDeviceIdList.isEmpty,
                                                controller: viewModel
                                                    .deviceIdController,
                                                onSelect: (value) {
                                                  viewModel.onSelectedDeviceId(
                                                      value!);
                                                },
                                                items:
                                                    viewModel.gpsDeviceIdList,
                                                textBoxTitle: 'Device ID:',
                                                onChange: (value) {
                                                  viewModel.getDeviceIds(value);
                                                },
                                                isShowing: viewModel
                                                    .gpsDeviceIdList.isEmpty,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomAutoCompleteWidget(
                                                isShowingBorderColor: false,
                                                isShowingHelperText: viewModel
                                                    .serialNoList.isEmpty,
                                                isShowing: viewModel
                                                    .serialNoList.isEmpty,
                                                isAlign: false,
                                                controller: viewModel
                                                    .machineSerialNumberController,
                                                onSelect: (value) {
                                                  viewModel.onSelectedSerialNo(
                                                      value!);
                                                },
                                                items: viewModel.serialNoList,
                                                textBoxTitle: 'Serial No.:',
                                                onChange: (value) {
                                                  viewModel
                                                      .getSerialNumbers(value);
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
                                                      width: 130,
                                                      child: CustomTextBox(
                                                        controller: viewModel
                                                            .machineModelController,
                                                       // isenabled: false,
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
                                                      // height: 35,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .color!,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: CustomDatePicker(
                                                        userPreference: viewModel.userPref,
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
                                                                  .pickedDate!,
                                                          firstDate:
                                                              DateTime(2000),
                                                          lastDate:
                                                              DateTime.now(),
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
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomAutoCompleteWidget(
                                                isShowingBorderColor: false,
                                                isShowingHelperText:viewModel.transDealerNameChange==true,
                                                //  viewModel
                                                //         .dealerNameChange
                                                //         ?.result?[0]
                                                //         .first
                                                //         .count ==
                                                //     0,
                                                helperText: "New Dealer Name",
                                                isShowing:
                                                    viewModel.dealerId.isEmpty,
                                                controller: viewModel
                                                    .dealerNameController,
                                                onSelect: (value) {
                                                  viewModel
                                                      .onSelectedDealerNameTile(
                                                          value!);
                                                },
                                                items: viewModel.dealerId.toSet().toList(),
                                                textBoxTitle: 'Dealer Name:',
                                                onChange: (value) {
                                                  viewModel.onDealerNameChanges(
                                                      name: value,
                                                      type: "DEALER");
                                                },
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomAutoCompleteWidget(
                                                isShowingBorderColor: false,
                                                helperText: "New Dealer Code",
                                                isShowingHelperText: viewModel.transDealerCodeChange==true,
                                                // viewModel
                                                //         .dealerCodeChange
                                                //         ?.result?[0]
                                                //         .first
                                                //         .count ==
                                                //     0,
                                                isShowing: viewModel
                                                    .dealerCode.isEmpty,
                                                isAlign: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: viewModel
                                                    .dealerCodeController,
                                                onSelect: (value) {
                                                  viewModel
                                                      .onSelectedDealerCodeTile(
                                                          value!);
                                                },
                                                items: viewModel.dealerCode,
                                                textBoxTitle: 'Dealer Code:',
                                                onChange: (value) {
                                                  viewModel.onDealerCodeChanges(
                                                      code: value,
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
                                                      child: CustomTextBox(
                                                    controller: viewModel
                                                        .dealerEmailController,
                                                  )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
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
                                                      child: CustomTextBox(
                                                    controller: viewModel
                                                        .dealerMobileNoController,
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
                                                  value:
                                                      viewModel.initialLanguge,
                                                  items: viewModel.languages,
                                                  onChanged: (value) {
                                                    viewModel
                                                        .updateLanguage(value!);
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
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomAutoCompleteWidget(
                                                isShowingBorderColor: false,
                                                //viewModel
                                                  //  .allowTransferAsset,
                                                helperText: "New Customer Name",
                                                isShowingHelperText: viewModel.transCustomerNameChange==true,
                                                // viewModel
                                                //         .customerNameChange
                                                //         ?.result?[0]
                                                //         .first
                                                //         .count ==
                                                //     0,
                                                isShowing: viewModel
                                                    .customerId.isEmpty,
                                                isEnable: !viewModel
                                                    .allowTransferAsset,
                                                controller: viewModel
                                                    .customerNameController,
                                                onSelect: (value) {
                                                  viewModel.onSelectedNameTile(
                                                      value!);
                                                },
                                                items: viewModel.customerId.toSet().toList(),
                                                textBoxTitle: "Customer Name",
                                                onChange: (value) {
                                                  viewModel
                                                      .onCustomerNameChanges(
                                                          name: value,
                                                          type: "CUSTOMER");
                                                },
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomAutoCompleteWidget(
                                                isShowingBorderColor:false,
                                                //  viewModel
                                                //     .allowTransferAsset,
                                                helperText: "New Customer Code",
                                                isShowingHelperText:viewModel.transCustomerCodeChange ==true,
                                                // viewModel
                                                //         .customerCodeChange
                                                //         ?.result?[0]
                                                //         .first
                                                //         .count ==
                                                //     0,
                                                isShowing: viewModel
                                                    .customerCode.isEmpty,
                                                isEnable: !viewModel
                                                    .allowTransferAsset,
                                                keyboardType:
                                                    TextInputType.number,
                                                isAlign: false,
                                                onSelect: (value) {
                                                  viewModel.onSelectedCodeTile(
                                                      value!);
                                                },
                                                controller: viewModel
                                                    .customerCodeController,
                                                items: viewModel.customerCode,
                                                textBoxTitle: 'Customer Code:',
                                                onChange: (value) {
                                                  viewModel
                                                      .onCustomerCodeChanges(
                                                          code:value,
                                                              // int.parse(value),
                                                          type: "CUSTOMER");
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
                                                    // color: viewModel
                                                    //         .allowTransferAsset
                                                    //     ? Theme.of(context)
                                                    //         .backgroundColor
                                                    //     : Theme.of(context)
                                                    //         .textTheme
                                                    //         .bodyText1!
                                                    //         .color!,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                  ),
                                                  Container(
                                                      child: CustomTextBox(
                                                    isShowingBorderColor:false,
                                                        // viewModel
                                                        //     .allowTransferAsset,
                                                    controller: viewModel
                                                        .customerEmailController,
                                                    isenabled: !viewModel
                                                        .allowTransferAsset,
                                                  )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
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
                                                    // color: viewModel
                                                    //         .allowTransferAsset
                                                    //     ? Theme.of(context)
                                                    //         .backgroundColor
                                                    //     : Theme.of(context)
                                                    //         .textTheme
                                                    //         .bodyText1!
                                                    //         .color!,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                  ),
                                                  Container(
                                                      child: CustomTextBox(
                                                    isShowingBorderColor:false,
                                                        // viewModel
                                                        //     .allowTransferAsset,
                                                    controller: viewModel
                                                        .customerMobileNoController,
                                                    isenabled: !viewModel
                                                        .allowTransferAsset,
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
                                                // color:
                                                //     viewModel.allowTransferAsset
                                                //         ? Theme.of(context)
                                                //             .backgroundColor
                                                //         : Theme.of(context)
                                                //             .textTheme
                                                //             .bodyText1!
                                                //             .color!,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: 
                                                      // viewModel.allowTransferAsset
                                                      //     ? Theme.of(context)
                                                      //         .backgroundColor : 
                                                              Theme.of(context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .color!,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: CustomDropDownWidget(
                                                  // textColorChange: viewModel
                                                  //     .allowTransferAsset,
                                                  value: viewModel
                                                      .initialCustLanguge,
                                                  items: viewModel.languages,
                                                  istappable: !viewModel
                                                      .allowTransferAsset,
                                                  onChanged: (value) {
                                                    viewModel
                                                        .updateCustomerLanguage(
                                                            value!);
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
                                            //height: 35,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color!,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: CustomDropDownWidget(
                                              // istappable:
                                              //     !viewModel.allowTransferAsset,
                                              value: viewModel
                                                  .initialIndustryDetail,
                                              items: viewModel.industryDetails,
                                              onChanged: (value) {
                                                viewModel
                                                    .updateIndustry(value!);
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
                                                            .bodyText1!
                                                            .color!,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: CustomDropDownWidget(
                                                    // istappable: !viewModel
                                                    //     .allowTransferAsset,
                                                    value: viewModel
                                                        .initialSubIndustryDetailValue,
                                                    items: viewModel
                                                        .industrySubDetails,
                                                    onChanged: (value) {
                                                      viewModel
                                                          .onSelectingSubIndustry(
                                                              value!);
                                                    },
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (viewModel.dealerCodeController.text
                                                .isEmpty &&
                                            viewModel.dealerNameController.text
                                                .isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                          return;
                                        }
                                        if (viewModel.machineModelController
                                            .text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Machine model must not be null");
                                          return;
                                        }
                                        if (viewModel.dealerMobileNoController
                                            .text.isNotEmpty) {
                                          if (viewModel.dealerMobileNoController
                                                      .text.length >
                                                  10 ||
                                              viewModel.dealerMobileNoController
                                                      .text.length <
                                                  10) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please check the Mobile number!!!");
                                            return;
                                          }
                                        }
                                        if (viewModel.customerMobileNoController
                                            .text.isNotEmpty) {
                                          if (viewModel
                                                      .customerMobileNoController
                                                      .text
                                                      .length >
                                                  10 ||
                                              viewModel
                                                      .customerMobileNoController
                                                      .text
                                                      .length <
                                                  10) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please check the Mobile number!!!");
                                            return;
                                          }
                                        }
                                        if (viewModel
                                            .deviceIdController.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                          return;
                                        } else if (viewModel
                                            .machineSerialNumberController
                                            .text
                                            .isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                          return;
                                        } else if (viewModel
                                                .customerNameController
                                                .text
                                                .isNotEmpty &&
                                            viewModel.dealerNameController.text
                                                .isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                          return;
                                        } else if (viewModel
                                                .customerCodeController
                                                .text
                                                .isNotEmpty &&
                                            viewModel.dealerCodeController.text
                                                .isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please fill the * required fields and Entity details.");
                                          return;
                                        } else if (viewModel
                                                .customerEmailController
                                                .text
                                                .isNotEmpty &&
                                            viewModel.dealerEmailController.text
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
                                            pageBuilder: (context1, animation,
                                                secondaryAnimation) {
                                              return InsitePopUp(
                                                onPop: () {
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
                                                    viewModel.onPop();
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
