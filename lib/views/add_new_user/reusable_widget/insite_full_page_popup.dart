import 'package:flutter/material.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/preview_data.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/insite_reusable_rows.dart';
import 'package:insite/views/add_new_user/reusable_widget/popup_card.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';

class InsitePopUp extends StatefulWidget {
  final String? pageTitle;
  final Function? onPop;
  InsitePopUp(
      {this.pageTitle,
      this.titles,
      this.data,
      this.onButtonTapped,
      this.onPop});
  final List<String>? titles;
  List<List<PreviewData>>? data;
  final Function? onButtonTapped;

  @override
  _InsitePopUpState createState() => _InsitePopUpState();
}

class _InsitePopUpState extends State<InsitePopUp> {
  SubScriptionService? _subscriptionService = locator<SubScriptionService>();

  bool shouldPop = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          widget.data = [];
        });
        widget.onPop!();

        Navigator.pop(context);
        return shouldPop;
      },
      child: Scaffold(
        body: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InsiteText(
                            text: widget.pageTitle,
                            size: 20,
                            color: Theme.of(context).buttonColor,
                          ),
                          IconButton(
                            onPressed: () {
                              widget.data = [];
                              widget.onPop!();
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 40,
                              color: Theme.of(context).buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    PopupCard(
                      cardTitle: widget.titles![0],
                      rows: [
                        Container(
                          //height: MediaQuery.of(context).size.height * 0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                widget.data![0].length,
                                (index) => Column(
                                      children: [
                                        InsitePopupRow(
                                          title: widget.data![0][index].title ??
                                              "",
                                          value: widget.data![0][index].value ??
                                              "",
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PopupCard(
                      cardTitle: widget.titles![1],
                      //height: MediaQuery.of(context).size.height * 0.35,
                      rows: [
                        Container(
                            //height: MediaQuery.of(context).size.height * 0.25,
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              widget.data![1].length,
                              (index) => Column(
                                    children: [
                                      InsitePopupRow(
                                        title:
                                            widget.data![1][index].title ?? "",
                                        value:
                                            widget.data![1][index].value ?? "",
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PopupCard(
                      cardTitle: widget.titles![2],
                      //height: MediaQuery.of(context).size.height * 0.35,
                      rows: [
                        Container(
                            //height: MediaQuery.of(context).size.height * 0.25,
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              widget.data![2].length,
                              (index) => Column(
                                    children: [
                                      InsitePopupRow(
                                        title:
                                            widget.data![2][index].title ?? "",
                                        value:
                                            widget.data![2][index].value ?? "",
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PopupCard(
                      cardTitle: widget.titles![3],
                      // height: MediaQuery.of(context).size.height * 0.35,
                      rows: [
                        Container(
                            //height: MediaQuery.of(context).size.height * 0.25,
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              widget.data![3].length,
                              (index) => Column(
                                    children: [
                                      InsitePopupRow(
                                        title:
                                            widget.data![3][index].title ?? "",
                                        value:
                                            widget.data![3][index].value ?? "",
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onButtonTapped!();
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Center(
                        child: InsiteButton(
                          width: 150,
                          title: 'Register',
                          icon: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          textColor: white,
                          margin: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
