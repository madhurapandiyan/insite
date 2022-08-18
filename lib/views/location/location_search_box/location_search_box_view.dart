import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/location/location_search_box/location_search_box_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class LocationSearchBoxView extends StatelessWidget {
  const LocationSearchBoxView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationSearchBoxViewModel>.reactive(
      builder: (BuildContext context, LocationSearchBoxViewModel viewModel,
          Widget? _) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Theme.of(context).backgroundColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: DropdownButton(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Container(
                      child: SvgPicture.asset(
                        "assets/images/arrowdown.svg",
                        width: 10,
                        color: Theme.of(context).iconTheme.color,
                        height: 10,
                      ),
                    ),
                  ),
                  isExpanded: false,
                  hint: Text(
                    viewModel.searchDropDownValue!,
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                  ),
                  items: ['S/N', 'Location']
                      .map((map) => DropdownMenuItem(
                            value: map,
                            child: InsiteText(
                              text: map,
                              size: 11.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                      .toList(),
                  value: viewModel.searchDropDownValue,
                  onChanged: (String? value) {
                    viewModel.onChangedDropDownValue(value);
                  },
                  underline: Container(
                      height: 1.0,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.transparent, width: 0.0)))),
                ),
              ),
              Expanded(
                child: AutocompleteBasicUserExample(
                  userListOptions:
                      viewModel.filterLocations.map((e) => e.title!).toList(),
                  onChanged: (String? value) {
                    viewModel.onSearchTextChanged(value);
                  },
                ),
              )

              // SearchBox(
              //   hint: "Search",
              //   onTextChanged: (String? value) {
              //     viewModel.onSearchTextChanged(value);
              //   },
              //   controller: viewModel.searchController,
              // )
            ],
          ),

          // viewModel.isSearching
          //     ? Container(
          //         height: MediaQuery.of(context).size.height * 0.20,
          //         child: Column(
          //           children: [
          //             // viewModel.filterLocations
          //             //             .where((element) =>
          //             //                 element.isSelected!)
          //             //             .length >
          //             //         0
          //             //     ? Padding(
          //             //         padding: const EdgeInsets
          //             //                 .symmetric(
          //             //             vertical:
          //             //                 55),
          //             //         child:
          //             //             Row(
          //             //           mainAxisAlignment:
          //             //               MainAxisAlignment.spaceBetween,
          //             //           children: [
          //             //             InsiteRichText(
          //             //               title:
          //             //                   "",
          //             //               content:
          //             //                   "CLEAR FILTERS",
          //             //               onTap:
          //             //                   () {
          //             //                 Logger().d("clear filter");
          //             //                 // viewModel.clearFilter();
          //             //                 // widget.onClear();
          //             //               },
          //             //             ),
          //             //             InsiteButton(
          //             //               onTap:
          //             //                   () {},
          //             //               textColor:
          //             //                   Colors.white,
          //             //               width:
          //             //                   100,
          //             //               height:
          //             //                   40,
          //             //               title:
          //             //                   "APPLY",
          //             //             )
          //             //           ],
          //             //         ),
          //             //       )
          //             //     : SizedBox(),
          //             SizedBox(
          //               height: 8,
          //             ),
          //             viewModel.filterLocations.isNotEmpty
          //                 ? ListView.builder(
          //                     itemCount:
          //                         viewModel.filterLocations.length,
          //                     shrinkWrap: true,
          //                     physics: NeverScrollableScrollPhysics(),
          //                     itemBuilder: (context, index) {
          //                       FilterData data =
          //                           viewModel.filterLocations[index];
          //                       return GestureDetector(
          //                         onTap: () {
          //                           viewModel.filterLocations[index]
          //                               .isSelected = !data.isSelected!;
          //                           viewModel.onLocationSelected(
          //                               data.extras![0]!,
          //                               data.extras![1]!);
          //                         },
          //                         child: Container(
          //                           color: data.isSelected!
          //                               ? Theme.of(context).buttonColor
          //                               : Theme.of(context)
          //                                   .backgroundColor,
          //                           padding: EdgeInsets.symmetric(
          //                               horizontal: 12, vertical: 4),
          //                           child: Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment
          //                                     .spaceBetween,
          //                             children: [
          //                               InsiteText(
          //                                   text: data.count!.isNotEmpty
          //                                       ? "(${data.count}) "
          //                                       : "",
          //                                   color: data.isSelected!
          //                                       ? white
          //                                       : null,
          //                                   fontWeight: FontWeight.bold,
          //                                   size: 16),
          //                               Expanded(
          //                                 child: InsiteText(
          //                                     text: data.title,
          //                                     color: data.isSelected!
          //                                         ? white
          //                                         : null,
          //                                     fontWeight:
          //                                         FontWeight.bold,
          //                                     size: 16),
          //                               ),
          //                               IconButton(
          //                                   icon: Icon(
          //                                     Icons.check,
          //                                     color: Colors.white,
          //                                   ),
          //                                   onPressed: () {})
          //                             ],
          //                           ),
          //                         ),
          //                       );
          //                     },
          //                   )
          //                 : Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: Text(
          //                       "No Results",
          //                       style: TextStyle(color: Colors.white),
          //                     ),
          //                   )
          //           ],
          //         ),
          //       )
          //     : SizedBox()
        );
      },
      viewModelBuilder: () => LocationSearchBoxViewModel(),
    );
  }
}

class AutocompleteBasicUserExample extends StatelessWidget {
  final Function(String)? onSelected;
  final List<String>? userListOptions;
  final Function(String)? onChanged;

  AutocompleteBasicUserExample(
      {this.onSelected, this.userListOptions, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        userListOptions!.forEach((element) { 
          Logger().i(element);
        });
        return userListOptions!.map((e) => e);
        // if (textEditingValue.text == '') {
        //   return const Iterable<String>.empty();
        // } else {
        //   return userListOptions!.where((element) =>
        //       element.toLowerCase().contains(textEditingValue.text));
        // }
      },
      onSelected: (String? selection) {
        onSelected!(selection!);
      },
      
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return Container(
          height: 35,
          child: TextFormField(
            focusNode: focusNode,
            cursorColor: addUserBgColor,

            onChanged: (String? value) {
              onChanged!(value!);
            },
            maxLines: 1,

            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            //  onEditingComplete: onEditingComplete,
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
    );
  }
}
