import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/subscription/replacement/model/replace_deviceId_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

import 'deviceId_widget_list.dart';

class GettingNewDeviceId extends StatefulWidget {
  final String oldDeviceId;
  final ReplaceDeviceModel modelData;
  final String modelName;
  final Function(String) onChange;
  final TextEditingController controller;
  final List<String> items;
  final String initialValue;
  final Function(String) onDropDownValueChange;
  final bool showingDeviceId;

  GettingNewDeviceId({
    this.controller,
    this.oldDeviceId,
    this.modelName,
    this.modelData,
    this.onChange,
    this.initialValue,
    this.showingDeviceId,
    this.onDropDownValueChange,
    this.items,
  });

  @override
  _GettingNewDeviceIdState createState() => _GettingNewDeviceIdState();
}

class _GettingNewDeviceIdState extends State<GettingNewDeviceId> {
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsiteText(
          fontWeight: FontWeight.w500,
          text: "Old Device ID :",
          size: 18,
        ),
        SizedBox(height: 5),
        InsiteText(
          fontWeight: FontWeight.w500,
          text: widget.oldDeviceId,
          size: 18,
        ),
        SizedBox(height: 15),
        InsiteText(
          fontWeight: FontWeight.w500,
          text: "Machine Serial No. ",
          size: 18,
        ),
        SizedBox(height: 5),
        InsiteText(
          fontWeight: FontWeight.w500,
          text: widget.modelName,
          size: 18,
        ),
        SizedBox(height: 25),
        InsiteText(
          text: "Enter New Device ID :",
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextBox(
          controller: widget.controller,
          onChanged: (value) {
            widget.onChange(value);
          },
        ),
        widget.showingDeviceId
            ? SizedBox(
                height: 20,
              )
            : Container(
                margin: EdgeInsets.all(8),
                height: 50,
                color: white,
                child: ListView.builder(
                  itemCount: widget.modelData.result.last.length,
                  itemBuilder: (BuildContext context, int i) {
                    return DeviceIdListWidget(
                        onSelected: () {
                          setState(() {
                            widget.controller.text =
                                widget.modelData.result.last[i].GPSDeviceID;
                          });
                          FocusScope.of(context).unfocus();
                        },
                        deviceId: widget.modelData.result.last[i].GPSDeviceID);
                  },
                ),
              ),
        SizedBox(
          height: 20,
        ),
        InsiteText(
          text: "Select Reason :",
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: white)),
          child: CustomDropDownWidget(
            items: widget.items,
            value: widget.initialValue,
            onChanged: (value) {
              widget.onDropDownValueChange(value);
            },
          ),
        ),
      ],
    );
  }
}
