import 'package:flutter/material.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/subscription/replacement/device_replacement/device_replacement_widget.dart/deviceId_widget_list.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class CustomAutoCompleteWidget extends StatelessWidget {
  final List<String?>? items;
  final String? textBoxTitle;
  final Function(String)? onChange;
  final TextEditingController? controller;
  final Function(String?)? onSelect;
  final bool? isAlign;
  final bool isShowing;
  final TextInputType? keyboardType;
  final dynamic Function(String)? validator;
  final bool? isEnable;
  CustomAutoCompleteWidget(
      {this.items,
      this.isAlign,
      this.textBoxTitle,
      this.onChange,
      this.controller,
      this.keyboardType,
      this.validator,
      this.isEnable,
      required this.isShowing,
      this.onSelect});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsiteText(
          text: textBoxTitle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 1,
          height: 60,
          child: CustomTextBox(
            isenabled: isEnable,
            controller: controller,
            onChanged: (value) {
              onChange!(value);
            },
          ),
        ),
        isShowing
            ? SizedBox()
            : Container(
              height: 200,
                margin: EdgeInsets.symmetric(horizontal: 8),
                color: Theme.of(context).textTheme.bodyText1!.color,
                child: ListView(
                  children: List.generate(
                      items!.length,
                      (i) => Container(
                        child: DeviceIdListWidget(
                            onSelected: () {
                              onSelect!(items![i]);
                              FocusScope.of(context).unfocus();
                              items!.clear();
                            },
                            deviceId: items![i]),
                      )),
                )),
      ],
    );
  }
}
