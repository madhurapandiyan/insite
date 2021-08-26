import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class ReusableDropDown extends StatelessWidget {
 final String title;
 final String name;
 ReusableDropDown({this.title,this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        InsiteButton(
          width: 60,
          height: 29,
          title: title,
          bgColor: cardcolor,
          textColor: silver,
          fontSize: 11,
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 1,
          child: new Text(
            name,
            style: TextStyle(
                color: silver,
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SvgPicture.asset(
            "assets/images/arrowdown.svg",
            width: 10,
            height: 10,
          ),
        ),
      ],
    );
  }
}
