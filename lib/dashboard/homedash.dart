import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/dashboard/model.dart';
import 'package:insite/theme/colors.dart';

class HomeDash extends StatefulWidget {
  @override
  _HomeDashState createState() => _HomeDashState();
}

class _HomeDashState extends State<HomeDash> {
  int selectedcard = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: appbarcolor,
        leading: IconButton(
          icon: new SvgPicture.asset("assets/images/menubar.svg"),
          onPressed: () {
            print("button is tapped");
          },
        ),
        actions: [
          new IconButton(
              icon: new SvgPicture.asset("assets/images/searchs.svg"),
              onPressed: () => ("button is tapped"))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                margin: EdgeInsets.all(10.0),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(16.0),
                        sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width > 1000
                                            ? 7
                                            : MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    600
                                                ? 5
                                                : 3,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 5.0),
                            delegate: SliverChildBuilderDelegate(
                              _buildCategoryItem,
                              childCount: categories.length,
                            )),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    Category category = categories[index];
    return GestureDetector(
      onTap: () {
        buttontap(index);
      },
      child: Container(
        width: 118.71,
        height: 111,
        child: Card(
          semanticContainer: true,
          color: selectedcard == index ? tango : cardcolor,
          elevation: 10.0,
          margin: EdgeInsets.all(1.0),
          shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(category.image),
              SizedBox(height: 8.0),
              Text(
                category.name,
                 
                style: new TextStyle(fontSize: 12.0,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: textcolor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buttontap(int index) {
    if (index == 0) {
      setState(() {
        selectedcard = index;
      });
    }
    if (index == 1) {
      setState(() {
        selectedcard = index;
      });
    }
    if (index == 2) {
      setState(() {
        selectedcard = index;
      });
    }
    if (index == 3) {
      setState(() {
        selectedcard = index;
      });
    }
    if (index == 4) {
      setState(() {
        selectedcard = index;
      });
    }
  }
}
