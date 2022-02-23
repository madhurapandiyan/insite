import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/model/fault_code_type_search.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';

class ExpansionCardWidget extends StatefulWidget {
  final Function? onDescriptionFrontPressed;
  final Function? onDescriptionBackPressed;
  final Function? onFaultCodeFrontPressed;
  final PageController? controller;
  final Function? onDiagnosticFrontPressed;
  final Function? onEventFrontPressed;
  final bool isFaultCodePressed;
  final TextEditingController? textController;
  final Function(String)? onChange;
  final ScrollController? scrollController;
  final List<FaultCodeDetails> items;
  final Function(bool, int)? onExpanded;
  final String? title;
  final Function(int)? onAdding;

  ExpansionCardWidget(
      {this.controller,
      this.onDescriptionBackPressed,
      this.onDescriptionFrontPressed,
      this.onFaultCodeFrontPressed,
      required this.isFaultCodePressed,
      this.onDiagnosticFrontPressed,
      this.onEventFrontPressed,
      this.onChange,
      this.textController,
      this.scrollController,
      required this.items,
      this.onExpanded,
      this.title,this.onAdding});

  @override
  State<ExpansionCardWidget> createState() => _ExpansionCardWidgetState();
}

class _ExpansionCardWidgetState extends State<ExpansionCardWidget> {
  Widget showingPageViewCardWidget(
      {String? title1,
      String? title2,
      Function? onDescriptionSecondPressed,
      Function? onDescriptionFirstPressed}) {
    return Column(children: [
      ListTile(
        onTap: () {
          onDescriptionFirstPressed!();
        },
        title: InsiteText(
          text: title1,
        ),
      ),
      ListTile(
        onTap: () {
          onDescriptionSecondPressed!();
        },
        title: InsiteText(
          text: title2,
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: PageView(
      controller: widget.controller,
      children: [
        showingPageViewCardWidget(
            title1: "Description",
            title2: "Fault Code Type",
            onDescriptionFirstPressed: widget.onDescriptionFrontPressed,
            onDescriptionSecondPressed: widget.onFaultCodeFrontPressed),
        widget.isFaultCodePressed
            ? showingPageViewCardWidget(
                title1: "Diagnostic",
                title2: "Event",
                onDescriptionFirstPressed: widget.onDiagnosticFrontPressed,
                onDescriptionSecondPressed: widget.onEventFrontPressed)
            : SizedBox(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
                onPressed: () {
                  widget.onDescriptionBackPressed!();
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                label: InsiteText(
                  text: widget.title!,
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextBox(
                controller: widget.textController,
                onChanged: (value) {
                  widget.onChange!(value);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: widget.scrollController,
                  itemCount: widget.items.length,
                  itemBuilder: (context, i) {
                    return InsiteExpansionTile(
                        onExpansionChanged: (value) {
                          widget.onExpanded!(value, i);
                        },
                        children: [
                          Table(
                            children: [
                              TableRow(children: [
                                InsiteTableRowItem(
                                  title: "Full Description",
                                  content: widget.items[i].faultDescription,
                                )
                              ]),
                              TableRow(children: [
                                InsiteTableRowItem(
                                  title: "Code Type",
                                  content: widget.items[i].faultCodeType,
                                )
                              ]),
                              TableRow(children: [
                                InsiteTableRowItem(
                                  title: "Fault code",
                                  content: widget.items[i].faultCodeIdentifier,
                                )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InsiteButton(
                                    onTap: (){
                                      widget.onAdding!(i);
                                    },
                                    title: "Add",
                                  ),
                                )
                              ])
                            ],
                          )
                        ],
                        title: ListTile(
                          leading: Container(
                           child: Icon(
                              widget.items[i].isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                          //trailing: InsiteButton(title: "Add",),
                          title: InsiteText(
                           fontWeight: FontWeight.bold,
                            text: widget.items[i].faultDescription,
                          ),
                        ));
                  }),
            ),
          ],
        )
      ],
    ));
  }
}
