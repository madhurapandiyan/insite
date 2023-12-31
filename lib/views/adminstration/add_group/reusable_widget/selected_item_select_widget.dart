import 'package:flutter/material.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/adminstration/add_group/model/add_group_model.dart';
import 'package:insite/views/adminstration/add_group/reusable_widget/selected_assets_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:logger/logger.dart';

class SelectedItemSelectWidgetView extends StatefulWidget {
  final List<AddGroupModel>? displayList;
  final TextEditingController? textEditingController;
  final Function(int, String serialNumber)? onAssetDeselected;
  final Function(String)? searchCallBack;
  final VoidCallback? filterCallBack;
  final bool? filterChangeState;
  final List<String>? dropDownItem;
  final String? dropDownValue;
  final Function(String)? onDropDownChange;

  const SelectedItemSelectWidgetView({
    this.displayList,
    this.onAssetDeselected,
    this.textEditingController,
    this.searchCallBack,
    this.filterCallBack,
    this.filterChangeState,
    this.dropDownItem,
    this.dropDownValue,
    this.onDropDownChange,
  });

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
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InsiteText(
                text: "Selected Assets",
                size: 14,
                fontWeight: FontWeight.w700,
              ),
              InsiteText(
                text: widget.displayList!.length.toString() + " " + "Assets",
                size: 14,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.60,
          child: Card(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: widget.displayList!.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!),
                                          top: BorderSide(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!),
                                          left: BorderSide(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!),
                                          right: BorderSide(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!))),
                                  child: CustomDropDownWidget(
                                    items: widget.dropDownItem,
                                    value: widget.dropDownValue,
                                    onChanged: (String? value) {
                                      Logger().i(value);
                                      widget.onDropDownChange!(value!);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 5,
                                child: SearchBox(
                                  hint: "Search",
                                  controller: widget.textEditingController,
                                  onTextChanged: (String value) {
                                    widget.searchCallBack!(value);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              widget.filterChangeState!
                                  ? GestureDetector(
                                      onTap: () {
                                        widget.filterCallBack!();
                                      },
                                      child: InsiteImage(
                                        path:
                                            "assets/images/descending_filter_group.png",
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        widget.filterCallBack!();
                                      },
                                      child: InsiteImage(
                                        path:
                                            "assets/images/ascending_filter_group.png",
                                      ),
                                    )
                            ],
                          )
                        : SizedBox()),
                Flexible(
                  child: ListView.builder(
                      itemCount: widget.displayList!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        AddGroupModel detailsRecords =
                            widget.displayList![index];
                        return SelectedAssetsWidget(
                         // selectedAssetList: detailsRecords,
                          callBack: () {
                            widget.onAssetDeselected!(
                                index, detailsRecords.assetIdentifier!);
                          },
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
