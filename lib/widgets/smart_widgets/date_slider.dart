import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:flutter/src/painting/basic_types.dart' as axis;

class DateSlider extends StatelessWidget {
  final List<SliderData> list;
  const DateSlider({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          SliderData data = list[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InsiteText(
                  size: 14,
                  text: data.date,
                  fontWeight: FontWeight.w700,
                  color: athenGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InsiteText(
                  size: 14,
                  text: data.day,
                  color: athenGrey,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InsiteText(
                  size: 14,
                  text: data.value,
                  fontWeight: FontWeight.w700,
                  color: athenGrey,
                ),
              ),
            ],
          );
        },
        scrollDirection: axis.Axis.horizontal,
      ),
    );
  }
}

class SliderData {
  final String date;
  final String day;
  final String value;
  SliderData({this.date, this.day, this.value});
}
