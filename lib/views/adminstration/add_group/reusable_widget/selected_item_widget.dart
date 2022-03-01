import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class SelectedItemWidget extends StatefulWidget {
  final PageController? pageController;
  final String? headerText;
  final List? displayList;
  final bool? isAssetIdLoading;
  final String? headerBoxCountValue;
  final List<String> ?displayCountBoxValue;
  final VoidCallback? callback;
  final TextEditingController? controller;
  final Function(dynamic)? productFamilyKey;
  final bool? isShowingState;
  final VoidCallback? onClickedBackButton;
  final Function(dynamic, int)? groupValueCallBack;
  final List? subList;
  final TextEditingController? subTextEditingController;
  final bool? isChangingAccountSelectionState;
  
  const SelectedItemWidget(
      {this.pageController,
      this.headerText,
      this.displayList,
      this.isAssetIdLoading,
      this.headerBoxCountValue,
      required this.displayCountBoxValue,
      this.callback,
      this.controller,
      this.productFamilyKey,
      this.isShowingState,
      this.onClickedBackButton,
      this.groupValueCallBack,
      this.subList,
      this.subTextEditingController,
      this.isChangingAccountSelectionState,
     });

  @override
  _SelectedItemWidgetState createState() => _SelectedItemWidgetState();
}

class _SelectedItemWidgetState extends State<SelectedItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      onExpansionChanged: (_) {
        widget.callback!();
      },
      title: Row(
        children: [
          widget.isShowingState == true
              ? GestureDetector(
                  onTap: () {
                    widget.onClickedBackButton!();
                  },
                  child: Icon(Icons.arrow_back))
              : SizedBox(),
          InsiteText(
            text: widget.headerText,
            fontWeight: FontWeight.w700,
            size: 14,
          ),
        ],
      ),
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.05,
            child: widget.isShowingState == true
                ? CustomTextBox(
                    title: "Search",
                    controller: widget.subTextEditingController)
                : CustomTextBox(
                    title: "Search", controller: widget.controller)),
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          child: PageView(
            controller: widget.pageController,
            children: [
              widget.displayList!.isEmpty
                  ? InsiteProgressBar()
                  : ListView.builder(
                      itemCount: widget.displayList!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, int) {
                        if (widget.headerText == "Account") {
                          Customer data = widget.displayList![int];

                          return ListTile(
                            onTap: () {
                              List<dynamic>? customerlist;
                              if (widget.headerText == "Account") {
                                customerlist = widget.displayList;
                                widget.productFamilyKey!(
                                    customerlist![int].CustomerUID!);
                              }
                            },
                            title: InsiteText(
                              text: data.Name,
                              fontWeight: FontWeight.w700,
                              size: 14,
                            ),
                            trailing: widget.headerBoxCountValue == ""
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 8, bottom: 8),
                                    child: widget.isShowingState == true
                                        ? SizedBox()
                                        : InsiteButton(
                                            width: 50,
                                            title: widget
                                                .displayCountBoxValue![int],
                                            padding: EdgeInsets.all(4),
                                            bgColor: Theme.of(context)
                                                .backgroundColor,
                                            fontSize: 10,
                                          )),
                          );
                        } else {
                          final data = widget.displayList![int];

                          return widget.isAssetIdLoading!
                              ? Center(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 100),
                                      child: InsiteProgressBar()))
                              : widget.isAssetIdLoading != null &&
                                      widget.isAssetIdLoading!
                                  ? Center(
                                      child: SizedBox(),
                                    )
                                  : data != null
                                      ? ListTile(
                                          onTap: () {
                                            widget.productFamilyKey != null
                                                ? widget.productFamilyKey!(
                                                    widget.displayList![int])
                                                : SizedBox();
                                          },
                                          title: InsiteText(
                                            text: data,
                                            fontWeight: FontWeight.w700,
                                            size: 14,
                                          ),
                                          trailing: widget
                                                      .headerBoxCountValue ==
                                                  ""
                                              ? InsiteButton(
                                                  title: "add".toUpperCase(),
                                                  fontSize: 14,
                                                  onTap: () {
                                                    widget.groupValueCallBack!(
                                                        widget
                                                            .displayList![int],
                                                        int);
                                                  },
                                                  width: 77,
                                                  height: 32,
                                                  textColor: Colors.white,
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8,
                                                          top: 8,
                                                          bottom: 8),
                                                  child: widget
                                                              .isShowingState ==
                                                          true
                                                      ? InsiteButton(
                                                          title: "add"
                                                              .toUpperCase(),
                                                          fontSize: 14,
                                                          onTap: () {
                                                            widget.groupValueCallBack!(
                                                                widget.displayList![
                                                                    int],
                                                                int);
                                                          },
                                                          width: 77,
                                                          height: 32,
                                                          textColor:
                                                              Colors.white,
                                                        )
                                                      : InsiteButton(
                                                          width: 50,
                                                          title: widget
                                                                  .displayCountBoxValue![
                                                              int],
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          bgColor: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          fontSize: 10,
                                                        )),
                                        )
                                      : SizedBox();
                        }
                      }),
              widget.subList!.isEmpty
                  ? SizedBox()
                  : ListView.builder(
                      itemCount: widget.subList!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, int) {
                        if (widget.isChangingAccountSelectionState == true) {
                          Customer data = widget.subList![int];

                          return ListTile(
                            onTap: () {
                              List<dynamic>? customerlist;
                              if (widget.headerText == "Account") {
                                customerlist = widget.subList;
                                widget.productFamilyKey!(
                                    customerlist![int].CustomerUID!);
                              }
                            },
                            title: InsiteText(
                              text: data.Name,
                              fontWeight: FontWeight.w700,
                              size: 14,
                            ),
                            trailing: widget.headerBoxCountValue == ""
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 8, bottom: 8),
                                    child: widget.isShowingState == true
                                        ? SizedBox()
                                        : InsiteButton(
                                            width: 50,
                                            title: widget
                                                .displayCountBoxValue![int],
                                            padding: EdgeInsets.all(4),
                                            bgColor: Theme.of(context)
                                                .backgroundColor,
                                            fontSize: 10,
                                          )),
                          );
                        } else {
                          final data = widget.subList![int];

                          return widget.isAssetIdLoading!
                              ? Center(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 100),
                                      child: InsiteProgressBar()))
                              : widget.isAssetIdLoading != null &&
                                      widget.isAssetIdLoading!
                                  ? Center(
                                      child: SizedBox(),
                                    )
                                  : data != null
                                      ? ListTile(
                                          onTap: () {
                                            widget.productFamilyKey != null
                                                ? widget.productFamilyKey!(
                                                    widget.subList![int])
                                                : SizedBox();
                                          },
                                          title: InsiteText(
                                            text: data,
                                            fontWeight: FontWeight.w700,
                                            size: 14,
                                          ),
                                          trailing: widget
                                                      .headerBoxCountValue ==
                                                  ""
                                              ? InsiteButton(
                                                  title: "add".toUpperCase(),
                                                  fontSize: 14,
                                                  onTap: () {
                                                    widget.groupValueCallBack!(
                                                        widget.subList![int],
                                                        int);
                                                  },
                                                  width: 77,
                                                  height: 32,
                                                  textColor: Colors.white,
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8,
                                                          top: 8,
                                                          bottom: 8),
                                                  child: widget
                                                              .isShowingState ==
                                                          true
                                                      ? InsiteButton(
                                                          title: "add"
                                                              .toUpperCase(),
                                                          fontSize: 14,
                                                          onTap: () {
                                                            widget.groupValueCallBack!(
                                                                widget.subList![
                                                                    int],
                                                                int);
                                                          },
                                                          width: 77,
                                                          height: 32,
                                                          textColor:
                                                              Colors.white,
                                                        )
                                                      : InsiteButton(
                                                          width: 50,
                                                          title: widget
                                                                  .displayCountBoxValue![
                                                              int],
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          bgColor: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          fontSize: 10,
                                                        )),
                                        )
                                      : SizedBox();
                        }
                      }),
            ],
          ),
        )
      ],
    );
  }
}
