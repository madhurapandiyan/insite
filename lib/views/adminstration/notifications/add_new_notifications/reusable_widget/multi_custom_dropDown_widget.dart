import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class MultiSelectionDropDownWidget extends StatefulWidget {
  final String? initialValue;
  final List<CheckBoxDropDown>? items;
  final Function(List<CheckBoxDropDown>?)? onConform;
  final Function(int)? onSelected;
  final bool? isEnable;

  MultiSelectionDropDownWidget(
      {this.initialValue,
      this.items,
      this.onConform,
      this.onSelected,
      this.isEnable});

  @override
  State<MultiSelectionDropDownWidget> createState() =>
      _MultiSelectionDropDownWidgetState();
}

class _MultiSelectionDropDownWidgetState
    extends State<MultiSelectionDropDownWidget> {
  List<CheckBoxDropDown>? _selectedItems = [];
  bool _isShowingDropDown = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (widget.isEnable == null || widget.isEnable!) {
              setState(() {
                _isShowingDropDown = !_isShowingDropDown;
              });
            }
          },
          child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InsiteText(
                  text: widget.initialValue,
                ),
              )),
        ),
        _isShowingDropDown
            ? Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [BoxShadow(color: black, blurRadius: 3)]),
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Column(
                      children: List.generate(
                          widget.items!.length,
                          (i) => InkWell(
                                splashColor: Theme.of(context).splashColor,
                                onTap: () {
                                  if (_selectedItems!.any((element) => element
                                      .items!
                                      .contains(widget.items![i].items!))) {
                                    _selectedItems!.removeWhere((element) =>
                                        element.items!
                                            .contains(widget.items![i].items!));
                                    widget.onSelected!(i);
                                  } else {
                                    _selectedItems!.add(CheckBoxDropDown(
                                        extras: widget.items![i].extras,
                                        isSelected: widget.items![i].isSelected,
                                        items: widget.items![i].items!));
                                    widget.onSelected!(i);
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      InsiteButton(
                                          height: 15,
                                          width: 15,
                                          title: "",
                                          bgColor: widget.items![i].isSelected!
                                              ? Theme.of(context).buttonColor
                                              : Theme.of(context).cardColor),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      InsiteText(
                                        text: widget.items![i].items!,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InsiteButton(
                          title: "Cancel",
                          width: 100,
                          onTap: () {
                            setState(() {
                              _isShowingDropDown = !_isShowingDropDown;
                            });
                          },
                          textColor: white,
                        ),
                        InsiteButton(
                          title: "Done",
                          width: 100,
                          textColor: white,
                          onTap: () {
                            setState(() {
                              _isShowingDropDown = !_isShowingDropDown;
                            });
                            widget.onConform!(_selectedItems);
                          },
                        )
                      ],
                    )
                  ]),
                ),
              )
            : SizedBox()
      ],
    );
  }
}

class CheckBoxDropDown {
  bool? isSelected;
  String? items;
  String? extras;
  CheckBoxDropDown({this.isSelected = false, this.items, this.extras});
}