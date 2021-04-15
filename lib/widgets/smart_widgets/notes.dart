import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class Notes extends StatelessWidget {
  const Notes({
    Key key,
    @required this.controller,
    @required this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final kTextFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: transparent,
      ),
      borderRadius: BorderRadius.all(
        const Radius.circular(10.0),
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.22,
      decoration: BoxDecoration(
        color: tuna,
        border: Border.all(color: black, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_down,
                  color: white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'NOTES',
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        autofocus: false,
                        decoration: InputDecoration(
                          focusedBorder: kTextFieldBorder,
                          border: kTextFieldBorder,
                          enabledBorder: kTextFieldBorder,
                          disabledBorder: kTextFieldBorder,
                          hintText: 'Enter Notes here',
                          isCollapsed: true,
                          fillColor: white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.045,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.02),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InsiteButton(
                      title: 'Add',
                      width: 90,
                      height: 40,
                      onTap: onTap,
                      bgColor: tango,
                      textColor: white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}