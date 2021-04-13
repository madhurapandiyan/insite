import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class PingDevice extends StatelessWidget {
  const PingDevice({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: tuna,
        border: Border.all(color: black, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_down,
                  color: white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Details'.toUpperCase(),
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Expanded(child: Container()),
                InsiteButton(
                  title: 'Ping Device'.toUpperCase(),
                  width: 90,
                  height: 40,
                  onTap: onTap,
                  bgColor: tango,
                  textColor: white,
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Registered Dealer',
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      'Dharwad - Training Dept',
                      style: TextStyle(color: white, fontSize: 18),
                    ),
                  ],
                ),
                Container(
                  width: 3,
                  height: 60,
                  color: mineShaft,
                ),
                Column(
                  children: [
                    Text(
                      'Device Type',
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      'TAP76',
                      style: TextStyle(color: white, fontSize: 18),
                    ),
                  ],
                ),
                Container(
                  width: 3,
                  height: 60,
                  color: mineShaft,
                ),
                Column(
                  children: [
                    Text(
                      'Serial No.',
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      'NG498917',
                      style: TextStyle(color: white, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
