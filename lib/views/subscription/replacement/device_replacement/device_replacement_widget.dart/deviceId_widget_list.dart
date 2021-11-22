import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class DeviceIdListWidget extends StatelessWidget {
  final Function onSelected;

  final String deviceId;
  DeviceIdListWidget({this.onSelected, this.deviceId});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedTileColor: tango,
      onTap: onSelected,
      tileColor: tango,
      title: InsiteText(
        color: black,
        text: deviceId,
      ),
    );
  }
}
