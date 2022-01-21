import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/add_group/model/add_group_model.dart';
import 'package:insite/views/adminstration/add_group/selection_widget/selection_widget_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_image.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class SelectedAssetsWidget extends StatefulWidget {
  final AddGroupModel? selectedAssetList;
  final VoidCallback? callBack;

  SelectedAssetsWidget({this.selectedAssetList, this.callBack});

  @override
  _SelectedAssetsWidgetState createState() => _SelectedAssetsWidgetState();
}

class _SelectedAssetsWidgetState extends State<SelectedAssetsWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
        // GestureDetector(
        //   onTap: () {
        //     isChecked = !isChecked;
        //     setState(() {});
        //   },
        //   child: isChecked
        //       ? Container(
        //           width: 20,
        //           height: 20,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               border: Border.all(
        //                 color: silver,
        //               ),
        //               color: tango),
        //         )
        //       : Container(
        //           width: 20,
        //           height: 20,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               border: Border.all(
        //                 color: silver,
        //               )),
        //         ),
        // ),

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
          flex: 4,
          child: Container(
            child: InsiteTextOverFlow(
              text: widget.selectedAssetList!.serialNo,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 5,
          child: Container(
            child: InsiteTextOverFlow(
              overflow: TextOverflow.ellipsis,
              text: widget.selectedAssetList!.make! +
                  " " +
                  "\n" +
                  widget.selectedAssetList!.model!,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 3,
          child: IconButton(
              onPressed: () {
                widget.callBack!();
              },
              icon: Icon(Icons.delete)),
        )
      ],
    );
  }
}
