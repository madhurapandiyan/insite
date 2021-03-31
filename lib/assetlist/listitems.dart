import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/assetlist/model.dart';
import 'package:insite/theme/colors.dart';

class AssetList extends StatefulWidget {
  @override
  _AssetListState createState() => _AssetListState();
}

class _AssetListState extends State<AssetList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          backgroundColor: appbarcolor,
          leading: IconButton(
              icon: SvgPicture.asset("assets/images/menubar.svg"),
              onPressed: () {
                print("button is tapped");
              }),
          actions: [
            new IconButton(
              icon: SvgPicture.asset("assets/images/filter.svg"),
              onPressed: () => print("button is tapped"),
            ),
            new IconButton(
              icon: SvgPicture.asset("assets/images/searchs.svg"),
              onPressed: () => print("button is tapped"),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
                      child: Column(
              children: [
                ListView.builder(
                  itemCount: transportlist.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        width: 387,
        height: 86,
        //color: cardcolor,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
          border: Border.all(width: 2.5, color: cardcolor),
          shape: BoxShape.rectangle,
        ),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Stack(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 55, top: 15, left: 5, right: 12),
                          child:
                              SvgPicture.asset(transportlist[index].arrowimage),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 98.0, bottom: 43.0,top: 6.0),
                          child: new Text(
                           transportlist[index].title,style: new TextStyle(
                             fontSize:13.0,
                             fontFamily: 'Roboto',
                             fontWeight:FontWeight.w700,
                             fontStyle: FontStyle.normal,
                             color: textcolor
                           ),
                          ),
                        ),
                        Padding(
                          child: new Text(transportlist[index].status,style:
                          new TextStyle(
                             fontSize:13.0,
                             fontFamily: 'Roboto',
                             fontWeight:FontWeight.w400,
                             fontStyle: FontStyle.normal,
                             color: textcolor
                           ),),
                          padding: EdgeInsets.only(left: 230,top: 6.0),
                        )
                      ]),
                  ],
                  ),
                ],
              ),
            )
          ],
        )
        );
                 
                })
              ],
            ),
          ),
        ));
  }

}
