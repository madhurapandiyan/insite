library auto_complete_text_view;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

typedef void OnTapCallback(String value);

class AutoCompleteTextView extends StatefulWidget
    with AutoCompleteTextInterface {
  final double maxHeight;
  final TextEditingController controller;

  //AutoCompleteTextField properties
  final tfCursorColor;
  final tfCursorWidth;
  final tfStyle;
  final tfTextDecoration;
  final tfTextAlign;
  //Suggestiondrop Down properties
  final suggestionStyle;
  final suggestionTextAlign;
  final onTapCallback;
  final Function getSuggestionsMethod;
  final Function? focusGained;
  final Function? focusLost;
  final int suggestionsApiFetchDelay;
  final Function? onValueChanged;
  final List<String>? items;

  AutoCompleteTextView(
      {required this.controller,
      this.onTapCallback,
      this.maxHeight = 200,
      this.tfCursorColor = Colors.white,
      this.tfCursorWidth = 2.0,
      this.tfStyle = const TextStyle(color: Colors.black),
      this.tfTextDecoration = const InputDecoration(),
      this.tfTextAlign = TextAlign.left,
      this.suggestionStyle = const TextStyle(color: Colors.black),
      this.suggestionTextAlign = TextAlign.left,
      required this.getSuggestionsMethod,
      this.focusGained,
      this.suggestionsApiFetchDelay = 0,
      this.focusLost,
      this.items,
      this.onValueChanged});
  @override
  _AutoCompleteTextViewState createState() => _AutoCompleteTextViewState();

  //This funciton is called when a user clicks on a suggestion
  @override
  void onTappedSuggestion(String suggestion) {
    onTapCallback(suggestion);
  }
}

class _AutoCompleteTextViewState extends State<AutoCompleteTextView> {
  OverlayEntry? _overlayEntry;
  LayerLink _layerLink = LayerLink();

  List<String>? suggestionShowList = [];
  Timer? _debounce;
  bool isSearching = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOverLay();
    });
  }

  _onSearchChanged(String? text) {
    widget.getSuggestionsMethod(text);
    // if (_debounce?.isActive ?? false) _debounce!.cancel();
    // _debounce =
    //     Timer(Duration(milliseconds: widget.suggestionsApiFetchDelay), () {
    //   if (isSearching == true) {
    //     _getSuggestions(widget.controller.text);
    //   }
    // });
  }

  void showOverLay() {
    final overlay = Overlay.of(context);
    _overlayEntry = _createOverlayEntry();
    overlay!.insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: Material(
                    elevation: 4.0,
                    child: widget.items != null && widget.items!.isEmpty
                        ? SizedBox()
                        : ListView.builder(
                            itemBuilder: (ctx, i) {
                              return ListTile(
                                title: Text(widget.items![i]),
                              );
                            },
                            itemCount: widget.items!.length,
                          )
                    // StreamBuilder<Object?>(
                    //     stream: suggestionsStreamController.stream,
                    //     builder: (context, suggestionData) {
                    //       if (suggestionData.hasData &&
                    //           widget.controller.text.isNotEmpty) {
                    //         suggestionShowList =
                    //             suggestionData.data as List<String>?;
                    //         return ConstrainedBox(
                    //           constraints: new BoxConstraints(
                    //             maxHeight: 200,
                    //           ),
                    //           child: ListView.builder(
                    //               controller: scrollController,
                    //               padding: EdgeInsets.zero,
                    //               shrinkWrap: true,
                    //               itemCount: suggestionShowList!.length,
                    //               itemBuilder: (context, index) {
                    //                 return ListTile(
                    //                   title: Text(
                    //                     suggestionShowList![index],
                    //                     style: widget.suggestionStyle,
                    //                     textAlign: widget.suggestionTextAlign,
                    //                   ),
                    //                   onTap: () {
                    //                     isSearching = false;
                    //                     widget.controller.text =
                    //                         suggestionShowList![index];
                    //                     suggestionsStreamController.sink
                    //                         .add([]);
                    //                     widget.onTappedSuggestion(
                    //                         widget.controller.text);
                    //                   },
                    //                 );
                    //               }),
                    //         );
                    //       } else {
                    //         return Container();
                    //       }
                    //     }),
                    ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        decoration: widget.tfTextDecoration,
        style: widget.tfStyle,
        cursorColor: widget.tfCursorColor,
        cursorWidth: widget.tfCursorWidth,
        textAlign: widget.tfTextAlign,
        onChanged: (text) {
          Logger().w(text);
          if (text.trim().isNotEmpty) {
            widget.getSuggestionsMethod(text);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}

abstract class AutoCompleteTextInterface {
  void onTappedSuggestion(String suggestion);
}
