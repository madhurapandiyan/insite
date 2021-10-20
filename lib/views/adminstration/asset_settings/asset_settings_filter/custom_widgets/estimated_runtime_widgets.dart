import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/days_reusable_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';

class EstimatedRunTimeWidget extends StatefulWidget {
  //const EstimatedRunTimeWidget({ Key? key }) : super(key: key);

  @override
  _EstimatedRunTimeWidgetState createState() => _EstimatedRunTimeWidgetState();
}

class _EstimatedRunTimeWidgetState extends State<EstimatedRunTimeWidget> {
  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  String dropDownValue = "Hours";
  var daysList = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  @override
  void initState() {
    startDateInput.text = "";
    endDateInput.text = "";
    super.initState();
  }

  @override
  void dispose() {
    startDateInput.dispose();
    endDateInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            InsiteText(
              text: "Start Time",
              fontWeight: FontWeight.w700,
              size: 14,
              color: Theme.of(context).textTheme.bodyText1.backgroundColor,
            ),
            SizedBox(
              width: 120,
            ),
            InsiteText(
              text: "End Time",
              fontWeight: FontWeight.w700,
              size: 14,
              color: Theme.of(context).textTheme.bodyText1.backgroundColor,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.40,
                height: MediaQuery.of(context).size.height * 0.04,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border.all(
                        color: Theme.of(context).textTheme.bodyText1.color)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 3),
                  child: TextFormField(
                    controller: startDateInput,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).textTheme.bodyText1.color),
                    decoration: InputDecoration(
                      hintText: "MM//DD//YYYY",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyText1.color),
                      suffixIcon: IconButton(
                          padding: EdgeInsets.only(bottom: 3.0),
                          icon: Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () {
                            getStartDatePicker();
                          }),
                      border: InputBorder.none,
                    ),
                    readOnly: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 28,
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.40,
                height: MediaQuery.of(context).size.height * 0.04,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border.all(
                        color: Theme.of(context).textTheme.bodyText1.color)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 3),
                  child: TextFormField(
                    controller: endDateInput,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).textTheme.bodyText1.color),
                    decoration: InputDecoration(
                      hintText: "MM//DD//YYYY",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyText1.color),
                      suffixIcon: IconButton(
                          padding: EdgeInsets.only(bottom: 3.0),
                          icon: Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () {
                            getEndDatePicker();
                          }),
                      border: InputBorder.none,
                    ),
                    readOnly: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 60,
            ),
            Container(
              width: 17,
              height: 17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1.color)),
            ),
            SizedBox(
              width: 5,
            ),
            InsiteText(
              text: "Target Runtime",
              size: 14,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              width: 28,
            ),
            Container(
              width: 17,
              height: 17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1.color)),
            ),
            SizedBox(
              width: 5,
            ),
            InsiteText(
              text: "Target Idling",
              size: 14,
              fontWeight: FontWeight.w700,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            InsiteText(
              text: "Full" + "\n" + "Week",
              fontWeight: FontWeight.w700,
              size: 14,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.04,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border.all(
                        color: Theme.of(context).textTheme.bodyText1.color))),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.04,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border.all(
                        color: Theme.of(context).textTheme.bodyText1.color)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: CustomDropDownWidget(
                    items: ["Hours", "%"],
                    value: dropDownValue,
                    onChanged: (String value) {
                      dropDownValue = value;
                      setState(() {});
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 7,
              itemBuilder: (_, index) {
                final days = daysList[index];
                return DaysReusableWidget(
                  days: days,
                  value: dropDownValue,
                );
              }),
        ),
         Padding(
          padding: const EdgeInsets.only(right:32.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              InsiteButton(
                width: MediaQuery.of(context).size.width * 0.20,
                height: MediaQuery.of(context).size.height * 0.04,
                title: "apply".toUpperCase(),
                fontSize: 12,
                textColor: textcolor,
                bgColor: tango,
              ),
              SizedBox(
                width: 15,
              ),
              InsiteButton(
                width: MediaQuery.of(context).size.width * 0.20,
                height: MediaQuery.of(context).size.height * 0.04,
                title: "cancel".toUpperCase(),
                fontSize: 12,
                textColor: textcolor,
                bgColor: tuna,
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              )
            ],
          ),
        ),
        SizedBox(
          height: 30,
        )
       
      ],
    );
  }

  getStartDatePicker() async {
    DateTime pickedStartdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedStartdate != null) {
      print(pickedStartdate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedStartdate);
      print(formattedDate);
      setState(() {
        startDateInput.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  getEndDatePicker() async {
    DateTime pickedEndDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedEndDate != null) {
      print(pickedEndDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedEndDate);
      print(formattedDate);
      setState(() {
        endDateInput.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}
