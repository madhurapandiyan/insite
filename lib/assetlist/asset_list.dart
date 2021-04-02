import 'package:flutter/material.dart';
import 'package:insite/assetlist/model.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/smart_widgets/asset_item.dart';

class AssetList extends StatefulWidget {
  final VoidCallback onDetailPageSelected;
  AssetList({this.onDetailPageSelected});
  @override
  _AssetListState createState() => _AssetListState();
}

class _AssetListState extends State<AssetList> {
  @override
  Widget build(BuildContext context) {
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
                ListView.builder(
                    itemCount: assetList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8),
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Asset name = assetList[index];
                      return AssetItem(
                        asset: name,
                        onCallback: () {
                          widget.onDetailPageSelected();
                        },
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
