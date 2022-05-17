import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class DashBoardContainer extends StatefulWidget {
  DashBoardContainer(
      {Key? key,
      this.subTitle1,
      this.subTitle2,
      this.title,
      this.height,
      this.cards})
      : super(key: key);
  final String? title;
  final String? subTitle1;
  final String? subTitle2;
  final double? height;
  //final List viewData;
  //List<Widget> cards;
  final Widget? cards;

  @override
  _DashBoardContainerState createState() => _DashBoardContainerState();
}

class _DashBoardContainerState extends State<DashBoardContainer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                 // color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InsiteText(
                        text: widget.title,
                        fontWeight: FontWeight.w700,
                        size: 12.0),
                  ),
                  Divider(
                    thickness: 1,
                    color: thunder,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InsiteText(
                            text: widget.subTitle1,
                            fontWeight: FontWeight.w700,
                            size: 12.0),
                        InsiteText(
                            text: widget.subTitle2,
                            fontWeight: FontWeight.w700,
                            size: 12.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            widget.cards!
            // Expanded(
            //   child: ListView(
            //     children: widget.cards,
            //   ),
            // )
            // Expanded(
            //     child: ListView.builder(
            //         itemCount: widget.viewData.length,
            //         itemBuilder: (context, index) {
            //           final result = widget.viewData[index];
            //           return InsiteDashRow(
            //             rowText: "Total Devices Supplied",
            //             buttonText: "3456",
            //             result: result,
            //           );
            //         }))
          ],
        ),
      ),
    );
  }
}
