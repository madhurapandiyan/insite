import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/subscription/replacement/model/device_search_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

import 'deviceId_widget_list.dart';

class OldDeviceIdSearchWidget extends StatelessWidget {
  final List<DeviceContainsList>? searchList;
  final TextEditingController? searchTextController;
  final Function(String)? onEnteringDeviceId;
  final Function(int)? onSelectedDeviceId;
  final Function? onSearchingDeviceId;
  final bool isGettingOldDeviceId;

  OldDeviceIdSearchWidget(
      {this.searchList,
      this.searchTextController,
      this.onEnteringDeviceId,
      this.onSelectedDeviceId,
      this.onSearchingDeviceId,
      required this.isGettingOldDeviceId});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsiteText(
            text: "Enter Old Device ID",
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: CustomTextBox(
              controller: searchTextController,
              onChanged: (value) {
                onEnteringDeviceId!(value);
              },
              suffixWidget: Icon(
                Icons.search,
                color: white,
              ),
            ),
          ),
          searchList!.isEmpty
              ? SizedBox()
              : Container(
                  margin: EdgeInsets.all(8),
                  // height: 50,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  child: Column(
                    children: List.generate(
                        searchList!.length,
                        (i) => DeviceIdListWidget(
                            onSelected: () {
                              onSelectedDeviceId!(i);
                              FocusScope.of(context).unfocus();
                            },
                            deviceId: searchList![i].containsList)),
                  )),
          SizedBox(
            height: 10,
          ),
          isGettingOldDeviceId
              ? InsiteButton(
                  onTap: () {
                    onSearchingDeviceId!();
                  },
                  textColor: white,
                  fontSize: 17,
                  height: MediaQuery.of(context).size.height * 0.05,
                  title: "Search")
              : SizedBox(),
          SizedBox(
            height: 10,
          )
        ]);
  }
}
