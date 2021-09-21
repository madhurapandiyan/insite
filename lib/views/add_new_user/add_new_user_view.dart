import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/address_custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widgte.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box_with_name.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:insite/widgets/smart_widgets/reusable_dropdown_widget.dart';
import 'package:stacked/stacked.dart';
import 'add_new_user_view_model.dart';

class AddNewUserView extends StatefulWidget {
  @override
  State<AddNewUserView> createState() => _AddNewUserViewState();
}

bool changeImageState = false;
bool changeImageStateTwo = false;
bool changeImageStateThree = false;
String assetDropDown = "Administrator";
String jobTypeValue = "Employee";
String jobTitleValue = "Equipment Manager";
String languageTypeValue = "Tamil";

class _AddNewUserViewState extends State<AddNewUserView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewUserViewModel>.reactive(
      builder: (BuildContext context, AddNewUserViewModel viewModel, Widget _) {
        return Scaffold(
            backgroundColor: thunder,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 23.0),
                          child: Text(
                            "Add New User",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: textcolor,
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontFamily: "Roboto"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: InsiteButton(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: MediaQuery.of(context).size.height * 0.052,
                            title: "manage users".toUpperCase(),
                            fontSize: 14,
                            textColor: appbarcolor,
                            bgColor: tango,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: CustomTextBox(
                      title: "Email Address",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextBox(
                        title: "First Name",
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextBox(
                        title: "Last Name",
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: CustomTextBoxWithName(
                      title: "Phone Number",
                      text: "Optional",
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Application Permissions : (Definitions)",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          color: silver,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              changeImageState = !changeImageState;
                            });
                          },
                          child: changeImageState
                              ? Container(
                                  width: 43,
                                  height: 43,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 2, color: textcolor),
                                  ),
                                  child: Image.asset(
                                      "assets/images/add_user_icon_one.png"),
                                )
                              : Image.asset(
                                  "assets/images/add_user_icon_one.png"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              changeImageStateTwo = !changeImageStateTwo;
                            });
                          },
                          child: changeImageStateTwo
                              ? Container(
                                  width: 43,
                                  height: 43,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 2, color: textcolor),
                                  ),
                                  child: Image.asset(
                                      "assets/images/add_user_icon_two.png"),
                                )
                              : Image.asset(
                                  "assets/images/add_user_icon_two.png"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              changeImageStateThree = !changeImageStateThree;
                            });
                          },
                          child: changeImageStateThree
                              ? Container(
                                  width: 43,
                                  height: 43,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 2, color: textcolor),
                                  ),
                                  child: Image.asset(
                                      "assets/images/add_user_icon_three.png"),
                                )
                              : Image.asset(
                                  "assets/images/add_user_icon_three.png"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1, color: black),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomDropDownWidget(
                          items: [
                            "Administrator",
                            "Contributor",
                            "Creator",
                            "Viewer"
                          ],
                          onChanged: (String value) {
                            assetDropDown = value;
                          },
                          value: assetDropDown,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Asset Security",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: silver,
                            fontSize: 14,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 53.0),
                        child: Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(width: 1, color: black),
                            shape: BoxShape.rectangle,
                          ),
                          child: Container(
                            width: 11,
                            height: 11,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(width: 1, color: tango),
                                shape: BoxShape.rectangle,
                                color: tango),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Allow access to asset security",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: silver,
                            fontStyle: FontStyle.normal),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Job Type :",
                        style: TextStyle(
                            fontSize: 14,
                            color: silver,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1, color: black),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomDropDownWidget(
                          items: [
                            "Employee",
                            "Non Employee",
                          ],
                          onChanged: (String value) {
                            jobTypeValue = value;
                          },
                          value: jobTypeValue,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Job Title :",
                        style: TextStyle(
                            fontSize: 14,
                            color: silver,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1, color: black),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomDropDownWidget(
                          items: [
                            "Equipment Manager",
                            "Maintenance Manager",
                            "Project Manager",
                            "Machine Operator",
                            "Maintenance Technician",
                            "Others"
                          ],
                          onChanged: (String value) {
                            jobTitleValue = value;
                          },
                          value: jobTitleValue,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Address :",
                        style: TextStyle(
                            fontSize: 14,
                            color: silver,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AddressCustomTextBox(
                      title: "Enter",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextBox(
                        title: "Country",
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.34,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: CustomTextBox(
                              title: "State",
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.38,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: CustomTextBox(
                            title: "Pincode",
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Language :",
                        style: TextStyle(
                            fontSize: 14,
                            color: silver,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1, color: black),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomDropDownWidget(
                          items: ["Tamil", "English"],
                          onChanged: (String value) {
                            languageTypeValue = value;
                          },
                          value: languageTypeValue,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 53.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Preferences",
                          style: TextStyle(
                              fontSize: 14,
                              color: silver,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 53.0),
                        child: Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(width: 1, color: black),
                            shape: BoxShape.rectangle,
                          ),
                          child: Container(
                            width: 11,
                            height: 11,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(width: 1, color: tango),
                                shape: BoxShape.rectangle,
                                color: tango),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Click here to set this user's default" +
                            "\n" +
                            "preferences . ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: silver,
                            fontStyle: FontStyle.normal),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 53.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InsiteButton(
                        width: MediaQuery.of(context).size.width * 0.38,
                        height: MediaQuery.of(context).size.height * 0.050,
                        title: "save".toUpperCase(),
                        fontSize: 14,
                        onTap: () {},
                        bgColor: tango,
                        textColor: appbarcolor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ));
      },
      viewModelBuilder: () => AddNewUserViewModel(),
    );
  }
}
