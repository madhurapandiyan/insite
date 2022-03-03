import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class SelectedAssetsWidget extends StatefulWidget {
  final Asset? selectedAssetList;
  final VoidCallback? callBack;

  SelectedAssetsWidget({this.selectedAssetList, this.callBack});

  @override
  _SelectedAssetsWidgetState createState() => _SelectedAssetsWidgetState();
}

class _SelectedAssetsWidgetState extends State<SelectedAssetsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 3,
          child: InsiteImage(
            width: 38,
            height: 38,
            path: "assets/images/crane_small_login.png",
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 6,
          child: Container(
            child: InsiteTextOverFlow(
              text: widget.selectedAssetList!.assetSerialNumber,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 8,
          child: InsiteTextOverFlow(
            overflow: TextOverflow.ellipsis,
            text: widget.selectedAssetList!.makeCode! +
                " " +
                "\n" +
                widget.selectedAssetList!.model!,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        IconButton(
            onPressed: () {
              widget.callBack!();
            },
            icon: Icon(Icons.delete)),
      ],
    );
  }
}
