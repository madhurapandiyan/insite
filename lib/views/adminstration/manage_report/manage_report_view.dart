import 'package:flutter/material.dart';
import 'package:insite/core/models/manage_report_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_report_card_widget.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'manage_report_view_model.dart';

class ManageReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageReportViewModel>.reactive(
      builder:
          (BuildContext context, ManageReportViewModel viewModel, Widget? _) {
        return InsiteScaffold(
            screenType: ScreenType.ADMINISTRATION,
            viewModel: viewModel,
            body: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: InsiteText(
                            text: "schedule reports".toUpperCase() +
                                " (" +
                                viewModel.assets.length.toString() +
                                " of " +
                                viewModel.totalCount.toString() +
                                " )",
                            size: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        viewModel.showMenu
                            ? ClipRRect(
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
                                    widget: onContextMenuSelected(
                                        viewModel, context),
                                  ),
                                ))
                            : Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: InsiteButton(
                                  title: "Report Template",
                                  onTap: () {
                                    viewModel.onClickedTemplatePage();
                                  },
                                ),
                              )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextBox(
                        controller: viewModel.searchcontroller,
                        title: "Search",
                        showLoading: viewModel.isSearching,
                        onChanged: (searchText) {
                          if (searchText.isNotEmpty) {
                            viewModel.searchReports(searchText);
                          } else {
                            viewModel.searchReports(searchText);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    viewModel.loading
                        ? InsiteProgressBar()
                        : viewModel.assets.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                    itemCount: viewModel.assets.length,
                                    padding: EdgeInsets.all(8),
                                    controller: viewModel.scrollController,
                                    itemBuilder: (context, index) {
                                      ScheduledReportsRow scheduledReport =
                                          viewModel.assets[index];
                                      return ManageReportCardWidget(
                                        voidCallback: () {
                                          viewModel.onItemSelected(index);
                                        },
                                        scheduledReportsRow: scheduledReport,
                                      );
                                    }))
                            : EmptyView(
                                title: "No Assets Found",
                              ),
                    viewModel.loadingMore
                        ? Padding(
                            padding: EdgeInsets.all(8),
                            child: InsiteProgressBar())
                        : SizedBox()
                  ],
                ),
              ],
            ));
      },
      viewModelBuilder: () => ManageReportViewModel(false),
    );
  }

  Widget onContextMenuSelected(
      ManageReportViewModel viewModel, BuildContext context) {
    return PopupMenuButton<String>(
      offset: Offset(30, 50),
      itemBuilder: (context) => [
        viewModel.showEdit
            ? PopupMenuItem(
                value: "Add New Report",
                child: InsiteText(
                  text: "Add New Report",
                  fontWeight: FontWeight.w700,
                  size: 14,
                ))
            : PopupMenuItem(
                child: SizedBox(),
                height: 0,
              ),
        viewModel.showEdit
            ? PopupMenuItem(
                value: "Edit Report",
                child: InsiteText(
                  text: "Edit Report",
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
        viewModel.showDeselect
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
