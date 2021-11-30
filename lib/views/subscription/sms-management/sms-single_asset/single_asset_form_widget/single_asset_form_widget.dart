import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class SingleAssetFormWidget extends StatefulWidget {
  final Function(String, String, String, String) onSaving;
  SingleAssetFormWidget(this.onSaving);

  @override
  _SingleAssetFormWidgetState createState() => _SingleAssetFormWidgetState();
}

class _SingleAssetFormWidgetState extends State<SingleAssetFormWidget> {
  var formKey = GlobalKey<FormState>();
  var serialNoValidator =
      MultiValidator([RequiredValidator(errorText: "This Field is Required")]);
  var modileNoValidator = MultiValidator([
    RequiredValidator(errorText: "This Field is Required"),
    LengthRangeValidator(
        min: 10, max: 15, errorText: "Please Enter The Valid Mobile Number")
  ]);

  var nameFocus = FocusNode();
  var mobileNoFocus = FocusNode();
  var languageFocus = FocusNode();
  String serialNo;
  String name;
  String mobileNo;
  String value = "English";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          //height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
         
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InsiteText(
                  text: "Asset Serial No. :",
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextBox(
                  onFieldSubmmit: (_) {
                    FocusScope.of(context).requestFocus(nameFocus);
                  },
                  keyPadType: TextInputType.text,
                  validator: serialNoValidator,
                  onChanged: (value) {
                    serialNo = value;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                InsiteText(
                  text: "Recipient’s Name :",
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextBox(
                  onFieldSubmmit: (_) {
                    FocusScope.of(context).requestFocus(mobileNoFocus);
                  },
                  focusNode: nameFocus,
                  keyPadType: TextInputType.name,
                  onChanged: (value) {
                    name = value;
                  },
                  validator: serialNoValidator,
                ),
                 SizedBox(
                  height: 30,
                ),
                InsiteText(
                  text: "Recipient’s Mobile No. :",
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextBox(
                  onFieldSubmmit: (_) {
                    FocusScope.of(context).requestFocus(languageFocus);
                  },
                  keyPadType: TextInputType.phone,
                  onChanged: (value) {
                    mobileNo = value;
                  },
                  focusNode: mobileNoFocus,
                  validator: modileNoValidator,
                ),
                 SizedBox(
                  height: 30,
                ),
                InsiteText(
                  text: "Language :",
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                //  height: MediaQuery.of(context).size.height * 0.05,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          width: 1)),
                  child: CustomDropDownWidget(
                    onFocus: languageFocus,
                    items: ["English", "Hindi"],
                    value: value,
                    onChanged: (val) {
                      Logger().e(val);
                      setState(() {
                        value = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InsiteButton(
                  textColor: white,
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.05,
                  onTap: () {
                    final valid = formKey.currentState.validate();
                    if (valid) {
                      widget.onSaving(serialNo, name, mobileNo, value);
                    }
                  },
                  title: "Submit",
                  fontSize: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
