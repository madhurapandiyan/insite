import 'package:flutter/material.dart';
import 'package:insite/core/models/note.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class Notes extends StatelessWidget {
  Notes(
      {Key? key,
      required this.controller,
      required this.onTap,
      required this.isLoading,
      required this.notes,
      this.onDelete})
      : super(key: key);

  final TextEditingController? controller;
  final Function onTap;
  final bool isLoading;
  final List<Note> notes;
  Function(String)? onDelete;
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

    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.4,
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
                      text: 'NOTES', fontWeight: FontWeight.bold, size: 15),
                ],
              ),
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
                            if (value!.isEmpty) {
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
                        onTap: onTap as void Function()?,
                        textColor: white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              notes.isNotEmpty
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: SingleChildScrollView(
                          child: Column(
                        children: List.generate(
                            notes.length,
                            (index) => Container(
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                        title: InsiteText(
                                                            text: "Notes"),
                                                        content: InsiteText(
                                                          text: notes[index]
                                                              .assetUserNote,
                                                        ),
                                                        // onOkClicked: () {
                                                        //   Navigator.of(context)
                                                        //       .pop();
                                                        // },
                                                      ));
                                            },
                                            icon: Icon(Icons.remove_red_eye)),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: InsiteTableRowItem(
                                            title: notes[index].userName,
                                            overFlow: TextOverflow.ellipsis,
                                            content:
                                                Utils.getLastReportedDateOneUTC(
                                                    notes[index]
                                                        .lastModifiedUTC),
                                          ),
                                        ),
                                        // InsiteText(
                                        //     text:
                                        //     size: 12),
                                        IconButton(
                                            onPressed: () {
                                              onDelete!(notes[index]
                                                  .userAssetNoteUID!);
                                            },
                                            icon: Icon(Icons.delete)),
                                      ],
                                    ),
                                  ),
                                )),
                      )),
                    )
                  : SizedBox(),
            ],
          ),
        ));
  }
}
