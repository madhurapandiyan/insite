import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/subscription/replacement/device_replacement/device_replacement_widget.dart/deviceId_widget_list.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class CustomAutoCompleteWidget extends StatefulWidget {
  final List<String?>? items;
  final String? textBoxTitle;
  final String? helperText;
  final Function(String)? onChange;
  final TextEditingController? controller;
  final Function(String?)? onSelect;
  final bool? isAlign;
  final bool isShowing;
  final TextInputType? keyboardType;
  final dynamic Function(String)? validator;
  final bool? isEnable;
  final bool isShowingBorderColor;
  bool isShowingHelperText;
  final Function? onTap;
  CustomAutoCompleteWidget(
      {this.items,
      this.isAlign,
      this.textBoxTitle,
      this.onChange,
      this.controller,
      this.keyboardType,
      this.validator,
      this.isEnable,
      this.helperText,
      required this.isShowing,
      required this.isShowingHelperText,
      this.onTap,
      required this.isShowingBorderColor,
      this.onSelect});

  @override
  State<CustomAutoCompleteWidget> createState() =>
      _CustomAutoCompleteWidgetState();
}

class _CustomAutoCompleteWidgetState extends State<CustomAutoCompleteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InsiteText(
          text: widget.textBoxTitle,
          color: widget.isShowingBorderColor
              ? Theme.of(context).backgroundColor
              : Theme.of(context).textTheme.bodyText1!.color!,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 1,
          // decoration: BoxDecoration(
          //   border: Border.all(
          //       color: cod_grey, width: 1),
          //   borderRadius: BorderRadius.all(Radius.circular(10)),
          // ),
          child: CustomTextBox(
            isShowingBorderColor: widget.isShowingBorderColor,
            onTap: widget.onTap,
            helperText: widget.isShowingHelperText ? widget.helperText : null,
            helperStyle: TextStyle(color: tango),
            isenabled: widget.isEnable,
            controller: widget.controller,
            onChanged: (value) {
              widget.onChange!(value);
            },
          ),
        ),
        widget.isShowing
            ? SizedBox()
            : Container(
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 0.5,
                          spreadRadius: 0.2)
                    ]),
                child: ListView(
                  children: List.generate(
                      widget.items!.length,
                      (i) => Container(
                            child: DeviceIdListWidget(
                                onSelected: () {
                                  widget.isShowingHelperText = false;
                                  widget.onSelect!(widget.items![i]);
                                  FocusScope.of(context).unfocus();
                                  widget.items!.clear();
                                  setState(() {});
                                },
                                deviceId: widget.items![i]),
                          )),
                )),
      ],
    );
  }
}
