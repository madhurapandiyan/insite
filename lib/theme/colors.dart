import 'package:flutter/material.dart';

const Color transparent = Colors.transparent;
const Color black = Colors.black;
const Color white = Colors.white;
const Color mercury = Color(0xFFE5E5E5);
const Color tango = Color(0xffF37021);
const Color tuna = Color(0xFF303238);
const Color thunder = Color(0xFF211F20);
const Color cod_grey = Color(0xff0C0B0B);
const Color ship_grey = Color(0xff414042);
const Color bgcolor = Color(0xff211F20);
const Color appbarcolor = Color(0xffFFFFFF);
const Color cardcolor = Color(0xff303238);
const Color upperCardColor = Color(0xFF414042);
const Color textcolor = Color(0xffEBEBF2);
const Color athenGrey = Color(0xFFEBEBF2);
const Color darkGrey = Color(0xFF211F20);
const Color containercolor = Color(0xffEEEEEE);
const Color tabpagecolor = Color(0xffC4C4C4);
const Color mediumgrey = Color(0xff414042);
const Color silver = Color(0xFFCCCCCC);
const Color mineShaft = Color(0xFF282828);
const Color burntSienna = Color(0xFFEB5757);
const Color mustard = Color(0xFFFDE050);
const Color shark = Color(0xFF2B2D32);
const Color emerald = Color(0xFF48C581);
const Color creamCan = Color(0xFFF2C94C);
const Color doveGray = Color(0xFF666666);
const Color greencolor = Color(0xffABEFCA);
const Color maptextcolor = Color(0xff666666);
const Color darkhighlight = Color(0xff2B2D32);
const Color concrete = Color(0xFFF3F3F3);
const Color sandyBrown = Color(0xFFF29756);
const Color bermudaGrey = Color(0xFF7A83A7);
const Color lightRose = Color(0xffFBAE8D);
const greenGradient = [emerald, emerald];
const redGradient = [burntSienna, burntSienna];
const orangeGradient = [sandyBrown, sandyBrown];
const yellowGradient = [mustard, mustard];
const whiteGradient = [textcolor, textcolor];
const Color periwinkleGrey = Color(0xFFB7BEE3);
const Color olivine = Color(0xFF8EB685);
const Color persianIndigo = Color(0xFF53168F);
final kNeumorphicColors = [emerald, concrete, mustard, burntSienna];

//chip background
const Color chipBackgroundOne = Color(0xff303238);
const Color chipBackgroundTwo = Color(0xff211F20);

//card background
const Color cardBackgroundOne = Color(0xff303238);

//buttonColor
const Color buttonColorFive = Color(0xffEB5757);

// borderLineColor
const Color borderLineColor = Color(0xFF282828);

//addUserbgColor
const addUserBgColor = Color(0XFF0C0B0B);

//blue/white theme
const backgroundColor1 = Color(0XFFFFFFFF);
const appBarbackgroundColor1 = Color(0XFF0C0B0B);
const cardBackgroundColor1 = Color(0XFFFFFFFF);
const cardSelectedBackgroundColor1 = Color(0XFFFFFFFF);
const textColor1 = Color(0XFF000000);
const iconColor1 = Color(0XFF000000);
const textSelectedColor1 = Color(0XFF000000);
const buttonColor1 = Color(0XFF00437A);
const buttonColor2 = Color(0XFFFFFFFF);
const buttonSelectedColor1 = Color(0XFF00437A);
const dividerColor1 = Color(0XFF000000);
const upperCardColor1 = Color(0XFFFFFFFF);

//orange/black theme
const backgroundColor2 = Color(0xFF211F20);
const backgroundColor3 = Color(0xFF656465);
const appBarbackgroundColor2 = Color(0XFFFFFFFF);
const cardBackgroundColor2 = Color(0XFF303238);
const cardSelectedBackgroundColor2 = Color(0XFF000000);
const textColor2 = Color(0XFFFFFFFF);
const iconColor2 = Color(0XFFFFFFFF);
const textSelectedColor2 = Color(0XFFFFFFFF);
const buttonColor21 = Color(0xffF37021);
const buttonColor22 = Color(0XFF000000);
const buttonSelectedColor2 = Color(0xffF37021);
const dividerColor2 = Color(0XFF000000);
const upperCardColor2 = Color(0xFF414042);

var indiaStackBlueWhite = ThemeData(
    cardColor: cardBackgroundColor1,
    backgroundColor: backgroundColor1,
    fontFamily: 'Roboto',
    buttonColor: buttonColor1,
    primaryColor: backgroundColor1,
    dividerColor: dividerColor1,
    indicatorColor: upperCardColor1,
    canvasColor: buttonColor1,
    iconTheme: IconThemeData(
      color: iconColor1,
    ),
    cardTheme: CardTheme(
        color: cardBackgroundColor1,
        elevation: 10.0,
        shadowColor: cardBackgroundColor1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white, width: 1))),
    buttonTheme: ButtonThemeData(
      buttonColor: buttonColor1,
    ),
    accentTextTheme: TextTheme(bodyText1: TextStyle(color: textColor1)),
    primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: textColor1, fontWeight: FontWeight.bold)),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: textColor1),
        subtitle1: TextStyle(color: textColor1)),
    appBarTheme: AppBarTheme(backgroundColor: Colors.white),
    accentColor: Colors.white);

var indiaStackOrangeBlack = ThemeData(
    cardColor: cardBackgroundColor2,
    backgroundColor: backgroundColor3,
    fontFamily: 'Roboto',
    buttonColor: buttonColor21,
    dividerColor: dividerColor2,
    indicatorColor: upperCardColor2,
    canvasColor: Colors.white,
    iconTheme: IconThemeData(
      color: iconColor2,
    ),
    primaryColor: backgroundColor3,
    cardTheme: CardTheme(
        color: cardBackgroundColor2,
        elevation: 10.0,
        shadowColor: cardBackgroundColor2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: cardBackgroundColor2, width: 1))),
    buttonTheme: ButtonThemeData(
      buttonColor: buttonColor21,
    ),
    accentTextTheme: TextTheme(bodyText1: TextStyle(color: textColor2)),
    primaryTextTheme: TextTheme(bodyText1: TextStyle(color: textColor2)),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: textColor2),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: appBarbackgroundColor2,
    ),
    accentColor: Colors.white);
    

// const Color transparent = Colors.transparent;
// const Color black = Colors.black;
// const Color white = Colors.white;
// const Color mercury = Color(0xFFE5E5E5);
// const Color tango = Color(0xffF37021);
// const Color tuna = Color(0xFF303238);
// const Color thunder = Color(0xFF211F20);
// const Color cod_grey = Color(0xff0C0B0B);
// const Color ship_grey = Color(0xff414042);
// const Color bgcolor = Color(0xff211F20);
// const Color appbarcolor = Color(0xffFFFFFF);
// const Color cardcolor = Color(0xff303238);
// const Color upperCardColor = Color(0xFF414042);
// const Color textcolor = Color(0xffEBEBF2);
// const Color athenGrey = Color(0xFFEBEBF2);
// const Color darkGrey = Color(0xFF211F20);
// const Color containercolor = Color(0xffEEEEEE);
// const Color tabpagecolor = Color(0xffC4C4C4);
// const Color mediumgrey = Color(0xff414042);
// const Color silver = Color(0xFFCCCCCC);
// const Color mineShaft = Color(0xFF282828);
// const Color burntSienna = Color(0xFFEB5757);
// const Color mustard = Color(0xFFFDE050);
// const Color shark = Color(0xFF2B2D32);
// const Color emerald = Color(0xFF48C581);
// const Color creamCan = Color(0xFFF2C94C);
// const Color doveGray = Color(0xFF666666);
// const Color greencolor = Color(0xffABEFCA);
// const Color maptextcolor = Color(0xff666666);
// const Color darkhighlight = Color(0xff2B2D32);
// const Color concrete = Color(0xFFF3F3F3);
// const Color sandyBrown = Color(0xFFF29756);
// const Color bermudaGrey = Color(0xFF7A83A7);
// const Color lightRose = Color(0xffFBAE8D);
// const greenGradient = [emerald, emerald];
// const redGradient = [burntSienna, burntSienna];
// const orangeGradient = [sandyBrown, sandyBrown];
// const yellowGradient = [mustard, mustard];
// const whiteGradient = [textcolor, textcolor];
// const Color periwinkleGrey = Color(0xFFB7BEE3);
// const Color olivine = Color(0xFF8EB685);
// const Color persianIndigo = Color(0xFF53168F);
// final kNeumorphicColors = [emerald, concrete, mustard, burntSienna];

// //chip background
// const Color chipBackgroundOne = Color(0xff303238);
// const Color chipBackgroundTwo = Color(0xff211F20);

// //card background
// const Color cardBackgroundOne = Color(0xff303238);

// //buttonColor
// const Color buttonColorFive = Color(0xffEB5757);

// // borderLineColor
// const Color borderLineColor = Color(0xFF282828);

// //addUserbgColor
// const addUserBgColor = Color(0XFF0C0B0B);

// //blue/white theme
// const backgroundColor1 = Color(0XFFFFFFFF);
// const appBarbackgroundColor1 = Color(0XFF0C0B0B);
// const cardBackgroundColor1 = Color(0XFFFFFFFF);
// const cardSelectedBackgroundColor1 = Color(0XFFFFFFFF);
// const textColor1 = Color(0XFF000000);
// const iconColor1 = Color(0XFF000000);
// const textSelectedColor1 = Color(0XFF000000);
// const buttonColor1 = Color(0XFF00437A);
// const buttonColor2 = Color(0XFFFFFFFF);
// const buttonSelectedColor1 = Color(0XFF00437A);
// const dividerColor1 = Color(0XFF000000);
// const upperCardColor1 = Color(0XFFFFFFFF);

// //orange/black theme
// const backgroundColor2 = Color(0xFF211F20);
// const backgroundColor3 = Color(0XFFFFFFFF);
// const appBarbackgroundColor2 = Color(0XFFFFFFFF);
// const cardBackgroundColor2 = Colors.white;
// const cardSelectedBackgroundColor2 = Color(0XFF000000);
// const textColor2 = Color(0XFF000000);
// const iconColor2 = Color(0XFF000000);
// const textSelectedColor2 = Color(0XFFFFFFFF);
// const buttonColor21 = Color(0xffF37021);
// const buttonColor22 = Color(0XFF000000);
// const buttonSelectedColor2 = Color(0xffF37021);
// const dividerColor2 = Color(0XFF000000);
// const upperCardColor2 = Color(0xFF414042);

// var indiaStackBlueWhite = ThemeData(
//     cardColor: cardBackgroundColor1,
//     backgroundColor: backgroundColor1,
//     fontFamily: 'Roboto',
//     buttonColor: buttonColor1,
//     primaryColor: backgroundColor1,
//     dividerColor: dividerColor1,
//     indicatorColor: upperCardColor1,
//     canvasColor: buttonColor1,
//     iconTheme: IconThemeData(
//       color: iconColor1,
//     ),
//     cardTheme: CardTheme(
//         color: cardBackgroundColor1,
//         elevation: 10.0,
//         shadowColor: cardBackgroundColor1,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//             side: BorderSide(color: Colors.white, width: 1))),
//     buttonTheme: ButtonThemeData(
//       buttonColor: buttonColor1,
//     ),
//     accentTextTheme: TextTheme(bodyText1: TextStyle(color: textColor1)),
//     primaryTextTheme: TextTheme(
//         bodyText1: TextStyle(color: textColor1, fontWeight: FontWeight.bold)),
//     textTheme: TextTheme(
//         bodyText1: TextStyle(color: textColor1),
//         subtitle1: TextStyle(color: textColor1)),
//     appBarTheme: AppBarTheme(backgroundColor: Colors.white),
//     accentColor: Colors.white);

// var indiaStackOrangeBlack = ThemeData(
//     cardColor: cardBackgroundColor2,
//     backgroundColor: backgroundColor3,
//     fontFamily: 'Roboto',
//     buttonColor: buttonColor21,
//     dividerColor: dividerColor2,
//     indicatorColor: upperCardColor2,
//     canvasColor: Colors.white,
//     iconTheme: IconThemeData(
//       color: iconColor2,
//     ),
//     primaryColor: backgroundColor3,
//     cardTheme: CardTheme(
//         color: cardBackgroundColor2,
//         elevation: 10.0,
//         shadowColor: Colors.black.withOpacity(0.5),
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//             side: BorderSide(color: cardBackgroundColor2, width: 1))),
//     buttonTheme: ButtonThemeData(
//       buttonColor: buttonColor21,
//     ),
//     accentTextTheme: TextTheme(bodyText1: TextStyle(color: textColor2)),
//     primaryTextTheme: TextTheme(bodyText1: TextStyle(color: textColor2)),
//     textTheme: TextTheme(
//       bodyText1: TextStyle(color: textColor2),
//     ),
//     appBarTheme: AppBarTheme(
//       backgroundColor: appBarbackgroundColor2,
//     ),
//     accentColor: Colors.white);
