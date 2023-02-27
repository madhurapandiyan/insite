import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class DeviceIdListWidget extends StatelessWidget {
  final Function? onSelected;
  final EdgeInsetsGeometry? padding;
  final double? size;
  final String? deviceId;
  final String? name;
  DeviceIdListWidget(
      {this.onSelected, this.deviceId, this.size, this.padding, this.name});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // contentPadding: padding,
      selectedTileColor: tango,
      onTap: onSelected as void Function()?,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          InsiteText(
            size: size,
            color: Theme.of(context).textTheme.bodyText2!.color,
            text: name,
          ),
          InsiteTextOverFlow(
            size: size,
            color: Theme.of(context).textTheme.bodyText2!.color,
            text: deviceId,
          ),
        ],
      ),
    );
  }
}
