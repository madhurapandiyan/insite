import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/filter/filter_chip_view.dart';
import 'package:insite/views/filter/filter_knob_view.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
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
      builder: (BuildContext context, FleetViewModel viewModel, Widget _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters.length,
          child: InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.FLEET,
            onFilterApplied: () {
              viewModel.refresh();
            },
            body: Container(
              color: bgcolor,
              child: viewModel.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : viewModel.assets.isNotEmpty
                      ? Stack(
                          children: [
                            Column(
                              children: [
                                PageHeader(
                                  count: viewModel.assets.length,
                                  total: viewModel.totalCount,
                                  isDashboard: false,
                                ),
                                viewModel.appliedFilters
                                        .where((element) =>
                                            element.type !=
                                            FilterType.DATE_RANGE)
                                        .toList()
                                        .isNotEmpty
                                    ? FilterChipView(
                                        filters: viewModel.appliedFilters
                                            .where((element) =>
                                                element.type !=
                                                FilterType.DATE_RANGE)
                                            .toList(),
                                        onClosed: (value) {
                                          viewModel.removeFilter(value);
                                          viewModel.refresh();
                                        },
                                        backgroundColor: chipBackgroundOne,
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0, left: 20.0),
                                      )
                                    : SizedBox(),
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
                                  child: ListView.builder(
                                      itemCount: viewModel.assets.length,
                                      padding: EdgeInsets.only(
                                          left: 16, right: 16, top: 8),
                                      controller: viewModel.scrollController,
                                      itemBuilder: (context, index) {
                                        Fleet fleet = viewModel.assets[index];
                                        return FleetListItem(
                                          fleet: fleet,
                                          onCallback: () {
                                            viewModel
                                                .onDetailPageSelected(fleet);
                                          },
                                        );
                                      }),
                                ),
                                viewModel.loadingMore
                                    ? Padding(
                                        padding: EdgeInsets.all(8),
                                        child: CircularProgressIndicator())
                                    : SizedBox()
                              ],
                            ),
                            viewModel.isRefreshing
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SizedBox()
                          ],
                        )
                      : EmptyView(title: "No Results"),
            ),
          ),
        );
      },
      viewModelBuilder: () => FleetViewModel(),
    );
  }
}
