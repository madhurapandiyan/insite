import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class Notifications extends StatelessWidget {
  const Notifications({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        color: tuna,
        border: Border.all(color: black, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                // Icon(
                //   Icons.keyboard_arrow_down,
                //   color: white,
                // ),
                SizedBox(
                  width: 10,
                ),
                InsiteText(
                    text: 'NOTIFICATIONS',
                    color: white,
                    fontWeight: FontWeight.bold,
                    size: 15),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.22,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(
                    const Radius.circular(30.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: mediumgrey,
                      border: Border.all(color: black, width: 0.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Center(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: InsiteText(
                              text: 'No Notifications',
                              fontWeight: FontWeight.bold,
                              size: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
