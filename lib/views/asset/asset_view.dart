import 'package:flutter/material.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/asset/asset_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/smart_widgets/asset_item.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class AssetView extends StatefulWidget {
  final VoidCallback onDetailPageSelected;
  AssetView({this.onDetailPageSelected});
  @override
  _AssetViewState createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext context, AssetViewModel viewModel, Widget _) {
        return Scaffold(
            backgroundColor: bgcolor,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InsiteButton(
                            title: "ASSET ID",
                            height: 40,
                            onTap: () {},
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            textColor: Colors.white,
                            width: 120,
                            bgColor: tuna,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InsiteButton(
                            title: "Date Range",
                            height: 40,
                            onTap: () {},
                            textColor: Colors.white,
                            width: 100,
                            bgColor: tuna,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Data displayed here is only an indicative figure. For viewing actual Asset usage per day, visit Asset Utilization - Single Asset View ",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    viewModel.loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : viewModel.assets.isNotEmpty
                            ? ListView.builder(
                                itemCount: viewModel.assets.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(8),
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Asset asset = viewModel.assets[index];
                                  return AssetItem(
                                    asset: asset,
                                    onCallback: () {
                                      widget.onDetailPageSelected();
                                    },
                                  );
                                })
                            : Center(
                                child: Text(
                                  "No Results",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              )
                  ],
                ),
              ),
            ));
      },
      viewModelBuilder: () => AssetViewModel(),
    );
  }
}
