import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class DeviceIdListWidget extends StatelessWidget {
  final Function? onSelected;
  final EdgeInsetsGeometry? padding;
  final double? size;
  final String? deviceId;
  DeviceIdListWidget({this.onSelected, this.deviceId, this.size, this.padding});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: padding,
      selectedTileColor: tango,
      onTap: onSelected as void Function()?,
      tileColor: Theme.of(context).textTheme.bodyText1!.color,
      title: InsiteTextOverFlow(
        size: size,
        color: Theme.of(context).cardColor,
        text: deviceId,
      ),
    );
  }
}
