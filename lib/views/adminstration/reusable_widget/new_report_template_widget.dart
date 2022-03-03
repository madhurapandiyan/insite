import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class NewReportTemplateWidget extends StatefulWidget {
  final String? reportTypeName;
  final String? descriptionData;
  final Function(String)? dropDownValueCallBack;
  final VoidCallback? voidCallback;
  const NewReportTemplateWidget(
      {this.reportTypeName,
      this.voidCallback,
      this.descriptionData,
      this.dropDownValueCallBack});

  @override
  State<NewReportTemplateWidget> createState() =>
      _NewReportTemplateWidgetState();
}

class _NewReportTemplateWidgetState extends State<NewReportTemplateWidget> {
  String value = "one";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: tuna)],
        border: Border.all(width: 2.5, color: tuna),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.86,
            height: MediaQuery.of(context).size.height * 0.24,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [new BoxShadow(blurRadius: 1.0, color: bgcolor)],
              border: Border.all(width: 2.5, color: bgcolor),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: InsiteText(
                    text: widget.reportTypeName,
                    fontWeight: FontWeight.w700,
                    size: 18,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: InsiteText(
                    text: widget.descriptionData,
                    maxLines: 8,
                    size: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
              width: 130,
              padding: EdgeInsets.only(top: 8, left: 3),
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1!.color!)),
              child: Row(
                children: [
                  InsiteText(
                    text: "Email Report",
                    fontWeight: FontWeight.w700,
                    size: 14,
                  ),
                  // VerticalDivider(
                  //   thickness: 2,
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4,right:4),
                      child: CustomDropDownWidget(
                        enableHint: false,
                        //value: value,
                        onChanged: (String? value) {
                          value = value!;
                          Logger().wtf(value);
                          widget.dropDownValueCallBack!(value);
                          setState(() {});
                        },
                        items: [".CSV", ".XLS", ".PDF"],
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 8,
          ),
          // Row(
          //   children: [
          //     // InsiteButton(
          //     //   width: MediaQuery.of(context).size.width * 0.40,
          //     //   height: MediaQuery.of(context).size.height * 0.05,
          //     //   title: "View Sample",
          //     //   fontSize: 14,
          //     //   textColor: appbarcolor,
          //     //   bgColor: ship_grey,
          //     //   onTap: () {},
          //     // ),
          //     Expanded(
          //       child: InsiteButton(
          //         //width: MediaQuery.of(context).size.width * 0.40,
          //         height: MediaQuery.of(context).size.height * 0.05,
          //         title: "Email Report",
          //         fontSize: 14,
          //         textColor: appbarcolor,
          //         bgColor: tango,
          //         onTap: () {
          //           voidCallback!();
          //         },
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
