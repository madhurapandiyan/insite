import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          backgroundColor: appbarcolor,
          leading: IconButton(
            icon: SvgPicture.asset("assets/images/menubar.svg"),
            onPressed: () => print("button is tapped"),
          ),
          title: appLogo,
        ));
  }

  Image appLogo = new Image(
      image: new ExactAssetImage("assets/images/hitachi.png"),
      height: 65.75,
      width: 33.21,
      alignment: FractionalOffset.center);
}
