import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/model_class/dropdown_model_class.dart';
import 'package:insite/views/add_new_user/reusable_widget/address_custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/app_avatar.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_list_view.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box_with_name.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
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
        return InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.USER_MANAGEMENT,
            onFilterApplied: () {},
            onRefineApplied: () {},
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 23.0),
                            child: widget.user != null
                                ? InsiteText(
                                    text: "Edit user",
                                    fontWeight: FontWeight.w700,
                                    size: 14,
                                  )
                                : InsiteText(
                                    text: "Add New User",
                                    fontWeight: FontWeight.w700,
                                    size: 14,
                                  )),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 15.0),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(5),
                      //     child: InsiteButton(
                      //       width: MediaQuery.of(context).size.width * 0.40,
                      //       height: MediaQuery.of(context).size.height * 0.052,
                      //       title: "manage users".toUpperCase(),
                      //       fontSize: 14,
                      //       textColor: appbarcolor,
                      //       bgColor: tango,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                      child: InsiteText(
                        text: "Application Permissions : (Definitions)",
                        fontWeight: FontWeight.w700,
                        size: 14,
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
                          },
                          value: viewModel.dropDownValue,
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50, right: 20),
                    child: ListView.builder(
                        itemCount:
                            viewModel.applicationSelectedDropDownList.length,
                        shrinkWrap: true,
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
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InsiteText(
                        text: "Asset Security",
                        fontWeight: FontWeight.w700,
                        size: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.allowAccessToSecurityClicked();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 53.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: viewModel.allowAccessToSecurity
                                      ? Theme.of(context).buttonColor
                                      : Theme.of(context).backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Icon(
                                Icons.crop_square,
                                color: viewModel.allowAccessToSecurity
                                    ? Theme.of(context).buttonColor
                                    : Colors.black,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InsiteText(
                          text: "Allow access to asset security",
                          fontWeight: FontWeight.w700,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InsiteText(
                        text: "Job Type :",
                        size: 14,
                        fontWeight: FontWeight.w700,
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
                      child: InsiteText(
                        text: "Job Title :",
                        size: 14,
                        fontWeight: FontWeight.w700,
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
                      child: InsiteText(
                        text: "Address :",
                        size: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AddressCustomTextBox(
                      title: "Address",
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
                            title: "Pin code",
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
                      child: InsiteText(
                        text: "Language :",
                        size: 14,
                        fontWeight: FontWeight.w700,
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
                        child: InsiteText(
                          text: "Preferences",
                          size: 14,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.onDefaultPreferenceClicked();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 53.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: viewModel.setDefaultPreferenceToUser
                                      ? Theme.of(context).buttonColor
                                      : Theme.of(context).backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Icon(
                                Icons.crop_square,
                                color: viewModel.allowAccessToSecurity
                                    ? Theme.of(context).buttonColor
                                    : Colors.black,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InsiteText(
                          text: "Click here to set this user's default" +
                              "\n" +
                              "preferences . ",
                          fontWeight: FontWeight.w700,
                          size: 14,
                        ),
                      ],
                    ),
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
                          unfocus();
                          Logger().i("on save click");
                          try {
                            if (widget.user != null) {
                              Logger().i("editing user");
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
                                  _phoneNumberController.text,
                                  viewModel.jobTitleValue,
                                  viewModel.jobTypeValue,
                                  _addressController.text,
                                  _stateController.text,
                                  _countryController.text,
                                  _pinCodeController.text,
                                  "SSO",
                                  _emailController.text,
                                );
                              } else {
                                print("Not a valid user while adding");
                              }
                            }
                          } catch (e) {
                            Logger().e(e);
                          }
                        },
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
