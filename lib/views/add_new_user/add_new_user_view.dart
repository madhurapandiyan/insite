import 'package:flutter/material.dart';
import 'package:insite/core/locator.dart';
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
import 'package:stacked_services/stacked_services.dart'as service;
import 'add_new_user_view_model.dart';

class AddNewUserView extends StatefulWidget {
  final Users? user;
  final bool? isEdit;
  AddNewUserView({this.user, this.isEdit});

  @override
  State<AddNewUserView> createState() => _AddNewUserViewState();
}

class _AddNewUserViewState extends State<AddNewUserView> {
  @override
  void initState() {
    super.initState();
  }

  var snackbarService = locator<service.SnackbarService>();

  void unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewUserViewModel>.reactive(
      builder:
          (BuildContext context, AddNewUserViewModel viewModel, Widget? _) {
        return InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.USER_MANAGEMENT,
            onFilterApplied: () {},
            onRefineApplied: () {},
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
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
                                ),
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
                    CustomTextBox(
                      title: "Email",
                      controller: viewModel.emailController,
                      keyPadType: TextInputType.emailAddress,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    !viewModel.enableAdd
                        ? InsiteButton(
                            width: MediaQuery.of(context).size.width * 0.38,
                            height: MediaQuery.of(context).size.height * 0.050,
                            title: "Check".toUpperCase(),
                            textColor: Colors.white,
                            fontSize: 14,
                            onTap: () {
                              viewModel.onMaildIdCheckClicked();
                            },
                          )
                        : SizedBox(),
                    viewModel.enableAdd
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextBox(
                                  title: "First name",
                                  controller: viewModel.firstNameController),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextBox(
                                title: "Last name",
                                controller: viewModel.lastNameController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextBoxWithName(
                                controller: viewModel.phoneNumberController,
                                title: "Phone number",
                                text: "Optional",
                                textInputType: TextInputType.phone,
                              ),
                              SizedBox(
                                height: 27,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: InsiteText(
                                  text:
                                      "Application Permissions : (Definitions)",
                                  fontWeight: FontWeight.w700,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
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
                                                  .onApplicationAccessSelection(
                                                      index);
                                            },
                                            accessData: accessData,
                                            isSelected: accessData.isSelected),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(width: 1, color: black),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: CustomDropDownWidget(
                                      items: viewModel.dropDownlist,
                                      onChanged: (String? value) {
                                        unfocus();
                                        viewModel.onPermissionSelected(value);
                                      },
                                      value: viewModel.dropDownValue,
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                  itemCount: viewModel
                                      .applicationSelectedDropDownList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    ApplicationSelectedDropDown value = viewModel
                                        .applicationSelectedDropDownList[index];
                                    return CustomListView(
                                        applicationAccessData: value.accessData,
                                        text: value.value,
                                        voidCallback: () {
                                          viewModel.onPermissionRemoved(
                                              value, index);
                                        });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 55.0),
                              //   child: Align(
                              //     alignment: Alignment.topLeft,
                              //     child: InsiteText(
                              //       text: "Asset Security",
                              //       fontWeight: FontWeight.w700,
                              //       size: 14,
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     viewModel.allowAccessToSecurityClicked();
                              //   },
                              //   child: Row(
                              //     children: [
                              //       Padding(
                              //         padding: const EdgeInsets.only(left: 53.0),
                              //         child: Container(
                              //             decoration: BoxDecoration(
                              //                 color: viewModel.allowAccessToSecurity
                              //                     ? Theme.of(context).buttonColor
                              //                     : Theme.of(context).backgroundColor,
                              //                 borderRadius:
                              //                     BorderRadius.all(Radius.circular(4))),
                              //             child: Icon(
                              //               Icons.crop_square,
                              //               color: viewModel.allowAccessToSecurity
                              //                   ? Theme.of(context).buttonColor
                              //                   : Colors.black,
                              //             )),
                              //       ),
                              //       SizedBox(
                              //         width: 20,
                              //       ),
                              //       InsiteText(
                              //         text: "Allow access to asset security",
                              //         fontWeight: FontWeight.w700,
                              //         size: 14,
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: InsiteText(
                                  text: "Job Type :",
                                  size: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(width: 1, color: black),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: CustomDropDownWidget(
                                      items: viewModel.jobTypeList,
                                      onChanged: (String? value) {
                                        unfocus();
                                        viewModel.onJobTypeSelected(value);
                                      },
                                      value: viewModel.jobTypeValue,
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: InsiteText(
                                  text: "Job Title :",
                                  size: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(width: 1, color: black),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: CustomDropDownWidget(
                                      items: viewModel.jobTitleList,
                                      onChanged: (String? value) {
                                        unfocus();
                                        viewModel.onJobTitleSelected(value);
                                      },
                                      value: viewModel.jobTitleValue,
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: InsiteText(
                                  text: "Address :",
                                  size: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AddressCustomTextBox(
                                title: "Address",
                                controller: viewModel.addressController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextBox(
                                title: "Country",
                                controller: viewModel.countryController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextBox(
                                      title: "State",
                                      controller: viewModel.stateController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: CustomTextBox(
                                      title: "Pin code",
                                      keyPadType: TextInputType.number,
                                      controller: viewModel.pinCodeController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: InsiteText(
                                  text: "Language :",
                                  size: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(width: 1, color: black),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: CustomDropDownWidget(
                                      items: viewModel.languageTypeValueList,
                                      onChanged: (String? value) {
                                        unfocus();
                                        viewModel
                                            .onlanguageTypeValueSelected(value);
                                      },
                                      value: viewModel.languageTypeValue,
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 53.0),
                              //   child: Align(
                              //       alignment: Alignment.topLeft,
                              //       child: InsiteText(
                              //         text: "Preferences",
                              //         size: 14,
                              //         fontWeight: FontWeight.w700,
                              //       )),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     viewModel.onDefaultPreferenceClicked();
                              //   },
                              //   child: Row(
                              //     children: [
                              //       Padding(
                              //         padding: const EdgeInsets.only(left: 53.0),
                              //         child: Container(
                              //             decoration: BoxDecoration(
                              //                 color: viewModel.setDefaultPreferenceToUser
                              //                     ? Theme.of(context).buttonColor
                              //                     : Theme.of(context).backgroundColor,
                              //                 borderRadius:
                              //                     BorderRadius.all(Radius.circular(4))),
                              //             child: Icon(
                              //               Icons.crop_square,
                              //               color: viewModel.allowAccessToSecurity
                              //                   ? Theme.of(context).buttonColor
                              //                   : Colors.black,
                              //             )),
                              //       ),
                              //       SizedBox(
                              //         width: 20,
                              //       ),
                              //       InsiteText(
                              //         text: "Click here to set this user's default" +
                              //             "\n" +
                              //             "preferences . ",
                              //         fontWeight: FontWeight.w700,
                              //         size: 14,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 30,
                              // ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: InsiteButton(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  height: MediaQuery.of(context).size.height *
                                      0.050,
                                  title: "save".toUpperCase(),
                                  fontSize: 14,
                                  onTap: () async {
                                    unfocus();
                                    Logger().i("on save click");
                                    try {
                                      if (widget.user != null) {
                                        Logger().i("editing user");
                                        if (viewModel.emailController != null &&
                                            viewModel.firstNameController !=
                                                null &&
                                            viewModel.lastNameController !=
                                                null &&
                                            viewModel.phoneNumberController !=
                                                null &&
                                            viewModel.addressController !=
                                                null &&
                                            viewModel.stateController != null &&
                                            viewModel.countryController !=
                                                null &&
                                            viewModel.pinCodeController !=
                                                null) {
                                          await viewModel.getEditUserData(
                                              viewModel
                                                  .firstNameController!.text,
                                              viewModel.lastNameController!.text,
                                              viewModel.emailController!.text,
                                              viewModel.jobTitleValue,
                                              viewModel
                                                  .phoneNumberController!.text,
                                              viewModel.jobTypeValue,
                                              "SSO",
                                              viewModel.addressController!.text,
                                              viewModel.stateController!.text,
                                              viewModel.countryController!.text,
                                              viewModel.pinCodeController!.text);
                                        } else {
                                          print(
                                              "Not a valid user while editing");
                                        }
                                      } else {
                                        Logger().i("adding user");
                                        if (viewModel.emailController != null &&
                                            viewModel.firstNameController !=
                                                null &&
                                            viewModel.lastNameController !=
                                                null &&
                                            viewModel.phoneNumberController !=
                                                null &&
                                            viewModel.addressController !=
                                                null &&
                                            viewModel.stateController != null &&
                                            viewModel.countryController !=
                                                null &&
                                            viewModel.pinCodeController !=
                                                null) {
                                          await viewModel.getAddUserData(
                                            viewModel.firstNameController!.text,
                                            viewModel.lastNameController!.text,
                                            viewModel.emailController!.text,
                                            viewModel
                                                .phoneNumberController!.text,
                                            viewModel.jobTitleValue,
                                            viewModel.jobTypeValue,
                                            viewModel.addressController!.text,
                                            viewModel.stateController!.text,
                                            viewModel.countryController!.text,
                                            viewModel.pinCodeController!.text,
                                            "SSO",
                                            viewModel.emailController!.text,
                                          );
                                        } else {
                                          print(
                                              "Not a valid user while adding");
                                        }
                                      }
                                    } catch (e) {
                                      Logger().e(e);
                                    }
                                  },
                                  textColor: appbarcolor,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ));
      },
      viewModelBuilder: () => AddNewUserViewModel(widget.user, widget.isEdit!),
    );
  }
}
