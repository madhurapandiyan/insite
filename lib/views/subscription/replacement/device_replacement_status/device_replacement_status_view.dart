import 'package:flutter/material.dart';
import 'package:insite/core/base/base_service.dart';
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
              : SingleChildScrollView(
                  controller: viewModel.controller,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             InsiteText(
                                    fontWeight: FontWeight.bold,
                                    text:
                                        "REPLACEMENT STATUS ( ${viewModel.deviceReplacementStatusModelList.length} of ${viewModel.totalDeviceReplacementStatusModel} )",
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
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: List.generate(
                              viewModel.deviceReplacementStatusModelList.length,
                              (i) {
                            final dataList =
                                viewModel.deviceReplacementStatusModelList;
                            return ReplacementStatusTableWidget(
                              modelData: dataList[i],
                            );
                          }),
                        ),
                        viewModel.isLoadMore ? InsiteProgressBar() : SizedBox()
                      ],
                    ),
                  ),
                ),
        );
      },
      viewModelBuilder: () => DeviceReplacementStatusViewModel(),
    );
  }
}
