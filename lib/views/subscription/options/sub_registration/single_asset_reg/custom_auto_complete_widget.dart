import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
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
  final TextInputType? keyboardType;
 final String Function(String)? validator;
  CustomAutoCompleteWidget(
      {this.items,
      this.isAlign,
      this.textBoxTitle,
      this.onChange,
      this.controller,
      this.keyboardType,
      this.validator,
      this.onSelect});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: items!.isEmpty ? 129 : 200,
      height: items!.isEmpty ? 70 : 300,
      child: Column(
        crossAxisAlignment: isAlign == null || isAlign!
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          InsiteText(
            text: textBoxTitle,
            size: 13,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            width: 150,
            height: 40,
            child: CustomTextBox(
              validator: validator,
              keyPadType: keyboardType,
              controller: controller,
              onChanged: onChange,
            ),
          ),
          items!.isEmpty
              ? SizedBox()
              : Expanded(
                  child: Container(
                    //  width: 150,
                    height: 300,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ListView.builder(
                            itemCount: items!.length,
                            itemBuilder: (ctx, i) {
                              return DeviceIdListWidget(
                                  //padding: EdgeInsets.only(right: 4, left: 4),
                                  //  size: 10,
                                  deviceId: items![i],
                                  onSelected: () {
                                    onSelect!(items![i]);
                                  });
                            }),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
