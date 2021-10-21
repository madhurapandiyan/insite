import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/tabs/utilization/tabs/list/single_asset_utilization_list_view_model.dart';
import 'package:insite/views/utilization/utilization_list_item.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/dumb_widgets/single_asset_usage.dart';
import 'package:insite/widgets/dumb_widgets/single_asset_usage_two.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationListView extends StatefulWidget {
  final AssetDetail detail;
  const SingleAssetUtilizationListView({
    Key key,
    this.detail,
  }) : super(key: key);

  @override
  _SingleAssetUtilizationListViewState createState() =>
      _SingleAssetUtilizationListViewState();
}

class _SingleAssetUtilizationListViewState
    extends State<SingleAssetUtilizationListView> {
  List<DateTime> dateRange = [];
  ProductFamilyType productFamilyType = ProductFamilyType.ALL;
  bool isProductFamilySelected = false;

  @override
  void initState() {
    Logger().d("selected asset product familiy ${widget.detail.productFamily}");
    if (widget.detail.productFamily == "BACKHOE LOADER") {
      productFamilyType = ProductFamilyType.BACKHOE_LOADER;
    } else if (widget.detail.productFamily == "EXCAVATOR") {
      productFamilyType = ProductFamilyType.EXCAVATOR;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetUtilizationListViewModel>.reactive(
      builder: (BuildContext context,
          SingleAssetUtilizationListViewModel viewModel, Widget _) {
        if (viewModel.loading) return InsiteProgressBar();
        return Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    productFamilyType != ProductFamilyType.ALL
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InsiteText(
                                text: Utils.getDateInFormatddMMyyyy(
                                        viewModel.startDate) +
                                    " - " +
                                    Utils.getDateInFormatddMMyyyy(
                                        viewModel.endDate),
                                fontWeight: FontWeight.bold,
                                size: 11),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: InsiteText(
                                text: Utils.getDateInFormatddMMyyyy(
                                        viewModel.startDate) +
                                    " - " +
                                    Utils.getDateInFormatddMMyyyy(
                                        viewModel.endDate),
                                fontWeight: FontWeight.bold,
                                size: 11),
                          ),
                    SizedBox(
                      width: 4,
                    ),
                    // Padding(
                    //   padding: productFamilyType != ProductFamilyType.ALL
                    //       ? const EdgeInsets.only(
                    //           top: 12.0, left: 12, right: 12)
                    //       : const EdgeInsets.all(12.0),
                    //   child: InsiteButton(
                    //     title: "Date Range",
                    //     width: 90,
                    //     bgColor: Theme.of(context).backgroundColor,
                    //     textColor: Theme.of(context).textTheme.bodyText1.color,
                    //     onTap: () async {
                    //       dateRange = [];
                    //       dateRange = await showDialog(
                    //         context: context,
                    //         builder: (BuildContext context) => Dialog(
                    //             backgroundColor: transparent,
                    //             child: DateRangeView()),
                    //       );
                    //       if (dateRange != null && dateRange.isNotEmpty) {
                    //         viewModel.refresh();
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                productFamilyType != ProductFamilyType.ALL
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InsiteButtonWithSelectable(
                              onTap: (value) {
                                setState(() {
                                  isProductFamilySelected = value;
                                });
                              },
                              textColor: Colors.white,
                              bgColor: Theme.of(context).backgroundColor,
                              isSelectable: true,
                              height: 30,
                              fontSize: 12,
                              title: productFamilyType ==
                                      ProductFamilyType.BACKHOE_LOADER
                                  ? "BACKHOE LOADER"
                                  : productFamilyType ==
                                          ProductFamilyType.EXCAVATOR
                                      ? "EXCAVATOR"
                                      : "",
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InsiteButton(
                              title: "Date Range",
                              width: 90,
                              bgColor: Theme.of(context).backgroundColor,
                              textColor:
                                  Theme.of(context).textTheme.bodyText1.color,
                              onTap: () async {
                                dateRange = [];
                                dateRange = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                      backgroundColor: transparent,
                                      child: DateRangeView()),
                                );
                                if (dateRange != null && dateRange.isNotEmpty) {
                                  viewModel.refresh();
                                }
                              },
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 12,
                      ),
                productFamilyType != ProductFamilyType.ALL
                    ? SizedBox(
                        height: 24,
                      )
                    : SizedBox(),
                Flexible(
                  child: viewModel.loading
                      ? Container(
                          child: InsiteProgressBar(),
                        )
                      : viewModel.utilLizationList.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              scrollDirection: Axis.vertical,
                              itemCount: viewModel.utilLizationList.length,
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              itemBuilder: (context, index) {
                                AssetResult utilizationData =
                                    viewModel.utilLizationList[index];
                                return isProductFamilySelected
                                    ? productFamilyType ==
                                            ProductFamilyType.EXCAVATOR
                                        ? SingleAssetUsage(
                                            utilizationData: utilizationData,
                                          )
                                        : productFamilyType ==
                                                ProductFamilyType.BACKHOE_LOADER
                                            ? SingleAssetUsageTwo(
                                                utilizationData:
                                                    utilizationData,
                                              )
                                            : UtilizationListItem(
                                                utilizationData:
                                                    utilizationData,
                                                isShowingInDetailPage: true,
                                                onCallback: () {},
                                              )
                                    : UtilizationListItem(
                                        utilizationData: utilizationData,
                                        isShowingInDetailPage: true,
                                        onCallback: () {},
                                      );
                              })
                          : EmptyView(
                              title: "No Assets Found",
                            ),
                ),
              ],
            ),
            viewModel.refreshing ? InsiteProgressBar() : SizedBox()
          ],
        );
      },
      viewModelBuilder: () =>
          SingleAssetUtilizationListViewModel(widget.detail),
    );
  }
}
