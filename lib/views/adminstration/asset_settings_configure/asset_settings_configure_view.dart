import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/adminstration/asset_settings_configure/model/configure_grid_view_model.dart';
import 'package:insite/views/adminstration/asset_settings_configure/model/transport_grid_view-widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/insite_search_box.dart';
import 'package:stacked/stacked.dart';
import 'asset_settings_configure_view_model.dart';

class AssetSettingsConfigureView extends StatefulWidget {
  final String assetUids;

  AssetSettingsConfigureView({this.assetUids});
  @override
  _AssetSettingsConfigureViewState createState() =>
      _AssetSettingsConfigureViewState();
}

class _AssetSettingsConfigureViewState
    extends State<AssetSettingsConfigureView> {
  String dropDownValue = "Select";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetSettingsConfigureViewModel>.reactive(
        builder: (BuildContext context,
            AssetSettingsConfigureViewModel viewModel, Widget _) {
          return InsiteScaffold(
              viewModel: viewModel,
              body: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          InsiteText(
                            text: "Configure",
                            fontWeight: FontWeight.w700,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                              child: Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CustomDropDownWidget(
                                  items: viewModel.items,
                                  value: dropDownValue,
                                  onChanged: (String value) {
                                    dropDownValue = value;
                                    viewModel.displayList =
                                        viewModel.staticTranspotData;
                                    setState(() {});
                                    print("dropDownValue:$dropDownValue");
                                  }),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      dropDownValue == "Asset Icon"
                          ? Flexible(child: trasportCateoryItem(viewModel))
                          : SizedBox()
                    ],
                  ),
                  viewModel.isLoading ? InsiteProgressBar() : SizedBox()
                ],
              ));
        },
        viewModelBuilder: () =>
            AssetSettingsConfigureViewModel(widget.assetUids));
  }

  Widget trasportCateoryItem(AssetSettingsConfigureViewModel viewModel) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: SearchBox(
                  hint: "Search Icon",
                  controller: viewModel.textEditingController,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InsiteButton(
              title: "",
              onTap: () {
                viewModel.getSortData();
              },
              icon: viewModel.isSort
                  ? Icon(Icons.sort_sharp)
                  : Icon(Icons.sort_by_alpha_sharp),
              bgColor: Theme.of(context).backgroundColor,
            )
          ],
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 1000
                        ? 7
                        : MediaQuery.of(context).size.width > 600
                            ? 5
                            : 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0),
                itemCount: viewModel.displayList.length,
                reverse: viewModel.isSort ? true : false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ConfigureGridViewModel item = viewModel.displayList[index];
                  return TransportGridViewWidget(
                    index: index,
                    selectedIndex: viewModel.selectedIndex,
                    items: item,
                    voidCallback: () {
                      viewModel.buttontap(index);
                    },
                  );
                }),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InsiteButton(
                width: MediaQuery.of(context).size.width * 0.20,
                height: MediaQuery.of(context).size.height * 0.04,
                title: "Cancel",
                fontSize: 12,
                textColor: textcolor,
                bgColor: tango,
                onTap: () {
                  Navigator.pop(context);
                }),
            SizedBox(
              width: 8,
            ),
            InsiteButton(
                width: MediaQuery.of(context).size.width * 0.20,
                height: MediaQuery.of(context).size.height * 0.04,
                title: "Save",
                fontSize: 12,
                textColor: textcolor,
                bgColor: tango,
                onTap: () {
                  viewModel.getAssetIconData();
                }),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
