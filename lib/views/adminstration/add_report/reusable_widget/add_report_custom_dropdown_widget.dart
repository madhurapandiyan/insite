import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class AddReportCustomDropdownWidget extends StatefulWidget {
  final List<String>? reportFleetAssets;
  final List<String>? reportServiceAssets;
  final List<String>? reportProductivityAssets;
  final List<String>? reportStandartAssets;
  final Function(String)? dropDownValue;
  final bool? isShowingDropDownState;
  String? value;
  AddReportCustomDropdownWidget(
      {this.reportFleetAssets,
      this.reportServiceAssets,
      this.reportProductivityAssets,
      this.reportStandartAssets,
      this.dropDownValue,
      this.isShowingDropDownState,
      this.value});

  @override
  State<AddReportCustomDropdownWidget> createState() =>
      _AddReportCustomDropdownWidgetState();
}

class _AddReportCustomDropdownWidgetState
    extends State<AddReportCustomDropdownWidget> {
  bool isShowing = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (widget.isShowingDropDownState!) {
              setState(() {
                isShowing = true;
              });
            } else {}
          },
          child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 1, color: black),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InsiteText(
                  text: widget.value,
                ),
              )),
        ),
        isShowing
            ? Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [BoxShadow(color: black, blurRadius: 3)]),
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropDownItems(
                        title: widget.reportFleetAssets!.isNotEmpty
                            ? "Unified fleet"
                            : "",
                        items: widget.reportFleetAssets,
                        onTap: (dropDownValue) {
                          setState(() {
                            isShowing = false;
                            widget.value = dropDownValue;
                            widget.dropDownValue!(widget.value!);
                          });
                        },
                      ),
                      DropDownItems(
                        title: widget.reportServiceAssets!.isNotEmpty
                            ? "Unified Service"
                            : "",
                        items: widget.reportServiceAssets,
                        onTap: (dropDownValue) {
                          setState(() {
                            isShowing = false;
                            widget.value = dropDownValue;
                            widget.dropDownValue!(widget.value!);
                          });
                        },
                      ),
                      DropDownItems(
                        title: widget.reportProductivityAssets!.isNotEmpty
                            ? "Unified Productivity "
                            : "",
                        items: widget.reportProductivityAssets,
                        onTap: (String dropDownValue) {
                          widget.value = dropDownValue;
                          isShowing = false;
                          widget.dropDownValue!(widget.value!);
                          setState(() {});
                        },
                      ),
                      DropDownItems(
                        title: widget.reportStandartAssets!.isNotEmpty
                            ? "Standard "
                            : "",
                        items: widget.reportStandartAssets,
                        onTap: (String dropDownValue) {
                          widget.value = dropDownValue;
                          isShowing = false;
                          widget.dropDownValue!(widget.value!);
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}

class DropDownItems extends StatelessWidget {
  final String? title;
  final List<String>? items;
  final Function(String)? onTap;
  DropDownItems({this.items, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsiteText(
          text: title,
          color: Theme.of(context).buttonColor,
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              items!.length,
              (index) => Column(
                    children: [
                      InkWell(
                          onTap: () {
                            onTap!(items![index]);
                          },
                          child: InsiteText(
                            text: items![index],
                          )),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )),
        ),
      ],
    );
  }
}
