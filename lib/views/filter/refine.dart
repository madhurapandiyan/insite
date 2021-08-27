import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:stacked/stacked.dart';
import 'filter_chip_view.dart';
import 'filter_view_model.dart';

class Refine extends StatefulWidget {
  final Function(bool) onRefineApplied;
  final ScreenType screenType;
  Refine({this.onRefineApplied, this.screenType});

  @override
  _RefineState createState() => _RefineState();
}

class _RefineState extends State<Refine> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (BuildContext context, FilterViewModel viewModel, Widget _) {
        return viewModel.loading
            ? Container(
                height: MediaQuery.of(context).size.height * 0.8,
                color: tuna,
                child: Center(child: CircularProgressIndicator()))
            : Stack(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Container(
                        color: tuna,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InsiteText(
                                  text: "Current Filters:",
                                  fontWeight: FontWeight.bold,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                InsiteButton(
                                  bgColor: tango,
                                  textColor: Colors.white,
                                  onTap: () {
                                    viewModel.removeAllSelectedFilter();
                                  },
                                  width: 100,
                                  height: 30,
                                  title: "CLEAR ALL",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            viewModel.selectedFilterData.isNotEmpty
                                ? FilterChipView(
                                    filters: viewModel.selectedFilterData,
                                    onClosed: (value) {
                                      viewModel.removeSelectedFilter(value);
                                      // deSelect(value);
                                    },
                                    backgroundColor: chipBackgroundTwo,
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: EmptyView(
                                      title: "No Filter Selected",
                                      bg: tuna,
                                    ),
                                  ),
                            viewModel.selectedFilterData.isNotEmpty
                                ? SizedBox(
                                    height: 20,
                                  )
                                : SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InsiteButton(
                                  bgColor: tango,
                                  textColor: Colors.white,
                                  onTap: () {
                                    viewModel.onFilterApplied();
                                    Future.delayed(Duration(seconds: 2), () {
                                      widget.onRefineApplied(true);
                                    });
                                  },
                                  width: 100,
                                  height: 40,
                                  title: "OK",
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                ),
                                InsiteButton(
                                  bgColor: ship_grey,
                                  textColor: Colors.white,
                                  onTap: () {
                                    widget.onRefineApplied(false);
                                  },
                                  width: 100,
                                  height: 40,
                                  title: "CANCEL",
                                ),
                              ],
                            ),
                            viewModel.selectedFilterData.isNotEmpty
                                ? SizedBox(
                                    height: 8,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
      },
      viewModelBuilder: () => FilterViewModel(),
    );
  }
}
