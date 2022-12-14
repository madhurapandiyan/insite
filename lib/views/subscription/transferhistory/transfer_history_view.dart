import 'package:flutter/material.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/subscription/options/sub_dash_board_details/device_list_item.dart';
import 'package:insite/views/subscription/options/sub_dash_board_details/transfer_history_list_item.dart';
import 'package:insite/views/subscription/transferhistory/transfer_history_view_model.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';

class TransferHistoryView extends StatefulWidget {
  TransferHistoryView({Key? key}) : super(key: key);

  @override
  _TransferHistoryViewState createState() => _TransferHistoryViewState();
}

class _TransferHistoryViewState extends State<TransferHistoryView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransferHistoryViewModel>.reactive(
      builder:
          (BuildContext context, TransferHistoryViewModel viewModel, Widget? _) {
        return InsiteScaffold(
          viewModel: viewModel,
          body: Stack(
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
                            text: viewModel.loading
                                ? "Transfer History ".toUpperCase()
                                : "Transfer History ".toUpperCase() +
                                    "(" +
                                    viewModel.devices.length.toString() + " of ${viewModel.totalCount} )"
                                    ,
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
                              viewModel.showDownload
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
                                            // viewModel.onEditClicked();
                                          },
                                          icon: Icon(
                                            Icons.download,
                                            color: appbarcolor,
                                          )),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        )
                      ]),
                  Expanded(
                    child: viewModel.loading
                        ? InsiteProgressBar()
                        : viewModel.devices.isNotEmpty
                            ? ListView.builder(
                                padding: EdgeInsets.all(8),
                                itemCount: viewModel.devices.length,
                                controller: viewModel.scrollController,
                                itemBuilder: (context, index) {
                                  DetailResult result =
                                      viewModel.devices[index];
                                  return TransferHistoryListItem(
                                    detailResult: result,
                                    onCallback: () {},
                                  );
                                },
                              )
                            : EmptyView(
                                title: "No Results",
                              ),
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
        );
      },
      viewModelBuilder: () => TransferHistoryViewModel(),
    );
  }
}
