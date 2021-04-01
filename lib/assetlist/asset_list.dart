import 'package:flutter/material.dart';
import 'package:insite/assetlist/model.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/asset_item.dart';

class AssetList extends StatefulWidget {
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
            child: Column(
              children: [
                ListView.builder(
                    itemCount: assetList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(6),
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Asset name = assetList[index];
                      return AssetItem(
                        asset: name,
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
