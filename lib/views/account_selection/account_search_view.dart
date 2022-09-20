import 'package:flutter/material.dart';
import 'package:insite/core/models/account.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/custom_expansion_tile.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:stacked/stacked.dart';
import 'account_search_view_model.dart';

class AccountSearchView extends StatefulWidget {
  final AccountType? selectionType;
  final AccountData? selected;
  final Function(AccountData?)? onSelected;
  final VoidCallback? onReset;
  final List<AccountData>? list;
  final bool? isAccountSelected;

  AccountSearchView(
      {this.selectionType,
      this.selected,
      this.onSelected,
      this.list,
      this.onReset,
      this.isAccountSelected});

  @override
  _AccountSearchViewState createState() => _AccountSearchViewState();
}

class _AccountSearchViewState extends State<AccountSearchView> {
  bool isExpanded = false;
  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountSearchViewModel>.reactive(
      builder:
          (BuildContext context, AccountSearchViewModel viewModel, Widget? _) {
        return AppExpansionTile(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            viewModel.selected != null
                ? viewModel.selected!.value!.DisplayName!
                : widget.selectionType == AccountType.ACCOUNT
                    ? "Select"
                    : "Search and Select",
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          key: expansionTile,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1!.color!)),
              height: viewModel.displayList!.isNotEmpty &&
                      viewModel.selected != null
                  ? MediaQuery.of(context).size.height * 0.42
                  : MediaQuery.of(context).size.height * 0.32,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      children: [
                        viewModel.list!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SearchBox(
                                  controller: viewModel.textEditingController,
                                  hint: "Search",
                                  onTextChanged: (value) {
                                    if (widget.selectionType ==
                                        AccountType.ACCOUNT) {
                                      viewModel.onSearchTextChanged(value);
                                    } else {
                                      viewModel.onChange();
                                    }
                                  },
                                ),
                              )
                            : SizedBox(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: viewModel.displayList!.length,
                            controller:
                                widget.selectionType == AccountType.ACCOUNT
                                    ? null
                                    : viewModel.scrollController,
                            // shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              AccountData data = viewModel.displayList![index];
                              return GestureDetector(
                                onTap: () {
                                  viewModel.deSelect();
                                  viewModel.displayList![index].isSelected =
                                      true;
                                  viewModel.selected = data;
                                  setState(() {});
                                  // widget.onSelected(AccountData(
                                  //     selectionType: widget.selectionType,
                                  //     value: customer));
                                },
                                child: Container(
                                  color:
                                      viewModel.displayList![index].isSelected!
                                          ? Theme.of(context).buttonColor
                                          : Theme.of(context).backgroundColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.value!.DisplayName!,
                                          //overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: viewModel
                                                      .displayList![index]
                                                      .isSelected!
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {})
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // viewModel.loadingMore
                        //     ? Padding(
                        //         padding: EdgeInsets.all(8),
                        //         child: CircularProgressIndicator())
                        //     : SizedBox()
                      ],
                    ),
                  ),
                  viewModel.displayList!.isNotEmpty &&
                          viewModel.selected != null
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              widget.selectionType == AccountType.CUSTOMER
                                  ? InsiteButton(
                                      bgColor:
                                          Theme.of(context).backgroundColor,
                                      onTap: () {
                                        viewModel.deSelect();
                                        viewModel.selected = null;
                                        setState(() {});
                                        widget.onReset!();
                                      },
                                      width: 100,
                                      height: 48,
                                      title: "RESET",
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 20,
                                width: 40,
                              ),
                              InsiteButton(
                                height: 48,
                                width: 100,
                                textColor: Colors.white,
                                onTap: () {
                                  expansionTile.currentState!.collapse();
                                  if (viewModel.selected != null) {
                                    widget.onSelected!(viewModel.selected);
                                  }
                                },
                                title: "SELECT",
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ],
        );
      },
      viewModelBuilder: () =>
          AccountSearchViewModel(widget.selected, widget.list),
    );
  }
}
