import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/model_class/dropdown_model_class.dart';
import 'package:insite/views/add_new_user/reusable_widget/address_custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/app_avatar.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_list_view.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box_with_name.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'add_new_user_view_model.dart';

class AddNewUserView extends StatefulWidget {
  final Users user;
  final bool isEdit;
  AddNewUserView({this.user, this.isEdit});

  @override
  State<AddNewUserView> createState() => _AddNewUserViewState();
}

class _AddNewUserViewState extends State<AddNewUserView> {
  List<ApplicationAccess> selectedList;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _pinCodeController = new TextEditingController();
  TextEditingController _stateController = new TextEditingController();
  TextEditingController _countryController = new TextEditingController();

  var viewModel;

  @override
  void initState() {
    viewModel = AddNewUserViewModel(widget.user);
    if (widget.user != null) {
      _emailController.text = widget.user.loginId;
      _firstNameController.text = widget.user.first_name;
      _lastNameController.text = widget.user.last_name;
      _phoneNumberController.text = widget.user.phone;
      _addressController.text = widget.user.address.country;
      _pinCodeController.text = widget.user.address.zipcode;
      selectedList = [];
    } else {
      _emailController.text = "";
      _firstNameController.text = "";
      _lastNameController.text = "";
      _phoneNumberController.text = "";
      _addressController.text = "";
      _pinCodeController.text = "";
      _countryController.text = "";
      _stateController.text = "";

      selectedList = [];
    }
    super.initState();
  }

  void unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneNumberController.clear();
    _addressController.clear();
    _pinCodeController.clear();
    super.dispose();
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
                            child: widget.user != null
                                ? Text(
                                    "Manage user",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: textcolor,
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: "Roboto"),
                                  )
                                : Text(
                                    "Add New User",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: textcolor,
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: "Roboto"),
                                  )),
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
                        title: "Email", controller: _emailController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextBox(
                          title: "First name",
                          controller: _firstNameController)),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: CustomTextBox(
                        title: "Last name",
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
                      title: "Phone number",
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
                          itemCount: viewModel.assetsData.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            ApplicationAccessData accessData =
                                viewModel.assetsData[index];
                            return Center(
                              child: AppAvatar(
                                  onSelect: () {
                                    viewModel
                                        .onApplicationAccessSelection(index);
                                  },
                                  accessData: accessData,
                                  isSelected: accessData.isSelected),
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          items: viewModel.dropDownlist,
                          onChanged: (String value) {
                            unfocus();
                            viewModel.onPermissionSelected(value);
                            viewModel.onParticularItemSelected(value);
                          },
                          value: viewModel.dropDownValue,
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      itemCount:
                          viewModel.applicationSelectedDropDownList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 53),
                      itemBuilder: (context, index) {
                        ApplicationSelectedDropDown value =
                            viewModel.applicationSelectedDropDownList[index];
                        return CustomListView(
                            applicationAccessData: value.accessData,
                            text: value.value,
                            voidCallback: () {
                              viewModel.onPermissionRemoved(value, index);
                            });
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
                          items: viewModel.jobTypeList,
                          onChanged: (String value) {
                            unfocus();
                            viewModel.onJobTypeSelected(value);
                          },
                          value: viewModel.jobTypeValue,
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
                          items: viewModel.jobTitleList,
                          onChanged: (String value) {
                            unfocus();
                            viewModel.onJobTitleSelected(value);
                          },
                          value: viewModel.jobTitleValue,
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
                        controller: _countryController,
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
                              controller: _stateController,
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
                          items: viewModel.languageTypeValueList,
                          onChanged: (String value) {
                            unfocus();
                            viewModel.onlanguageTypeValueSelected(value);
                          },
                          value: viewModel.languageTypeValue,
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
                        onTap: () async {
                          Logger().i("on save click");
                          try {
                            if (widget.user != null) {
                              if (_emailController != null &&
                                  _firstNameController != null &&
                                  _lastNameController != null &&
                                  _phoneNumberController != null &&
                                  _addressController != null &&
                                  _stateController != null &&
                                  _countryController != null &&
                                  _pinCodeController != null) {
                                await viewModel.getEditUserData(
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _emailController.text,
                                    viewModel.jobTitleValue,
                                    _phoneNumberController.text,
                                    viewModel.jobTypeValue,
                                    "SSO",
                                    viewModel.tPassNameData.toString(),
                                    _addressController.text,
                                    _stateController.text,
                                    _countryController.text,
                                    _pinCodeController.text);
                              } else {
                                print("Not a valid user while editing");
                              }
                            } else {
                              Logger().i("adding user");
                              if (_emailController != null &&
                                  _firstNameController != null &&
                                  _lastNameController != null &&
                                  _phoneNumberController != null &&
                                  _addressController != null &&
                                  _stateController != null &&
                                  _countryController != null &&
                                  _pinCodeController != null) {
                                await viewModel.getAddUserData(
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _emailController.text,
                                    viewModel.jobTitleValue,
                                    _phoneNumberController.text,
                                    viewModel.jobTypeValue,
                                    _emailController.text,
                                    "SSO",
                                    viewModel.tPassNameData.toString(),
                                    _addressController.text,
                                    _stateController.text,
                                    _countryController.text,
                                    _pinCodeController.text);
                              } else {
                                print("Not a valid user while adding");
                              }
                            }
                          } catch (e) {
                            Logger().e(e);
                          }
                        },
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
}
