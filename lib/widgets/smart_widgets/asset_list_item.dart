import 'package:flutter/material.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/date_slider.dart';
import 'package:intl/intl.dart';
import 'insite_expansion_tile.dart';

class AssetOperationListItem extends StatelessWidget {
  final Asset asset;
  final List<DateTime> days;
  final VoidCallback onCallback;
  const AssetOperationListItem({
    this.asset,
    this.onCallback,
    this.days,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCallback();
      },
      child: Card(
        color: cardcolor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: cardcolor)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.black,
                  //         borderRadius: BorderRadius.all(Radius.circular(4))),
                  //     child: Icon(Icons.crop_square, color: Colors.black)),
                ],
              ),
            ),
            Expanded(
              child: InsiteExpansionTile(
                title: Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FlexColumnWidth(5),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      children: [
                        InsiteTableRowItemWithImage(
                          title: asset != null
                              ? Utils.getMakeTitle(asset.makeCode) +
                                  "\n" +
                                  asset.model
                              : "",
                          path: asset == null
                              ? "assets/images/EX210.png"
                              : Utils().imageData(asset.model),
                        ),
                        InsiteTableRowItem(
                          title: "Total Duration",
                          content: asset.dateRangeRuntimeDuration != null
                              ? (asset.dateRangeRuntimeDuration / (60 * 60))
                                      .roundToDouble()
                                      .toString() +
                                  " Hrs"
                              : "-",
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        InsiteRichText(
                          title: "Serial No. ",
                          content: asset.serialNumber,
                          onTap: () {
                            onCallback();
                          },
                        ),
                        InsiteTableRowItem(
                          title: "Distance Travelled Kilometers",
                          content: asset != null &&
                                  asset.distanceTravelledKilometers != null
                              ? asset.distanceTravelledKilometers.toString()
                              : "-",
                        ),
                      ],
                    ),
                  ],
                ),
                tilePadding: EdgeInsets.all(0),
                children: [
                  DateSlider(
                    list: getSliderData(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<SliderData> getSliderData() {
    List<SliderData> list = [];
    for (DateTime time in days) {
      String day = DateFormat('EEE').format(time);
      SliderData data = SliderData(
          day: day,
          date: time.day.toString(),
          value: getMatchingDate(time) != null
              ? (getMatchingDate(time).totalRuntimeDurationSeconds / (60 * 60))
                  .roundToDouble()
                  .toString()
              : "-");
      list.add(data);
    }
    return list;
  }

  AssetLocalDate getMatchingDate(DateTime matchDateTime) {
    AssetLocalDate matchingDate;
    for (AssetLocalDate assetDate in asset.assetLocalDates) {
      DateTime dateTime = DateTime.parse(assetDate.assetLocalDate);
      if (matchDateTime == dateTime) {
        matchingDate = assetDate;
        break;
      }
    }
    return matchingDate;
  }
}
