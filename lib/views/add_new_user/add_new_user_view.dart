import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/model_class/dropdown_model_class.dart';
import 'package:insite/views/add_new_user/reusable_widget/address_custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/app_avatar.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widgte.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_list_view.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box_with_name.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:insite/widgets/smart_widgets/reusable_dropdown_widget.dart';
import 'package:stacked/stacked.dart';
import 'add_new_user_view_model.dart';

class AddNewUserView extends StatefulWidget {
  final Users user;

  AddNewUserView({this.user});

  @override
  State<AddNewUserView> createState() => _AddNewUserViewState();
}

List<ApplicationAccess> selectedList;
int selectedListIndex;
String assetDropDown;
bool isDataSelected = true;
String jobTypeValue;
String jobTitleValue;
String languageTypeValue;
TextEditingController _emailController = new TextEditingController();
TextEditingController _firstNameController = new TextEditingController();
TextEditingController _lastNameController = new TextEditingController();
TextEditingController _phoneNumberController = new TextEditingController();
TextEditingController _addressController = new TextEditingController();
TextEditingController _pinCodeController = new TextEditingController();
var viewModel;
bool isSelected = false;
bool isDataRemoved = false;

class _AddNewUserViewState extends State<AddNewUserView> {
  @override
  void initState() {
    viewModel = AddNewUserViewModel();
    _emailController.text = widget.user.loginId;
    _firstNameController.text = widget.user.first_name;
    _lastNameController.text = widget.user.last_name;
    _phoneNumberController.text = widget.user.phone;
    _addressController.text = widget.user.address.country;
    _pinCodeController.text = widget.user.address.zipcode;
    selectedList = [];

    super.initState();
  }

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
                    child:
                        CustomTextBox(title: "", controller: _emailController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextBox(
                          title: "", controller: _firstNameController)),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextBox(
                        title: "",
                        controller: _lastNameController,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: CustomTextBoxWithName(
                      controller: _phoneNumberController,
                      title: "",
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
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ListView.builder(
                          itemCount: viewModel.assetData.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Center(
                              child: AppAvatar(
                                isBtnSelected: isSelected,
                                isDataRemoved: isDataRemoved,
                                applicationAccess: viewModel.assetData[index],
                                isSelected: (bool value) {
                                  selectedListIndex = index;
                                  onMultiSelecrButtonClicked(value, index);
                                  print("$selectedListIndex : $value");
                                  setState(() {});
                                },
                              ),
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isSelected
                      ? Container(
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
                                //isSelected = !isSelected;
                                if (isSelected == true) {
                                  viewModel.listDropDownValue.add(
                                      DropDownModelClass(
                                          index: selectedListIndex,
                                          value: value));
                                }

                                setState(() {});
                              },
                              value: assetDropDown,
                            ),
                          ))
                      : Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: CustomTextBox(
                              title: "Select",
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      itemCount: viewModel.listDropDownValues.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 53),
                      itemBuilder: (context, index) {
                        DropDownModelClass value =
                            viewModel.listDropDownValues[index];
                        return Column(
                          children: [
                            CustomListView(
                                text: value.value,
                                voidCallback: () {
                                  viewModel.listDropDownValues.removeAt(index);
                                  isDataRemoved = true;
                                  isSelected = false;
                                  print("SSSS:$isSelected");
                                  print("SSS:$isDataRemoved");

                                  setState(() {});
                                })
                          ],
                        );
                      }),
                  SizedBox(
                    height: 15,
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
                            setState(() {});
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
                            setState(() {});
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
                      title: "",
                      controller: _addressController,
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
                            title: "",
                            controller: _pinCodeController,
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
                            setState(() {});
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
      viewModelBuilder: () => viewModel,
    );
  }

  onMultiSelecrButtonClicked(bool value, int index) {
    if (value) {
      selectedList.add(viewModel.assetData[index]);
      isSelected = value;
    } else {
      print("button is tapped");

      if (index == 0) {
        isSelected = value;
      }
      selectedList.remove(viewModel.assetData[index]);
    }
  }
}
