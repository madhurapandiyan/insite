import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_card_report_summary_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'report_summary_view_model.dart';

class ReportSummaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportSummaryViewModel>.reactive(
      builder:
          (BuildContext context, ReportSummaryViewModel viewModel, Widget _) {
        return InsiteScaffold(
          viewModel: viewModel,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InsiteText(
                    size: 20,
                    fontWeight: FontWeight.bold,
                    text: "REPORT SUMMARY FOR SMS",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InsiteText(
                        fontWeight: FontWeight.bold,
                        size: 20,
                        text: "Total Entries -1345 ",
                      ),
                      InsiteButton(
                          height: MediaQuery.of(context).size.height * 0.05,
                          bgColor: tuna,
                          title: "",
                          onTap: () {
                            viewModel.onDownload();
                          },
                          icon: Icon(
                            Icons.download,
                            color: appbarcolor,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                viewModel.modelDataList.isEmpty
                    ? Center(
                        child: InsiteProgressBar(),
                      )
                    : Column(
                        children: List.generate(
                            viewModel.modelDataList.length,
                            (i) => CustomCardReportSummaryWidget(
                                  onSelected: () {
                                    viewModel.onSelected(i);
                                  },
                                  isSelected:
                                      viewModel.modelDataList[i].isSelected,
                                  date: viewModel.modelDataList[i].StartDate,
                                  deviceId:
                                      viewModel.modelDataList[i].GPSDeviceID,
                                  language: viewModel.modelDataList[i].Language,
                                  mobileNo: viewModel.modelDataList[i].Number,
                                  name: viewModel.modelDataList[i].Name,
                                  serialNo:
                                      viewModel.modelDataList[i].SerialNumber,
                                )),
                      )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ReportSummaryViewModel(),
    );
  }
}
