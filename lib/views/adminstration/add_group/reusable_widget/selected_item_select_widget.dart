import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/adminstration/add_group/model/add_group_model.dart';
import 'package:insite/views/adminstration/add_group/reusable_widget/selected_assets_widget.dart';
import 'package:insite/views/adminstration/add_group/selection_widget/selection_widget_view_model.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:logger/logger.dart';

class SelectedItemSelectWidgetView extends StatefulWidget {
  final List? searchList;
  final List<AddGroupModel>? displayList;
  final TextEditingController? textEditingController;
  final Function(int, String serialNumber)? callBack;
  final Function(String)? searchCallBack;
  final VoidCallback? filterCallBack;
  final bool? filterChangeState;
  final List<String>? dropDownItem;
  final String? dropDownValue;
  final Function(String)? onDropDownChange;
  const SelectedItemSelectWidgetView(
      {this.displayList,
      this.callBack,
      this.textEditingController,
      this.searchList,
      this.searchCallBack,
      this.filterCallBack,
      this.filterChangeState,
      this.dropDownItem,
      this.dropDownValue,
      this.onDropDownChange});

  @override
  _SelectedItemSelectWidgetViewState createState() =>
      _SelectedItemSelectWidgetViewState();
}

class _SelectedItemSelectWidgetViewState
    extends State<SelectedItemSelectWidgetView> {
  String? dropDownValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.all(4.0),
            child: widget.displayList!.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.17,
                        child: CustomDropDownWidget(
                          items: widget.dropDownItem,
                          value: widget.dropDownValue,
                          onChanged: (String? value) {
                            Logger().i(value);
                            widget.onDropDownChange!(value!);
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: SearchBox(
                          hint: "Search",
                          controller: widget.textEditingController,
                          onTextChanged: (String value) {
                            widget.searchCallBack!(value);
                          },
                        ),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          "assets/images/filter.svg",
                          color: Colors.white,
                        ),
                        onPressed: () {
                          widget.filterCallBack!();
                        },
                      )
                    ],
                  )
                : null),
        Expanded(
          child: ListView.builder(
              reverse: widget.filterChangeState! ? true : false,
              itemCount: widget.searchList!.isEmpty
                  ? widget.displayList!.length
                  : widget.searchList!.length,
              itemBuilder: (context, index) {
                AddGroupModel detailsRecords = widget.searchList!.isEmpty
                    ? widget.displayList![index]
                    : widget.searchList![index];
                return SelectedAssetsWidget(
                  selectedAssetList: detailsRecords,
                  callBack: () {
                    widget.callBack!(index, detailsRecords.assetIdentifier!);
                  },
                );
              }),
        )
      ],
    );
  }
}
