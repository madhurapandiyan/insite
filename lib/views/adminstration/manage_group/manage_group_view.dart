import 'package:flutter/material.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_groups_card_widget.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'manage_group_view_model.dart';

class ManageGroupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageGroupViewModel>.reactive(
      builder:
          (BuildContext context, ManageGroupViewModel viewModel, Widget? _) {
        return InsiteScaffold(
          viewModel: viewModel,
          screenType: ScreenType.MANAGE_NEW_GROUP,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: InsiteText(
                            text: "manage groups".toUpperCase() +
                                " (" +
                                viewModel.assets.length.toString() +
                                " of " +
                                viewModel.totalCount.toString() +
                                " )",
                            size: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // viewModel.showEdit
                        //     ?
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: InsitePopMenuItemButton(
                                width: 40,
                                height: 40,
                                //icon: Icon(Icons.more_vert),
                                widget:
                                    onContextMenuSelected(viewModel, context),
                              ),
                            ))
                        // : Padding(
                        //     padding: const EdgeInsets.only(right: 8),
                        //     child: InsiteButton(
                        //       title: "Add Group",
                        //       fontSize: 14,
                        //       onTap: () {
                        //         viewModel.onClickAddGroupSelected();
                        //       },
                        //     ),
                        //   )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextBox(
                        controller: viewModel.searchcontroller,
                        title: "Search Group Name",
                        showLoading: viewModel.isSearching,
                        onChanged: (searchText) {
                          if (searchText.isNotEmpty) {
                            viewModel.searchGroups(searchText);
                          } else {
                            viewModel.searchGroups(searchText);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    viewModel.loading
                        ? InsiteProgressBar()
                        : viewModel.assets.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                    itemCount: viewModel.assets.length,
                                    controller: viewModel.scrollController,
                                    padding: EdgeInsets.all(8),
                                    itemBuilder: (context, index) {
                                      GroupRow groups = viewModel.assets[index];
                                      return ManageGroupCardWidget(
                                        dateFormat: viewModel.userPref,
                                        timeZone: viewModel.zone,
                                        groups: groups,
                                        callback: () {
                                          viewModel.onItemSelected(index);
                                        },
                                        favoriteCallBack: () {
                                          viewModel
                                              .onFavoriteItemSelected(index);
                                        },
                                      );
                                    }),
                              )
                            : EmptyView(
                                title: "No Groups found",
                              ),
                    viewModel.loadingMore
                        ? Padding(
                            padding: EdgeInsets.all(8),
                            child: InsiteProgressBar())
                        : SizedBox()
                  ],
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ManageGroupViewModel(),
    );
  }

  Widget onContextMenuSelected(
      ManageGroupViewModel viewModel, BuildContext context) {
    return PopupMenuButton<String>(
      offset: Offset(30, 50),
      itemBuilder: (context) => List.generate(
          viewModel.popList!.length,
          (i) => PopupMenuItem(
              value: viewModel.popList![i],
              child: InsiteText(
                text: viewModel.popList![i],
                fontWeight: FontWeight.w700,
                size: 14,
              ))),
      // [
      //   viewModel.showMenu
      //       ? PopupMenuItem(
      //           value: "New Group",
      //           child: InsiteText(
      //             text: "New Group",
      //             fontWeight: FontWeight.w700,
      //             size: 14,
      //           ))
      //       : PopupMenuItem(
      //           child: SizedBox(),
      //           height: 0,
      //         ),
      //   viewModel.showEdit
      //       ? PopupMenuItem(
      //           value: "Edit Group",
      //           child: InsiteText(
      //             text: "Edit Group",
      //             fontWeight: FontWeight.w700,
      //             size: 14,
      //           ),
      //         )
      //       : PopupMenuItem(
      //           child: SizedBox(),
      //           height: 0,
      //         ),
      //   viewModel.showDelete
      //       ? PopupMenuItem(
      //           value: "Delete",
      //           child: InsiteText(
      //             text: "Delete",
      //             fontWeight: FontWeight.w700,
      //             size: 14,
      //           ),
      //         )
      //       : PopupMenuItem(
      //           child: SizedBox(),
      //           height: 0,
      //         ),
      //   viewModel.isFavorite
      //       ? PopupMenuItem(
      //           value: "UnFavorite",
      //           child: InsiteText(
      //             text: "UnFavorite",
      //             fontWeight: FontWeight.w700,
      //             size: 14,
      //           ),
      //         )
      //       : PopupMenuItem(
      //           value: "Favorite",
      //           child: InsiteText(
      //             text: "Favorite",
      //             fontWeight: FontWeight.w700,
      //             size: 14,
      //           ),
      //         ),
      //   PopupMenuItem(
      //       value: "Deselect All",
      //       child: InsiteText(
      //         text: "Deselect All",
      //         fontWeight: FontWeight.w700,
      //         size: 14,
      //       )),
      // ],
      onSelected: (value) {
        Logger().i("value:$value");
        viewModel.onSelectedItemClicK(value, context);
      },
      icon: Icon(
        Icons.more_vert,
        color: appbarcolor,
        size: 25,
      ),
    );
  }
}
