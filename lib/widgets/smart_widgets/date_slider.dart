import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:flutter/src/painting/basic_types.dart' as axis;
import 'package:logger/logger.dart';

import '../../utils/enums.dart';

class DateSlider extends StatelessWidget {
  final List<SliderData>? list;
  final Function(FilterData date)? sliderCallBack;
  const DateSlider({this.list, this.sliderCallBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list!.length,
        itemBuilder: (context, index) {
          SliderData data = list![index];

          return GestureDetector(
            onTap: () {
              DateTime fromDate = data.dateTime!;
              DateTime toDate = data.dateTime!;

              FilterData sliderDateTime = FilterData(
                  title: "Date Range",
                  count: describeEnum(DateRangeType.today),
                  extras: [
                    '${fromDate.year}-${fromDate.month}-${fromDate.day}',
                    '${toDate.year}-${toDate.month}-${toDate.day}',
                    describeEnum(DateRangeType.today)
                  ],
                  isSelected: true,
                  type: FilterType.DATE_RANGE);
              sliderCallBack!(sliderDateTime);
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InsiteText(
                    size: 14,
                    text: data.date,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InsiteText(
                    size: 14,
                    text: data.day,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(padding: EdgeInsets.all(2)),
                Container(
                  color: mineShaft,
                  height: 2,
                  width: 50,
                ),
                Padding(padding: EdgeInsets.all(2)),
                data.value!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InsiteText(
                          size: 14,
                          text: "-",
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : InsiteButton(
                        title: data.value,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        textColor: Theme.of(context).textTheme.bodyText1!.color,
                      ),
              ],
            ),
          );
        },
        scrollDirection: axis.Axis.horizontal,
      ),
    );
  }
}

class SliderData {
  final String? date;
  final String? day;
  final String? value;
  final DateTime? dateTime;
  SliderData({this.date, this.day, this.value, this.dateTime});
}
