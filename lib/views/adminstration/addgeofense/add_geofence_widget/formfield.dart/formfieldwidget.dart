import 'package:flutter/material.dart';
import 'package:insite/views/add_new_user/reusable_widget/address_custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box_with_name.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';

class Formfieldwidget extends StatefulWidget {
  //Formfieldwidget({Key? key}) : super(key: key);
  final List<String> listitems;
  final String changedvalue;
  final bool isclicked;
  final bool isclick;
  final Function checkboxstate;
  Formfieldwidget(this.listitems, this.changedvalue, this.isclicked,
      this.isclick, this.checkboxstate);

  @override
  _FormfieldwidgetState createState() => _FormfieldwidgetState();
}

class _FormfieldwidgetState extends State<Formfieldwidget> {
  String initialvalue = "Generic";
  DateTime date;
  var key = GlobalKey<FormState>();
  var titlecontroller = TextEditingController();
  var descriptioncontroller = TextEditingController();

  void datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        date = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: double.infinity,
              height: mediaquerry.size.height * 0.05,
              child: CustomTextBox(
                title: "title",
                controller: titlecontroller,
              )),
          Container(
            padding: EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InsiteText(
                  text: "Description :",
                ),
                Text(
                  "Optional",
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              child: AddressCustomTextBox(
                title: "Description",
                controller: descriptioncontroller,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: InsiteText(
              text: "Type :",
            ),
          ),
          Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.05,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.white)),
            child: CustomDropDownWidget(
              items: widget.listitems,
              onChanged: (String value) {
                setState(() {
                  initialvalue=value;
                });
              },
              value: initialvalue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: InsiteText(
              text: "End Date :",
            ),
          ),
          InkWell(
              onTap: datepicker,
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
                            "${date == null ? "choose date" : DateFormat.yMMMd().format(date)}",
                      ),
                      Icon(Icons.calendar_today_outlined)
                    ],
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: InsiteText(
              size: 16,
              text: "Please select an end date or specify\nno end date",
            ),
          ),
          InkWell(
            onTap: widget.checkboxstate,
            splashColor: Theme.of(context).backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                      decoration: BoxDecoration(
                          color: widget.isclicked
                              ? Theme.of(context).buttonColor
                              : Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Icon(
                        Icons.crop_square,
                        color: widget.isclick
                            ? Theme.of(context).buttonColor
                            : Colors.black,
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InsiteText(
                    text: "No end date for this geofence",
                    fontWeight: FontWeight.w700,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InsiteButton(
                  height: mediaquerry.size.height * 0.05,
                  width: mediaquerry.size.width * 0.4,
                  bgColor: Theme.of(context).backgroundColor,
                  title: "Cancel",
                  fontSize: 20,
                ),
                InsiteButton(
                  height: mediaquerry.size.height * 0.05,
                  width: mediaquerry.size.width * 0.4,
                  title: "Save",
                  fontSize: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
