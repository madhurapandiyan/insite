import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insite/theme/colors.dart';

class Reusabletapbutton extends StatelessWidget {
  //const Reusabletapbutton({Key? key}) : super(key: key);
  final String buttonimg;
  final bool istap;
  Reusabletapbutton(this.buttonimg,this.istap);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: istap?Theme.of(context).cardColor:tuna,
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: tuna)],
        border: Border.all(width: 2.5, color: tuna),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
      ),
      child: SvgPicture.asset(
        buttonimg,
        fit: BoxFit.none,
      ),
    );
  }
}
