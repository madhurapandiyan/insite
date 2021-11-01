import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/date_picker_custom_widget.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'single_asset_registration_view_model.dart';

class SingleAssetRegistrationView extends StatelessWidget {
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
                      ClipRRect(
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
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                ),
                                                Container(
                                                    height: 35,
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
                                                      0.01,
                                                ),
                                                Container(
                                                    height: 35,
                                                    width: 130,
                                                    child: CustomTextBox()),
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
                                                value: '',
                                                items: [],
                                                onChanged: (value) {},
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
                                                  height: MediaQuery.of(context)
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
                                                    child: CustomDatePicker()),
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
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                ),
                                                Container(
                                                    height: 35,
                                                    width: 130,
                                                    child: CustomTextBox()),
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
                                                value: '',
                                                items: [],
                                                onChanged: (value) {},
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
                                                  text: 'Device ID:',
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
                                                    height: 35,
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
                                                      0.01,
                                                ),
                                                Container(
                                                    height: 35,
                                                    width: 130,
                                                    child: CustomTextBox()),
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
                                              child: CustomTextBox(),
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
                                                  text: 'Customer ID:',
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
                                                    height: 35,
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
                                                      0.01,
                                                ),
                                                Container(
                                                    height: 35,
                                                    width: 130,
                                                    child: CustomTextBox()),
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
                                              child: CustomTextBox(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  InsiteButton(
                                    title: 'PREVIEW',
                                    textColor: white,
                                    margin: EdgeInsets.all(20),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                ],
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
      viewModelBuilder: () => SingleAssetRegistrationViewModel(),
    );
  }
}