import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/subscription/replacement/model/device_search_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

import 'deviceId_widget_list.dart';

class ShowingOldDeviceDetail extends StatelessWidget {
  final String? deviceId;
  final String? Vin;
  final String? modelName;
  final String? date;
  final Function? onBackPressed;
  final Function? onNextPressed;
  final List<DeviceContainsList> searchList;
  final Function(int)? onSelectedDeviceId;
  final Function(String)? onEnteringDeviceId;
  final TextEditingController? searchTextController;
  final Function? onSearching;
  ShowingOldDeviceDetail(
      {this.deviceId,
      this.modelName,
      this.Vin,
      this.date,
      this.onBackPressed,
      required this.searchList,
      this.onNextPressed,
      this.onSelectedDeviceId,
      this.onEnteringDeviceId,
      this.searchTextController,
      this.onSearching});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spacee,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InsiteText(
              text: "Enter Old Device ID",
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
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
            SizedBox(width: 10),
            searchList.isEmpty
                ? SizedBox()
                : Container(
                    margin: EdgeInsets.all(8),
                    // height: 120,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    child: Column(
                      children: List.generate(
                          searchList.length,
                          (i) => SingleChildScrollView(
                                child: DeviceIdListWidget(
                                    onSelected: () {
                                      onSelectedDeviceId!(i);
                                      FocusScope.of(context).unfocus();
                                    },
                                    deviceId: searchList[i].containsList),
                              )),
                    )),
            SizedBox(
              height: 10,
            ),
            InsiteButton(
              textColor: Theme.of(context).textTheme.bodyText1!.color,
              onTap: () {
                onSearching!();
              },
              // bgColor: white,
              title: "Search",
              height: MediaQuery.of(context).size.height * 0.05,
              // width: MediaQuery.of(context).size.width * 0.3,
            ),
            SizedBox(
              height: 10,
            ),
            InsiteText(
              fontWeight: FontWeight.w500,
              text: "Device ID :",
              size: 18,
            ),
            SizedBox(height: 5),
            InsiteText(
              fontWeight: FontWeight.w500,
              text: deviceId,
              size: 18,
            ),
            SizedBox(height: 15),
            InsiteText(
              fontWeight: FontWeight.w500,
              text: "Machine Serial No. (VIN)",
              size: 18,
            ),
            SizedBox(height: 5),
            InsiteText(
              fontWeight: FontWeight.w500,
              text: Vin,
              size: 18,
            ),
            SizedBox(height: 15),
            InsiteText(
              fontWeight: FontWeight.w500,
              text: "Model : ",
              size: 18,
            ),
            SizedBox(height: 5),
            InsiteText(
              fontWeight: FontWeight.w500,
              text: modelName,
              size: 18,
            ),
            SizedBox(height: 15),
            InsiteText(
              fontWeight: FontWeight.w500,
              text: "Subscription Start Date :",
              size: 18,
            ),
            SizedBox(height: 5),
            InsiteText(
              fontWeight: FontWeight.w500,
              text: date,
              size: 18,
            ),
            SizedBox(height: 25),
            InsiteButton(
              textColor: Theme.of(context).textTheme.bodyText1!.color,
              onTap: () {
                onNextPressed!();
              },
              // bgColor: white,
              title: "Next",
              height: MediaQuery.of(context).size.height * 0.05,
              // width: MediaQuery.of(context).size.width * 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
