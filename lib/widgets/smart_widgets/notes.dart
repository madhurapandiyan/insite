import 'package:flutter/material.dart';
import 'package:insite/core/models/note.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class Notes extends StatelessWidget {
  const Notes({
    Key key,
    @required this.controller,
    @required this.onTap,
    @required this.isLoading,
    @required this.notes,
  }) : super(key: key);

  final TextEditingController controller;
  final Function onTap;
  final bool isLoading;
  final List<Note> notes;
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
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border.all(
            color: Theme.of(context).textTheme.bodyText1.color, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                // Icon(
                //   Icons.keyboard_arrow_down,
                //   color: white,
                // ),
                SizedBox(
                  width: 10,
                ),
                InsiteText(
                    text: 'NOTES',
                    fontWeight: FontWeight.bold,
                    size: 15),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            notes.isNotEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(),
                        children: List.generate(
                            notes.length,
                            (index) => TableRow(children: [
                                  InsiteTableRowItem(
                                    title: "",
                                    content: notes[index].assetUserNote,
                                  ),
                                  InsiteTableRowItem(
                                    title: "",
                                    content: notes[index].userName,
                                  ),
                                  InsiteTableRowItem(
                                    title: "",
                                    content: Utils.getLastReportedDateOneUTC(
                                        notes[index].lastModifiedUTC),
                                  ),
                                ])),
                      ),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
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
                    child: InsiteButtonWithLoader(
                      title: 'Add',
                      showLoad: isLoading,
                      width: 90,
                      height: 40,
                      onTap: onTap,
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
