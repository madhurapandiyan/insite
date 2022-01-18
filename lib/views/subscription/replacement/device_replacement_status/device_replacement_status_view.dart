import 'package:flutter/material.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:stacked/stacked.dart';
import 'device_replacement_status_view_model.dart';
import 'device_replacement_status_widget_table.dart';

class DeviceReplacementStatusView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeviceReplacementStatusViewModel>.reactive(
      builder: (BuildContext context,
          DeviceReplacementStatusViewModel viewModel, Widget? _) {
        return InsiteScaffold(
          viewModel: viewModel,
          body: viewModel.isLoading
              ? Center(
                  child: InsiteProgressBar(),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    controller: viewModel.controller,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InsiteText(
                            size: 20,
                            fontWeight: FontWeight.bold,
                            text: "REPLACEMENT STATUS",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InsiteText(
                                  fontWeight: FontWeight.bold,
                                  size: 20,
                                  text:
                                      "Total Entries -${viewModel.totalDeviceReplacementStatusModel?.result?.first.first.count} ",
                                ),
                                // InsiteButton(
                                //     height: MediaQuery.of(context).size.height *
                                //         0.05,
                                //     // bgColor: tuna,
                                //     title: "",
                                //     onTap: () {
                                //       viewModel.onDownload();
                                //     },
                                //     icon: Icon(
                                //       Icons.download,
                                //       color: appbarcolor,
                                //     )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PageHeader(
                            isDashboard: false,
                            total: viewModel.totalDeviceReplacementStatusModel
                                ?.result?.first.first.count,
                            screenType: ScreenType.SUBSCRIPTION,
                            count: viewModel
                                .deviceReplacementStatusModelList.length,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: List.generate(
                                viewModel.deviceReplacementStatusModelList
                                    .length, (i) {
                              final dataList =
                                  viewModel.deviceReplacementStatusModelList;
                              return ReplacementStatusTableWidget(
                                modelData: dataList[i],
                              );
                            }),
                          ),
                          viewModel.isLoadMore
                              ? InsiteProgressBar()
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
      viewModelBuilder: () => DeviceReplacementStatusViewModel(),
    );
  }
}
