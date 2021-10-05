import 'package:flutter/material.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_user_widget.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
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
                                        Users user = viewModel.assets[index];
                                        return ManageUserWidget(
                                          user: user,
                                          callback: () {
                                            viewModel
                                                .onCardButtonSelected(user);
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
