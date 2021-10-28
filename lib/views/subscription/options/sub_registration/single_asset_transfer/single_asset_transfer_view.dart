import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/date_picker_custom_widget.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'single_asset_transfer_view_model.dart';

class SingleAssetTransferView extends StatelessWidget {
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
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                // color: viewModel.allowAccessToSecurity
                                //     ? Theme.of(context).buttonColor
                                //     : Theme.of(context).backgroundColor,
                                color: Theme.of(context).buttonColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Icon(
                              Icons.crop_square,
                              // color: viewModel.allowAccessToSecurity
                              //     ? Theme.of(context).buttonColor
                              //     : Colors.black,
                              color: Theme.of(context).buttonColor,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Card(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.70,
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
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
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
                                                  child: CustomDatePicker()),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      InsiteText(
                                          text: 'Dealer Details:',
                                          size: 13,
                                          fontWeight: FontWeight.w700),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.005,
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                                0.005,
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
                                                    BorderRadius.circular(10)),
                                            child: CustomDropDownWidget(
                                              value: '',
                                              items: [],
                                              onChanged: (value) {},
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      InsiteText(
                                          text: 'Customer Details:',
                                          size: 13,
                                          fontWeight: FontWeight.w700),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.005,
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InsiteText(
                                                text: 'Customer Mobile No.:',
                                                size: 13,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              Container(
                                                  height: 29,
                                                  width: 130,
                                                  child: CustomTextBox()),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                                0.005,
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
                                                    BorderRadius.circular(10)),
                                            child: CustomDropDownWidget(
                                              value: '',
                                              items: [],
                                              onChanged: (value) {},
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
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Divider(
                                  thickness: 1.5,
                                  color: thunder,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 29,
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
                                          value: '',
                                          items: [],
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InsiteButton(
                                  title: 'PREVIEW',
                                  textColor: white,
                                  margin: EdgeInsets.all(20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => SingleAssetTransferViewModel(),
    );
  }
}
