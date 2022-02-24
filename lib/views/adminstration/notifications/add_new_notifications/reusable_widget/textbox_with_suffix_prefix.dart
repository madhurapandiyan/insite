import 'package:flutter/material.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class TextBoxWithSuffixAndPrefix extends StatefulWidget {
  final String? prefixTitle;
  final String? suffixTitle;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final bool? isEnable;

  TextBoxWithSuffixAndPrefix({
    this.controller,
    this.onChange,
    this.prefixTitle,
    this.suffixTitle,
    this.isEnable,
  });

  @override
  State<TextBoxWithSuffixAndPrefix> createState() =>
      _TextBoxWithSuffixAndPrefixState();
}

class _TextBoxWithSuffixAndPrefixState
    extends State<TextBoxWithSuffixAndPrefix> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      child: CustomTextBox(
          isenabled: widget.isEnable == null ? true : widget.isEnable,
          keyPadType: TextInputType.number,
          controller: widget.controller,
          title: "",
          onChanged: (value) {
            if (widget.onChange == null) {
            } else {
              widget.onChange!(value);
            }
          },
          suffixWidget: widget.suffixTitle==null
              ? null
              : Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: InsiteText(
                    fontWeight: FontWeight.w500,
                    text: widget.suffixTitle,
                  ),
                ),
          prefixWidget: widget.prefixTitle==null
              ? null
              : Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  padding: EdgeInsets.all(10),
                  child: InsiteText(
                    fontWeight: FontWeight.w500,
                    text: widget.prefixTitle,
                  ),
                )),
    );
    ;
  }
}
