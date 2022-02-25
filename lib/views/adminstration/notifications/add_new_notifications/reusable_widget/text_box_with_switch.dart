import 'package:flutter/material.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

import 'textbox_with_suffix_prefix.dart';

class TextBoxWithSwitch extends StatefulWidget {
  final bool? isEnable;
  final String? title;
  final String? prefixTitle;
  final String? suffixTitle;
  final TextEditingController? controller;
  final Function? onTap;
  TextBoxWithSwitch(
      {this.controller,
      this.isEnable,
      this.title,
      this.prefixTitle,
      this.suffixTitle,this.onTap});

  @override
  State<TextBoxWithSwitch> createState() => _TextBoxWithSwitchState();
}

class _TextBoxWithSwitchState extends State<TextBoxWithSwitch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InsiteButton(
              onTap: (){
                widget.onTap!();
              },
                height: 15,
                width: 15,
                title: "",
                bgColor: widget.isEnable!
                    ? Theme.of(context).buttonColor
                    : Theme.of(context).cardColor),
            SizedBox(
              width: 20,
            ),
            InsiteText(text: widget.title),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        TextBoxWithSuffixAndPrefix(
         
          isEnable: !widget.isEnable!,
          prefixTitle: widget.prefixTitle,
          suffixTitle: widget.suffixTitle,
         //controller: widget.controller,
        )
        // Row(
        //   children: [
        //     InsiteButton(height: 15, width: 15, title: "", bgColor: viewModel.isAddingInclusionZone ? Theme.of(context).buttonColor : Theme.of(context).cardColor),
        //     InsiteText(
        //       text: "Distance Travelled After Overdue",
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
