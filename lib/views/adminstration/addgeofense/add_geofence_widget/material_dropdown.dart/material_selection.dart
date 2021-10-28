import 'package:flutter/material.dart';

import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/add_new_user_view_model.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/addgeofense/addgeofense_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';

class MaterialSelction extends StatefulWidget {
  final AddgeofenseViewModel model;
  final Function datepicker;
  final DateTime date;
  MaterialSelction(this.model, this.datepicker,this.date);
  @override
  _MaterialSelctionState createState() => _MaterialSelctionState();
}

class _MaterialSelctionState extends State<MaterialSelction> {
  String value = "select";
  var targetvaluecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    return Column(
      children: [
        InsiteText(
          text: "Material:",
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.all(2),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              iconColor: white,
              onExpansionChanged: (bool) {},
              childrenPadding: EdgeInsets.all(10),
              title: InsiteText(
                text: value,
              ),
              children: [
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: white),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                widget.model.filteronchange(value);
                              });
                            },
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: ListView.builder(
                          itemCount: widget.model.materialdata.materials.length,
                          itemBuilder: (BuildContext context, int i) {
                            final data = widget.model.materialdata.materials;
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  value = data[i].name;
                                });
                              },
                              title: InsiteText(
                                text: data[i].name,
                              ),
                              subtitle: InsiteText(
                                text: data[i].density.toString(),
                              ),
                            );
                          },
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        InsiteText(
          text: "Target Estimated Volume:",
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            width: double.infinity,
            height: mediaquerry.size.height * 0.05,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: white),
                borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              decoration: InputDecoration(border: InputBorder.none),
            )),
        SizedBox(
          height: 20,
        ),
        InkWell(
            onTap: widget.datepicker,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: mediaquerry.size.height * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.white)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InsiteText(
                      text:
                          "${widget.date == null ? "choose date" : DateFormat.yMMMd().format(widget.date)}",
                    ),
                    Icon(Icons.calendar_today_outlined)
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
