import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:logger/logger.dart';
import 'insite_image.dart';
import 'insite_text.dart';

class InsiteTableRowItem extends StatelessWidget {
  final String? title;
  final dynamic content;
  final TextOverflow? overFlow;
  final Color? unVerifiedUserColor;

  const InsiteTableRowItem(
      {this.title, this.content, this.overFlow, this.unVerifiedUserColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsiteTextOverFlow(
            text: title,
            size: 14,
            fontWeight: FontWeight.bold,
            overflow: overFlow != null ? overFlow : null,
          ),
          InsiteText(
            text: content.toString(),
            color: unVerifiedUserColor != null
                ? unVerifiedUserColor
                : Theme.of(context).textTheme.bodyText1!.color,
          )
        ],
      ),
    );
  }
}

class InsiteTableRowItemWithImage extends StatelessWidget {
  final String? title;
  final String? path;

  const InsiteTableRowItemWithImage({this.title, this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1!.color!),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: InsiteImage(
              height: 30,
              width: 50,
              path: path,
            ),
          ),
          Expanded(
            child: InsiteText(
              text: title,
              size: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  imageData(String model) {
    if (model.contains("SHINRAI")) {
      return "assets/images/shinrai.png";
    } else if (model.contains("EX130")) {
      return "assets/images/EX130.png";
    } else if (model.contains("EX210")) {
      return "assets/images/EX210.png";
    } else if (model.contains("EX210LC")) {
      return "assets/images/EX210LC.png";
    } else if (model.contains("TH86")) {
      return "assets/images/TH86.png";
    } else if (model.contains("TL340H")) {
      return "assets/images/TL340H.png";
    } else {
      return "assets/images/EX210.png";
    }
  }
}

class InsiteTableRowItemWithImageWithContent extends StatelessWidget {
  final String? title;
  final String? path;
  final String? content;
  final Color? contentColor;

  const InsiteTableRowItemWithImageWithContent(
      {this.title, this.path, this.content, this.contentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1!.color!),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: InsiteImage(
              height: 30,
              width: 50,
              path: path,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InsiteText(
                text: title,
                size: 14,
                fontWeight: FontWeight.bold,
              ),
              InsiteText(
                text: content,
                color: contentColor,
                size: 14,
                fontWeight: FontWeight.bold,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class InsiteTableRowItemWithIcon extends StatelessWidget {
  final String? title;
  final String? iconPath;
  const InsiteTableRowItemWithIcon({this.title, this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: InsiteText(
              text: title,
              size: 14,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}

class InsiteTableRowItemWithButton extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? buttonColor;
  final Function? onTap;
  const InsiteTableRowItemWithButton(
      {this.title, this.buttonColor, this.content, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsiteText(
            text: title,
            size: 14,
            fontWeight: FontWeight.bold,
          ),
          content!.isNotEmpty
              ? InsiteButton(
                  content: content,
                  bgColor: buttonColor != null ? buttonColor : buttonColorFive,
                  title: content,
                  padding: EdgeInsets.all(0),
                  height: 25,
                  width: 70,
                  fontSize: 12,
                  onTap: () {
                    onTap!();
                  },
                )
              : InsiteText(
                  text: "-",
                  color: athenGrey,
                  size: 14,
                  fontWeight: FontWeight.bold,
                ),
        ],
      ),
    );
  }
}

class InsiteTableRowItemWithRowButton extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? buttonColor;
  final Function? onTap;
  const InsiteTableRowItemWithRowButton(
      {this.title, this.buttonColor, this.content, this.onTap});

  @override
  Widget build(BuildContext context) {
    Logger().v(content);
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InsiteText(
            text: title,
            size: 14,
            fontWeight: FontWeight.bold,
          ),
          content!.isNotEmpty
              ? InsiteButton(
                  content: content,
                  bgColor: buttonColor != null ? buttonColor : buttonColorFive,
                  title: content,
                  padding: EdgeInsets.all(0),
                  height: 25,
                  width: 70,
                  fontSize: 11,
                  onTap: () {
                    //onTap!();
                  },
                )
              : InsiteText(
                  text: "-",
                  color: athenGrey,
                  size: 14,
                  fontWeight: FontWeight.bold,
                ),
        ],
      ),
    );
  }
}

class InsiteTableRowItemWithMultipleButton extends StatelessWidget {
  final String? title;
  final List<dynamic>? texts;
  const InsiteTableRowItemWithMultipleButton({
    this.title,
    this.texts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsiteText(
            text: title,
            size: 14,
            fontWeight: FontWeight.bold,
          ),
          Container(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                texts!.length,
                (index) {
                  Count text = texts![index];
                  return text.count! > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 4),
                          child: InsiteButton(
                            content: text.countOf,
                            bgColor: Utils.getFaultColor(text.countOf),
                            title: text.count.toString(),
                            padding: EdgeInsets.all(0),
                            height: 25,
                            width: 40,
                            fontSize: 10,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4),
                          child: InsiteText(
                            text: "  -  ",
                            size: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
