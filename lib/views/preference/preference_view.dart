import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insite/views/preference/model/time_zone.dart';
import 'package:insite/views/preference/preference_view_model.dart';

import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';

class PreferencesView extends StatefulWidget {
  @override
  State<PreferencesView> createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PreferencesViewModel>.reactive(
      builder:
          (BuildContext context, PreferencesViewModel viewModel, Widget? _) {
        return InsiteScaffold(
          viewModel: viewModel,
          body: viewModel.isLoading
              ? Center(
                  child: InsiteProgressBar(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InsiteText(
                          size: 20,
                          text: "globalpreferences_title",
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InsiteText(
                          text: "datetime",
                          fontWeight: FontWeight.w700,
                          size: 15,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InsiteText(
                          text: "dateformat",
                          size: 12,
                        ),
                        Column(
                          children: List.generate(
                              viewModel.dateFormateButton.length,
                              (index) => InsiteRadioButton(
                                  text:
                                      viewModel.dateFormateButton[index].title!,
                                  isSelected: viewModel
                                      .dateFormateButton[index].isSelected,
                                  onChanged: () {
                                    viewModel.onDateFormateChange(index);
                                  })),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InsiteText(
                          text: "timeformat",
                          size: 12,
                        ),
                        Column(
                          children: List.generate(
                              viewModel.timeFormateButton.length,
                              (index) => InsiteRadioButton(
                                  text:
                                      viewModel.timeFormateButton[index].title!,
                                  isSelected: viewModel
                                      .timeFormateButton[index].isSelected,
                                  onChanged: () {
                                    viewModel.onTimeFormateChange(index);
                                  })),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InsiteText(
                          text: "timezone",
                          size: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 55, top: 20),
                          child: InsiteDropDownButton(
                            value: viewModel.selectTimeZone,
                            onChanged: (newValue) {
                              viewModel.changedropDownTimeZomeValue(newValue);
                            },
                            items: timeZoneDropdownListData
                                .map<DropdownMenuItem<TimeZone>>(
                                    (TimeZone value) {
                              return DropdownMenuItem<TimeZone>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: InsiteText(
                                    text: value.localeValue,
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InsiteText(
                            text: "location",
                            fontWeight: FontWeight.w700,
                            size: 15,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InsiteText(
                          text: "locationdisplay",
                          size: 12,
                        ),
                        Column(
                          children: List.generate(
                              viewModel.locationDisplayButton.length,
                              (index) => InsiteRadioButton(
                                  text: viewModel
                                      .locationDisplayButton[index].title!,
                                  isSelected: viewModel
                                      .locationDisplayButton[index].isSelected,
                                  onChanged: () {
                                    viewModel.onLocationDisplayChange(index);
                                  })),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InsiteText(
                          text: "language",
                          size: 12,
                        ),
                        

                        // InsiteText(
                        //   text: "language".tr() + " " + ":",
                        //   fontWeight: FontWeight.w700,
                        //   size: 14,
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.only(left: 55, top: 20),
                        //   child: InsiteDropDownButton(
                        //     value: viewModel.selectedLang,
                        //     onChanged: (newValue) {
                        //       viewModel.changedropDownLanguageValue(newValue);
                        //     },
                        //     items: viewModel.languageList
                        //         .map<DropdownMenuItem<Language>>(
                        //             (Language value) {
                        //       return DropdownMenuItem<Language>(
                        //         value: value,
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: InsiteText(
                        //             text: value.langName,
                        //             size: 14,
                        //             fontWeight: FontWeight.w700,
                        //           ),
                        //         ),
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width * 0.60,
                        //     height: MediaQuery.of(context).size.height * 0.05,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10.0),
                        //       border: Border.all(width: 1, color: black),
                        //       shape: BoxShape.rectangle,
                        //     ),
                        //     child: DropdownButton<Language>(
                        //       iconSize: 18,
                        //       elevation: 16,
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w700),
                        //       value: viewModel.selectedLang,
                        //       dropdownColor: Theme.of(context).backgroundColor,
                        //       underline: Container(
                        //         padding: const EdgeInsets.only(left: 4, right: 4),
                        //       ),
                        //       onChanged: (newValue) {
                        //         viewModel.changedropDownLanguageValue(newValue);
                        //       },
                        //       items: viewModel.languageList
                        //           .map<DropdownMenuItem<Language>>((Language value) {
                        //         return DropdownMenuItem<Language>(
                        //           value: value,
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: InsiteText(
                        //               text: value.langName,
                        //               size: 14,
                        //               fontWeight: FontWeight.w700,
                        //             ),
                        //           ),
                        //         );
                        //       }).toList(),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InsiteText(
                            text: "units".tr() + "(" + "optional".tr() + ")",
                            fontWeight: FontWeight.w700,
                            size: 15,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InsiteText(
                          text: "unitsofmeasure",
                          size: 12,
                        ),
                        Column(
                          children: viewModel.unitsOfMeasurementButton.map((e) {
                            return InsiteRadioButton(
                                text: e.title,
                                isSelected: e.isSelected,
                                onChanged: () {
                                  // viewModel.onUnitsOfMeasurementChange(index);
                                });
                          }).toList(),
                          // List.generate(
                          //     viewModel.unitsOfMeasurementButton.length,
                          //     (index) => InsiteRadioButton(
                          //         text: viewModel
                          //             .unitsOfMeasurementButton[index].title!,
                          //         isSelected: viewModel
                          //             .unitsOfMeasurementButton[index].isSelected,
                          //         onChanged: () {
                          //           viewModel.onUnitsOfMeasurementChange(index);
                          //         })),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InsiteText(
                          text: "pressureunit",
                          size: 12,
                        ),
                        Column(
                          children: List.generate(
                              viewModel.pressureUnitButton.length,
                              (index) => InsiteRadioButton(
                                  text: viewModel
                                      .pressureUnitButton[index].title!,
                                  isSelected: viewModel
                                      .pressureUnitButton[index].isSelected,
                                  onChanged: () {
                                    viewModel.onPressureUnitChange(index);
                                  })),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InsiteText(
                          text: "temperatureunit",
                          size: 12,
                        ),
                        Column(
                          children: List.generate(
                              viewModel.temperatureUnitButton.length,
                              (index) => InsiteRadioButton(
                                  text: viewModel
                                      .temperatureUnitButton[index].title!,
                                  isSelected: viewModel
                                      .temperatureUnitButton[index].isSelected,
                                  onChanged: () {
                                    viewModel.onTemperatureUnitChange(index);
                                  })),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InsiteButton(
                                // bgColor: chipBackgroundOne,
                                width: MediaQuery.of(context).size.width * 0.40,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                title: "cancel",
                                fontSize: 14,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              InsiteButton(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                title: "save",
                                fontSize: 14,
                                onTap: () async {
                                  // await viewModel.postUserPreference();

                                  // if (viewModel.selectedLang!.langName == 'English') {
                                  //   context.setLocale(const Locale('en'));
                                  // } else if (viewModel.selectedLang!.langName ==
                                  //     'French') {
                                  //   context.setLocale(const Locale('fr'));
                                  // } else if (viewModel.selectedLang!.langName ==
                                  //     'Japanese') {
                                  //   context.setLocale(const Locale('ja'));
                                  // } else if (viewModel.selectedLang!.langName ==
                                  //     'German') {
                                  //   context.setLocale(const Locale('de'));
                                  // } else if (viewModel.selectedLang!.langName ==
                                  //     "Korean") {
                                  //   context.setLocale(const Locale('ko'));
                                  // }
                                  if (viewModel.selectedLang != null) {
                                    await viewModel.onSave();
                                    // context.setLocale(
                                    //     viewModel.selectedLang!.locale!);
                                    setState(() {});
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
      viewModelBuilder: () => PreferencesViewModel(),
    );
  }
}
