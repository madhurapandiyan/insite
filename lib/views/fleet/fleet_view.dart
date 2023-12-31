import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:insite/widgets/smart_widgets/fleet_item.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'fleet_view_model.dart';

class FleetView extends StatefulWidget {
  FleetView();

  @override
  _FleetViewState createState() => _FleetViewState();
}

class _FleetViewState extends State<FleetView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FleetViewModel>.reactive(
      builder: (BuildContext context, FleetViewModel viewModel, Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
              viewModel: viewModel,
              screenType: ScreenType.FLEET,
              onFilterApplied: () {
                viewModel.refresh();
              },
              onRefineApplied: () {
                viewModel.refresh();
              },
              body: Container(
                color: Theme.of(context).backgroundColor,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: InsiteTextOverFlow(
                            text: Utils.getPageTitle(ScreenType.FLEET),
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            size: 16,
                          ),
                        ),
                        PageHeader(
                          count: viewModel.assets.length,
                          total: viewModel.totalCount,
                          isDashboard: false,
                        ),

                        // viewModel.appliedFilters
                        //         .where((element) =>
                        //             element.type !=
                        //             FilterType.DATE_RANGE)
                        //         .toList()
                        //         .isNotEmpty
                        //     ? FilterChipView(
                        //         filters: viewModel.appliedFilters
                        //             .where((element) =>
                        //                 element.type !=
                        //                 FilterType.DATE_RANGE)
                        //             .toList(),
                        //         onClosed: (value) {
                        //           viewModel.removeFilter(value);
                        //           viewModel.refresh();
                        //         },
                        //         backgroundColor: chipBackgroundOne,
                        //         padding: const EdgeInsets.only(
                        //             top: 8.0, bottom: 8.0, left: 20.0),
                        //       )
                        //     : SizedBox(),
                        // viewModel.appliedFilters
                        //         .where((element) =>
                        //             element.type ==
                        //             FilterType.PRODUCT_FAMILY)
                        //         .toList()
                        //         .isNotEmpty
                        //     ? Container(
                        //         height:
                        //             MediaQuery.of(context).size.height *
                        //                 0.15,
                        //         child: FleetKnobView(
                        //           data: viewModel.appliedFilters
                        //               .where((element) =>
                        //                   element.type ==
                        //                   FilterType.PRODUCT_FAMILY)
                        //               .toList(),
                        //         ),
                        //       )
                        //     : SizedBox(),
                        Expanded(
                          child: viewModel.loading
                              ? InsiteProgressBar()
                              : viewModel.assets.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: viewModel.assets.length,
                                      padding: EdgeInsets.only(
                                          left: 16, right: 16, top: 8),
                                      controller: viewModel.scrollController,
                                      itemBuilder: (context, index) {
                                        Fleet fleet = viewModel.assets[index];
                                        return FleetListItem(
                                          dateFormat: viewModel.userPref,
                                          timeZone: viewModel.zone,
                                          fleet: fleet,
                                          onCallback: () {
                                            viewModel
                                                .onDetailPageSelected(fleet);
                                          },
                                        );
                                      })
                                  : EmptyView(title: "No Results"),
                        ),
                        viewModel.loadingMore
                            ? Padding(
                                padding: EdgeInsets.all(8),
                                child: InsiteProgressBar())
                            : SizedBox()
                      ],
                    ),
                    viewModel.isRefreshing ? InsiteProgressBar() : SizedBox()
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => FleetViewModel(),
    );
  }
}
