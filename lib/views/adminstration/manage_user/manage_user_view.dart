import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_user_widget.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'manage_user_view_model.dart';

class ManageUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageUserViewModel>.reactive(
      builder: (BuildContext context, ManageUserViewModel viewModel, Widget _) {
        return InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.ADMINISTRATION,
            onFilterApplied: () {},
            onRefineApplied: () {},
            body: Container(
              color: bgcolor,
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
                                text: "manage users".toUpperCase(),
                                color: textcolor,
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
                                  viewModel.showEdit
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          child: InsiteButton(
                                              title: "",
                                              bgColor: tuna,
                                              onTap: () {
                                                viewModel.onEditClicked();
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: appbarcolor,
                                              )),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  viewModel.showDelete
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          child: InsiteButton(
                                              title: "",
                                              onTap: () {
                                                viewModel
                                                    .onDeleteClicked(context);
                                              },
                                              bgColor: tuna,
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color: appbarcolor,
                                              )),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  viewModel.showDeSelect
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          child: InsiteButton(
                                              title: "",
                                              bgColor: tuna,
                                              onTap: () {
                                                viewModel.onItemDeselect();
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: appbarcolor,
                                              )),
                                        )
                                      : SizedBox(),
                                  !viewModel.showDeSelect &&
                                          !viewModel.showDelete &&
                                          !viewModel.showEdit
                                      ? InsiteButton(
                                          title: "Add User",
                                          bgColor: tango,
                                          textColor: Colors.white,
                                          onTap: () {
                                            viewModel.onAddNewUserClicked();
                                          },
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            )
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      viewModel.loading
                          ? Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : viewModel.assets.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                      itemCount: viewModel.assets.length,
                                      controller: viewModel.scrollController,
                                      itemBuilder: (context, index) {
                                        UserRow user = viewModel.assets[index];
                                        return ManageUserWidget(
                                          user: user,
                                          callback: () {
                                            viewModel.onItemSelected(index);
                                          },
                                        );
                                      }),
                                )
                              : EmptyView(
                                  title: "No assets found",
                                ),
                      viewModel.loadingMore
                          ? Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator())
                          : SizedBox()
                    ],
                  )
                ],
              ),
            ));
      },
      viewModelBuilder: () => ManageUserViewModel(),
    );
  }
}