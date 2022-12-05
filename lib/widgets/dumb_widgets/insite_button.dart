import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class InsiteButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final Color? bgColor;
  final double? fontSize;
  final Color? textColor;
  final double? width;
  final double? height;
  final Icon? icon;
  final String? content;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool? isToShowBorder;

  final bool isSelectable;
  const InsiteButton(
      {this.title,
      this.content,
      this.width,
      this.onTap,
      this.isSelectable = false,
      this.margin,
      this.bgColor,
      this.padding,
      this.height,
      this.fontSize,
      this.icon,
      this.textColor,
      this.isToShowBorder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding != null ? padding : EdgeInsets.all(8),
        margin: margin != null ? margin : EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: isToShowBorder == null || isToShowBorder == true
              ? Border.all(color: Theme.of(context).textTheme.bodyText1!.color!)
              : null,
          color: bgColor != null ? bgColor : Theme.of(context).buttonColor,
        ),
        alignment: Alignment.center,
        height: height != null ? height : null,
        width: width != null ? width : null,
        child: Row(
          mainAxisAlignment: icon != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: fontSize != null ? fontSize : 12.0,
                  color: content != null
                      ? white
                      : Theme.of(context).textTheme.bodyText1!.color,
                  fontWeight: FontWeight.w700),
            ),
            icon != null ? icon! : SizedBox()
          ],
        ),
      ),
    );
  }
}

class InsitePopMenuItemButton extends StatelessWidget {
  final Color? bgColor;
  final double? fontSize;
  final Color? textColor;
  final double? width;
  final double? height;
  final Widget? widget;

  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool isSelectable;
  const InsitePopMenuItemButton(
      {this.width,
      this.widget,
      this.isSelectable = false,
      this.margin,
      this.bgColor,
      this.padding,
      this.height,
      this.fontSize,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin != null ? margin : EdgeInsets.all(0),
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).textTheme.bodyText1!.color!),
          color: bgColor != null ? bgColor : Theme.of(context).buttonColor,
        ),
        alignment: Alignment.center,
        height: height != null ? height : null,
        width: width != null ? width : null,
        child: widget);
  }
}

class InsiteButtonWithSelectable extends StatefulWidget {
  final String? title;
  final Function(bool)? onTap;
  final Color? bgColor;
  final double? fontSize;
  final Color? textColor;
  final double? width;
  final double? height;
  final Icon? icon;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool isSelectable;
  const InsiteButtonWithSelectable(
      {this.title,
      this.width,
      this.onTap,
      this.isSelectable = false,
      this.margin,
      this.bgColor,
      this.padding,
      this.height,
      this.fontSize,
      this.icon,
      this.textColor});

  @override
  _InsiteButtonWithSelectableState createState() =>
      _InsiteButtonWithSelectableState();
}

class _InsiteButtonWithSelectableState
    extends State<InsiteButtonWithSelectable> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onTap!(isSelected);
      },
      child: Container(
        padding: widget.padding != null ? widget.padding : EdgeInsets.all(8),
        margin: widget.margin != null ? widget.margin : EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border:
              Border.all(color: Theme.of(context).textTheme.bodyText1!.color!),
          color: widget.bgColor != null
              ? isSelected
                  ? Theme.of(context).buttonColor
                  : widget.bgColor
              : widget.bgColor,
        ),
        alignment: Alignment.center,
        height: widget.height != null ? widget.height : null,
        width: widget.width != null ? widget.width : null,
        child: Row(
          mainAxisAlignment: widget.icon != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: widget.fontSize != null ? widget.fontSize : 12.0,
                  color: widget.textColor != null
                      ? isSelected
                          ? widget.textColor
                          : Theme.of(context).textTheme.bodyText1!.color
                      : Theme.of(context).textTheme.bodyText1!.color,
                  fontWeight: FontWeight.w700),
            ),
            widget.icon != null ? widget.icon! : SizedBox()
          ],
        ),
      ),
    );
  }
}

class InsiteButtonWithLoader extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final Color? bgColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final Icon? icon;
  final bool? showLoad;
  const InsiteButtonWithLoader(
      {this.title,
      this.width,
      this.showLoad,
      this.onTap,
      this.bgColor,
      this.height,
      this.icon,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).textTheme.bodyText1!.color!),
          borderRadius: BorderRadius.circular(4),
          color: bgColor != null ? bgColor : Theme.of(context).buttonColor,
        ),
        alignment: Alignment.center,
        height: height != null ? height : null,
        width: width != null ? width : null,
        child: Row(
          mainAxisAlignment: icon != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            showLoad!
                ? InsiteProgressBar()
                : Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.w700),
                  ),
            icon != null ? icon! : SizedBox()
          ],
        ),
      ),
    );
  }
}

class InsiteRadioButton extends StatelessWidget {
  final String? text;
  final bool? isSelected;

  void Function()? onChanged;

  InsiteRadioButton({
    Key? key,
    this.onChanged,
    this.text,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged!();
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 80,
          top: 15,
        ),
        child: Row(
          children: [
            CircleAvatar(
                radius: 10,
                backgroundColor: isSelected!
                    ? Theme.of(context).buttonColor
                    : Theme.of(context).buttonColor.withOpacity(0.1)),
            SizedBox(
              width: 10,
            ),
            InsiteText(
              text: text,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class InsiteDropDownButton extends StatelessWidget {
  final Object? value;
  final void Function(Object?)? onChanged;
  final List<DropdownMenuItem<Object>>? items;
  InsiteDropDownButton({
    Key? key,
    this.value,
    this.onChanged,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.60,
      //height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1, color: black),
        shape: BoxShape.rectangle,
      ),
      child: DropdownButton(
        isExpanded: true,
        iconSize: 25,
        elevation: 16,
        style: TextStyle(
            overflow: TextOverflow.fade,
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700),
        value: value,
        dropdownColor: Theme.of(context).backgroundColor,
        underline: Container(
          padding: const EdgeInsets.only(left: 4, right: 4),
        ),
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}
