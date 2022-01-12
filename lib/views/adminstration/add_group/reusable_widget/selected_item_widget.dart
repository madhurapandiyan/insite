import 'package:flutter/material.dart';
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
  final List<String>? displayCountBoxValue;
  final VoidCallback? callback;
  final List? searchList;
  final TextEditingController? controller;
  final bool? isLoading;
  final Function(dynamic)? productFamilyKey;
  final bool? isShowingState;
  final VoidCallback? isShowingbackButtonState;
  final Function(dynamic, int)? groupValueCallBack;
  final List? subList;
  final TextEditingController? subTextEditingController;
  final List? subSearchList;
  final bool? isChangingAccountSelectionState;
  const SelectedItemWidget(
      {this.pageController,
      this.headerText,
      this.displayList,
      this.isAssetIdLoading,
      this.headerBoxCountValue,
      this.displayCountBoxValue,
      this.callback,
      this.isLoading,
      this.searchList,
      this.controller,
      this.productFamilyKey,
      this.isShowingState,
      this.isShowingbackButtonState,
      this.groupValueCallBack,
      this.subList,
      this.subTextEditingController,
      this.subSearchList,
      this.isChangingAccountSelectionState});

  @override
  _SelectedItemWidgetState createState() => _SelectedItemWidgetState();
}

class _SelectedItemWidgetState extends State<SelectedItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (_) {
        widget.callback!();
      },
      title: ListTile(
        leading: widget.isShowingState == true
            ? GestureDetector(
                onTap: () {
                  widget.isShowingbackButtonState!();
                },
                child: Icon(Icons.arrow_back))
            : SizedBox(),
        title: InsiteText(
          text: widget.headerText,
          fontWeight: FontWeight.w700,
          size: 14,
        ),
      ),
      children: [
        widget.isAssetIdLoading!
            ? InsiteProgressBar()
            : Container(
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
              widget.subList!.isNotEmpty && widget.isShowingState!
                  ? ListView.builder(
                      itemCount: widget.subSearchList!.isEmpty
                          ? widget.subList!.length
                          : widget.subSearchList!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, int) {
                        if (widget.isChangingAccountSelectionState==true) {
                          Customer data = widget.subSearchList!.isEmpty
                              ? widget.subList![int]
                              : widget.subSearchList![int];
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
                          final data = widget.subSearchList!.isEmpty
                              ? widget.subList![int]
                              : widget.subSearchList![int];
                          return widget.isAssetIdLoading!
                              ? Center(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 100),
                                      child: InsiteProgressBar()))
                              : widget.isLoading != null && widget.isLoading!
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
                      })
                  : ListView.builder(
                      itemCount: widget.searchList!.isEmpty
                          ? widget.displayList!.length
                          : widget.searchList!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, int) {
                        if (widget.headerText == "Account") {
                          Customer data = widget.searchList!.isEmpty
                              ? widget.displayList![int]
                              : widget.searchList![int];
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
                          final data = widget.searchList!.isEmpty
                              ? widget.displayList![int]
                              : widget.searchList![int];
                          return widget.isAssetIdLoading!
                              ? Center(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 100),
                                      child: InsiteProgressBar()))
                              : widget.isLoading != null && widget.isLoading!
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
