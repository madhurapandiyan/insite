import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/location/location_search_box/location_search_box_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class LocationSearchBoxView extends StatelessWidget {
  final Function(dynamic, bool isSerialNo)? onSeletingSuggestion;
  final ScreenType? screenType;
  final double? searchBoxWidth;

  LocationSearchBoxView(
      {this.onSeletingSuggestion, this.searchBoxWidth, this.screenType});
  @override
  Widget build(BuildContext context) {
    var mediaQuerry = MediaQuery.of(context);
    return ViewModelBuilder<LocationSearchBoxViewModel>.reactive(
      builder: (BuildContext context, LocationSearchBoxViewModel viewModel,
          Widget? _) {
        return Container(
          width: mediaQuerry.size.width * searchBoxWidth!,
          height: mediaQuerry.size.height * 0.070,
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(new Radius.circular(8))),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(builder: (ctx, constrain) {
                return Row(
                  children: [
                    Container(
                      width: constrain.maxWidth * 0.28,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(8))),
                      child: screenType == ScreenType.ASSET_DETAIL
                          ? DropdownButton<String>(

                              icon: Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: SvgPicture.asset(
                                  "assets/images/arrowdown.svg",
                                //  width: 10,
                                  color: Theme.of(context).iconTheme.color,
                                  height: 10,
                                ),
                              ),
                              isExpanded: false,
                              elevation: 0,
                              underline: Container(),
                              isDense: true,
                              iconSize: 0.0,
                              items: viewModel.assetDropDownList
                                  .map((map) => DropdownMenuItem(
                                        value: map,
                                        child: InsiteTextOverFlow(
                                          text: map,
                                          size: 10.0,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))
                                  .toList(),
                              value: viewModel.searchLocationDropDownValue,
                              onChanged: (String? value) {
                                viewModel.onChangeDropDownValueTwo(value!);
                              },
                            )
                          : DropdownButton<String>(
                             icon: Padding(
                               padding: const EdgeInsets.only(left: 3),
                               child: SvgPicture.asset(
                                
                                  "assets/images/arrowdown.svg",
                                  width: 10,
                                  color: Theme.of(context).iconTheme.color,
                                  height: 10,
                                ),
                             ),
                              isExpanded: false,
                              elevation: 0,
                              underline: Container(),
                              isDense: true,
                              iconSize: 0.0,
                              items: viewModel.dropDownList
                                  .map((map) => DropdownMenuItem(
                                        value: map,
                                        child: InsiteTextOverFlow(
                                          text: map,
                                          size: 11.0,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))
                                  .toList(),
                              value: viewModel.searchDropDownValue,
                              onChanged: (String? value) {
                                viewModel.onChangeDropDown(value!);
                              },
                            ),
                    ),

                    // Expanded(
                    //   child: CustomDropDownWidget(
                    //     items: viewModel.dropDownList,
                    //     value: viewModel.searchDropDownValue,
                    //     onChanged: (_) {},
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.only(right: 6),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(8))),
                        child: TypeAheadField(
                          noItemsFoundBuilder: (_) {
                            return SizedBox();
                          },
                          suggestionsCallback: (pattern) async {
                            Completer<List<LocationKey>> completer =
                                new Completer();
                            if (pattern.isNotEmpty) {
                              await viewModel.onSearchTextChanged(
                                  pattern, screenType!);
                              completer.complete(viewModel.list);
                              return completer.future;
                            } else {
                              return [];
                            }
                          },
                          itemBuilder: (context, suggestion) {
                            var data = suggestion as LocationKey;
                            return ListTile(
                              title: Text(data.value!),
                            );
                          },
                          hideOnEmpty: true,
                          hideSuggestionsOnKeyboardHide: false,
                          keepSuggestionsOnSuggestionSelected: false,
                          getImmediateSuggestions: true,
                          onSuggestionSelected: (suggestion) {
                            if ((suggestion as LocationKey?) != null) {
                              viewModel.onSelect(suggestion!.value as String);
                              if (screenType == ScreenType.ASSET_DETAIL) {
                                onSeletingSuggestion!(
                                    LatLng(suggestion.latitude!,
                                        suggestion.longitude!),
                                    false);
                              } else {
                                if (viewModel.searchDropDownValue == "S/N") {
                                  var data = viewModel
                                      .result!.assetLocation!.mapRecords!
                                      .singleWhere((element) =>
                                          element!.assetSerialNumber ==
                                          suggestion.value);
                                  Logger().w(data!.toJson());
                                  onSeletingSuggestion!(data, true);
                                } else {
                                  onSeletingSuggestion!(
                                      LatLng(suggestion.latitude!,
                                          suggestion.longitude!),
                                      false);
                                }
                              }
                            }
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            cursorColor: addUserBgColor,
                            controller: viewModel.searchController,
                            maxLines: 1,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 2, top: 10, bottom: 10),
                                isDense: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                fillColor: white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: 20,
                        height: 20,
                        child: viewModel.isSerching!
                            ? InsiteProgressBar()
                            : SizedBox())
                  ],
                );
              })),
        );
      },
      viewModelBuilder: () => LocationSearchBoxViewModel(),
    );
  }
}

class AutocompleteBasicUserExample extends StatefulWidget {
  final Function(String)? onSelected;
  final List<String>? userListOptions;
  final Function(String)? onChanged;

  AutocompleteBasicUserExample(
      {this.onSelected, this.userListOptions, this.onChanged});

  @override
  State<AutocompleteBasicUserExample> createState() =>
      _AutocompleteBasicUserExampleState();
}

class _AutocompleteBasicUserExampleState
    extends State<AutocompleteBasicUserExample> {
  List<String> dataValues = [];
  List<String> filteredValues = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: Autocomplete(
        optionsViewBuilder: (ct, Function(String) onSelect, options) {
          return Material(
            child: Container(
              height: 100,
              child: ListView.builder(
                itemBuilder: (ctxx, i) {
                  return ListTile(
                    title: Text(options.toList()[i] as String),
                    onTap: () {
                      onSelect(options.toList()[i] as String);
                    },
                  );
                },
                itemCount: options.toList().length,
              ),
            ),
          );
        },
        onSelected: (_) {},
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          return Container(
            height: 35,
            child: TextField(
              focusNode: focusNode,
              cursorColor: addUserBgColor,
              controller: controller,
              onChanged: (value) {
                widget.onChanged!(value);
              },
              maxLines: 1,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12, top: 22),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      width: 1),
                ),
              ),
            ),
          );
        },
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return Iterable<String>.empty();
          } else {
            return widget.userListOptions!;
          }
        },
      ),
    );
  }
}
