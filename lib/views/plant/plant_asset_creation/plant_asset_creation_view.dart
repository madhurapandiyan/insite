import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/plant/plant_asset_creation/reusable_widget/asset_creation_reusable_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'plant_asset_creation_view_model.dart';

class PlantAssetCreationView extends StatefulWidget {
  @override
  _PlantAssetCreationViewState createState() => _PlantAssetCreationViewState();
}

class _PlantAssetCreationViewState extends State<PlantAssetCreationView> {
 
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlantAssetCreationViewModel>.reactive(
      builder: (BuildContext context, PlantAssetCreationViewModel viewModel,
          Widget _) {
        return InsiteScaffold(
            viewModel: viewModel,
            body: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 21.0),
                          child: InsiteText(
                            text: "asset creation".toUpperCase(),
                            fontWeight: FontWeight.w700,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: InsiteButton(
                              width: MediaQuery.of(context).size.width * 0.24,
                              height: MediaQuery.of(context).size.height * 0.06,
                              title: "Submit",
                              fontSize: 14,
                              bgColor: tango,
                              onTap: () {
                                viewModel.getAssetSerialData();
                                viewModel.getModelData();
                                viewModel.getDeviceIdData();
                                viewModel.getHrsMeterData();
                                //viewModel.validate(0);
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InsiteButton(
                            title: "",
                            icon: Icon(Icons.download),
                            onTap: () {
                              print("button is tapped");
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: viewModel.getassetCreationListData.length,
                      itemBuilder: (context, index) {
                        final dataModel =
                            viewModel.getassetCreationListData[index];
                        return AssetCreationReusablewidget(
                          modelData: dataModel.model,
                          onAssetSerialValueChange: (String value) {
                            viewModel.getAssetSerialListValue(value, index);
                          },
                          onModelValueChange: (String value) {
                            viewModel.getModelListValue(value, index);
                          },
                          onDeviceIdValueChange: (String value) {
                            viewModel.getDeviceIdListValue(value, index);
                          },
                          onHourMeterValueChange: (String value) {
                            viewModel.getHrsMeterListValue(value, index);
                          },
                        );
                      }),
                )
              ],
            ));
      },
      viewModelBuilder: () => PlantAssetCreationViewModel(),
    );
  }
}
