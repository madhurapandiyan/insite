import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_user_widget.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'manage_user_view_model.dart';

class ManageUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageUserViewModel>.reactive(
      builder:
          (BuildContext context, ManageUserViewModel viewModel, Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
              viewModel: viewModel,
              screenType: ScreenType.USER_MANAGEMENT,
              onFilterApplied: () {
                viewModel.refresh();
              },
              onRefineApplied: () {
                viewModel.refresh();
              },
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 21.0),
                                child: InsiteText(
                                  text: "manage users".toUpperCase() +
                                      " (" +
                                      viewModel.assets.length.toString() +
                                      " of " +
                                      viewModel.totalCount.toString() +
                                      " )",
                                  size: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Row(
                                  children: [
                                    viewModel.showMenu
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: InsitePopMenuItemButton(
                                                width: 40,
                                                height: 40,
                                                widget: onContextMenuSelected(
                                                    viewModel, context),
                                              ),
                                            ))
                                        : SizedBox(),
                                    // viewModel.showEdit
                                    //     ? ClipRRect(
                                    //         borderRadius: BorderRadius.only(
                                    //           topLeft: Radius.circular(10),
                                    //           topRight: Radius.circular(10),
                                    //           bottomRight: Radius.circular(10),
                                    //           bottomLeft: Radius.circular(10),
                                    //         ),
                                    //         child: InsiteButton(
                                    //             title: "",
                                    //             onTap: () {
                                    //               viewModel.onEditClicked();
                                    //             },
                                    //             icon: Icon(
                                    //               Icons.edit,
                                    //               color: appbarcolor,
                                    //             )),
                                    //       )
                                    //     : SizedBox(),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // viewModel.showDelete
                                    //     ? ClipRRect(
                                    //         borderRadius: BorderRadius.only(
                                    //           topLeft: Radius.circular(10),
                                    //           topRight: Radius.circular(10),
                                    //           bottomRight: Radius.circular(10),
                                    //           bottomLeft: Radius.circular(10),
                                    //         ),
                                    //         child: InsiteButton(
                                    //             title: "",
                                    //             onTap: () {
                                    //               viewModel
                                    //                   .onDeleteClicked(context);
                                    //             },
                                    //             icon: Icon(
                                    //               Icons.delete_outline,
                                    //               color: appbarcolor,
                                    //             )),
                                    //       )
                                    //     : SizedBox(),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // viewModel.showDeSelect
                                    //     ? ClipRRect(
                                    //         borderRadius: BorderRadius.only(
                                    //           topLeft: Radius.circular(10),
                                    //           topRight: Radius.circular(10),
                                    //           bottomRight: Radius.circular(10),
                                    //           bottomLeft: Radius.circular(10),
                                    //         ),
                                    //         child: InsiteButton(
                                    //             title: "",
                                    //             onTap: () {
                                    //               viewModel.onItemDeselect();
                                    //             },
                                    //             icon: Icon(
                                    //               Icons.close,
                                    //               color: appbarcolor,
                                    //             )),
                                    //       )
                                    //     : SizedBox(),
                                    // !viewModel.showDeSelect &&
                                    //         !viewModel.showDelete &&
                                    //         !viewModel.showEdit
                                    //     ? InsiteButton(
                                    //         title: "Add User",
                                    //         textColor: Colors.white,
                                    //         onTap: () {
                                    //           viewModel.onAddNewUserClicked();
                                    //         },
                                    //       )
                                    //     : SizedBox(),
                                    // SizedBox(
                                    //   width: 10,
                                    // )
                                  ],
                                ),
                              )
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomTextBox(
                            controller: viewModel.textEditingController,
                            title: "Search users",
                            showLoading: viewModel.isSearching,
                            onChanged: (searchText) {
                              if (searchText.isNotEmpty) {
                                viewModel.searchUsers(searchText);
                              } else {
                                viewModel.updateSearchDataToEmpty();
                              }
                            },
                          ),
                        ),
                        viewModel.loading
                            ? Padding(
                                padding: const EdgeInsets.only(top: 60.0),
                                child: InsiteProgressBar(),
                              )
                            : viewModel.assets.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount: viewModel.assets.length,
                                        controller: viewModel.scrollController,
                                        padding: EdgeInsets.all(8),
                                        itemBuilder: (context, index) {
                                          UserRow user =
                                              viewModel.assets[index];
                                          return ManageUserWidget(
                                            user: user,
                                            callback: () {
                                              viewModel.onItemSelected(index);
                                            },
                                          );
                                        }),
                                  )
                                : EmptyView(
                                    title: "No User found",
                                  ),
                        viewModel.loadingMore
                            ? Padding(
                                padding: EdgeInsets.all(8),
                                child: InsiteProgressBar())
                            : SizedBox()
                      ],
                    ),
                    viewModel.refreshing ? InsiteProgressBar() : SizedBox()
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => ManageUserViewModel(),
    );
  }

  Widget onContextMenuSelected(
      ManageUserViewModel viewModel, BuildContext context) {
    return PopupMenuButton<String>(
      offset: Offset(30, 50),
      itemBuilder: (context) => [
        viewModel.showEdit
            ? PopupMenuItem(
                value: "Add User",
                child: InsiteText(
                  text: "Add User",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ))
            : PopupMenuItem(
                child: SizedBox(),
                height: 0,
              ),
        viewModel.showEdit
            ? PopupMenuItem(
                value: "Edit User",
                child: InsiteText(
                  text: "Edit User",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ),
              )
            : PopupMenuItem(
                child: SizedBox(),
                height: 0,
              ),
        viewModel.showDelete
            ? PopupMenuItem(
                value: "Delete",
                child: InsiteText(
                  text: "Delete",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ),
              )
            : PopupMenuItem(
                child: SizedBox(),
                height: 0,
              ),
        viewModel.showDeSelect
            ? PopupMenuItem(
                value: "Deselect All",
                child: InsiteText(
                  text: "Deselect All",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ))
            : PopupMenuItem(
                child: SizedBox(),
                height: 0,
              )
      ],
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
