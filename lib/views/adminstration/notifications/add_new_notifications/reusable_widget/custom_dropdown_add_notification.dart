import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/add_report/reusable_widget/add_report_custom_dropdown_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class CustomDropDownAddNotificationWidget extends StatefulWidget {
  final List<String>? reportFleetAssets;
  final List<String>? reportServiceAssets;
  final List<String>? geofenceAssets;
  final List<String>? administratortAssets;
  final Function(String)? dropDownValue;
  final bool? isShowingDropDownState;
  String? value;
  CustomDropDownAddNotificationWidget(
      {this.reportFleetAssets,
      this.reportServiceAssets,
      this.geofenceAssets,
      this.administratortAssets,
      this.dropDownValue,
      this.isShowingDropDownState,
      this.value});

  @override
  State<CustomDropDownAddNotificationWidget> createState() =>
      _CustomDropDownAddNotificationWidgetState();
}

class _CustomDropDownAddNotificationWidgetState
    extends State<CustomDropDownAddNotificationWidget> {
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
                  borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [BoxShadow(color: black, blurRadius: 3)]),
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropDownItems(
                        title: widget.reportFleetAssets!.isNotEmpty
                            ? "Parametric (Unified Fleet)"
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
                            ? "Parametric (Unified Service)"
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
                        title: widget.administratortAssets!.isNotEmpty
                            ? "Administrator"
                            : "",
                        items: widget.administratortAssets,
                        onTap: (String dropDownValue) {
                          widget.value = dropDownValue;
                          isShowing = false;
                          widget.dropDownValue!(widget.value!);
                          setState(() {});
                        },
                      ),
                      DropDownItems(
                        title: widget.geofenceAssets!.isNotEmpty
                            ? "Geofence (Unified Fleet)"
                            : "",
                        items: widget.geofenceAssets,
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
