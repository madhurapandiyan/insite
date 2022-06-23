import 'package:flutter/material.dart';
import 'package:insite/core/models/maintenance_asset.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/health_asset_list_item.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/dumb_widgets/maintenance_asset_list_item.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'asset_view_model.dart';

class AssetMaintenanceView extends StatefulWidget {
  AssetMaintenanceView({Key? key}) : super(key: key);

  @override
  State<AssetMaintenanceView> createState() => AssetMaintenanceViewState();
}

class AssetMaintenanceViewState extends State<AssetMaintenanceView> {
  onFilterApplied() {
    viewModel.refresh();
  }

  List<String?>? dateRange = [];
  late var viewModel;

  @override
  void initState() {
    viewModel = AssetMaintenanceViewModel();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetMaintenanceViewModel>.reactive(
      builder: (BuildContext context, AssetMaintenanceViewModel viewModel,
          Widget? _) {
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InsiteText(
                          text: Utils.getDateInFormatddMMyyyy(
                                  viewModel.maintenanceStartDate) +
                              " - " +
                              Utils.getDateInFormatddMMyyyy(
                                  viewModel.maintenanceEndDate),
                          fontWeight: FontWeight.bold,
                          size: 12),
                      SizedBox(
                        width: 4,
                      ),
                      InsiteButton(
                        width: 90,
                        title: "Date Range",
                        bgColor: Theme.of(context).backgroundColor,
                        textColor: Theme.of(context).textTheme.bodyText1!.color,
                        onTap: () async {
                          dateRange = [];
                          dateRange = await showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                backgroundColor: transparent,
                                child: DateRangeMaintenanceView()),
                          );
                          if (dateRange != null && dateRange!.isNotEmpty) {
                            viewModel.refresh();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                PageHeader(
                  isDashboard: false,
                  total: viewModel.totalCount,
                  screenType: ScreenType.ASSET_OPERATION,
                  count: viewModel.assetData.length,
                ),
                Expanded(
                  child: viewModel.loading
                      ? Container(child: InsiteProgressBar())
                      : viewModel.assetData.isNotEmpty
                          ? ListView.builder(
                              controller: viewModel.scrollController,
                              itemCount: viewModel.assetData.length,
                              padding:
                                  EdgeInsets.only(left: 16, right: 16, top: 4),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                AssetCentricData? assetCentricData =
                                    viewModel.assetData[index];
                                return MaintenanceAssetListItem(
                                  key: UniqueKey(),
                                  assetData: assetCentricData,
                                  onCallback: () {
                                    viewModel
                                        .onDetailPageSelected(assetCentricData);
                                  },
                                  serviceCalBack:
                                      (value, assetDataVaue, services) {
                                    viewModel.onServiceSelected(
                                        value,
                                        assetDataVaue,
                                        assetCentricData,
                                        services);
                                  },
                                );
                              },
                            )
                          : EmptyView(
                              title: "No Assets Found",
                            ),
                ),
                viewModel.loadingMore
                    ? Padding(
                        padding: EdgeInsets.all(8),
                        child: InsiteProgressBar(),
                      )
                    : SizedBox(),
              ],
            ),
            viewModel.refreshing ? InsiteProgressBar() : SizedBox()
          ],
        );
      },
      viewModelBuilder: () => AssetMaintenanceViewModel(),
    );
  }
}
