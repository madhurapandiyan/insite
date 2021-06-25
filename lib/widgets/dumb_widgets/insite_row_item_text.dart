import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'insite_image.dart';
import 'insite_text.dart';

class InsiteTableRowItem extends StatelessWidget {
  final String title;
  final String content;
  
  const InsiteTableRowItem({this.title, this.content,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsiteText(
            text: title,
            color: athenGrey,
            fontWeight: FontWeight.bold,
          ),
          InsiteText(
            text: content,
            fontWeight: FontWeight.normal,
            color: textcolor,
          )
        ],
      ),
    );
  }
}

class InsiteTableRowWithImage extends StatelessWidget {
  final String title;
  final String path;
  
  const InsiteTableRowWithImage({this.title, this.path});

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
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: InsiteImage(
              height: 30,
              width: 50,
              path:path,
            ),
          ),
          Expanded(
            child: InsiteText(
              text: title,
              color: athenGrey,
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

class InsiteTableRowIcon extends StatelessWidget {
  final String title;
  final String iconPath;
  const InsiteTableRowIcon({this.title, this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
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
          InsiteText(
            text: title,
            fontWeight: FontWeight.normal,
            color: textcolor,
          )
        ],
      ),
    );
  }
 
}
