import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_card_report_summary_widget.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:stacked/stacked.dart';
import 'report_summary_view_model.dart';

class ReportSummaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportSummaryViewModel>.reactive(
      builder:
          (BuildContext context, ReportSummaryViewModel viewModel, Widget? _) {
        return InsiteScaffold(
          viewModel: viewModel,
          body: viewModel.modelDataList.isEmpty
              ? Center(
                  child: InsiteProgressBar(),
                )
              : SingleChildScrollView(
                  controller: viewModel.controller,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InsiteText(
                            
                            fontWeight: FontWeight.bold,
                            text:
                                "REPORT SUMMARY FOR SMS ( ${viewModel.modelDataList.length} of ${viewModel.totalCount} )",
                          ),
                              viewModel.showDeleteButton
                                  ? InsiteButton(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      title: "",
                                      onTap: viewModel.showDeleteButton
                                          ? () {
                                              viewModel.onDeletingSmsSchedule();
                                            }
                                          : null,
                                      icon: Icon(
                                        Icons.delete,
                                        color: appbarcolor,
                                      ))
                                  : SizedBox(),
                              // InsiteButton(
                              //     height:
                              //         MediaQuery.of(context).size.height * 0.05,
                              //     title: "",
                              //     onTap: () {
                              //       viewModel.onDownload();
                              //     },
                              //     icon: Icon(
                              //       Icons.download,
                              //       color: appbarcolor,
                              //     ))
                            ],
                          ),
                        ),
                        
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                              viewModel.modelDataList.length,
                              (i) => viewModel.modelDataList.isEmpty
                                  ? Center(
                                      child: EmptyView(
                                        title: "No Record Found",
                                      ),
                                    )
                                  : CustomCardReportSummaryWidget(
                                      onSelected: () {
                                        viewModel.onSelected(i);
                                      },
                                      isSelected:
                                          viewModel.modelDataList[i].isSelected,
                                      date:
                                          viewModel.modelDataList[i].startDate,
                                      deviceId: viewModel
                                          .modelDataList[i].gpsDeviceId,
                                      language:
                                          viewModel.modelDataList[i].language,
                                      mobileNo:
                                          viewModel.modelDataList[i].number,
                                      name: viewModel.modelDataList[i].name,
                                      serialNo: viewModel
                                          .modelDataList[i].serialNumber,
                                    )),
                        ),
                        viewModel.isLoadMore ? InsiteProgressBar() : SizedBox()
                      ],
                    ),
                  ),
                ),
        );
      },
      viewModelBuilder: () => ReportSummaryViewModel(),
    );
  }
}
