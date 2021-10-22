import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/reuse_dashRow.dart';

class DashBoardContainer extends StatefulWidget {
  DashBoardContainer({Key key, this.subTitle1, this.subTitle2, this.title})
      : super(key: key);
  final String title;
  final String subTitle1;
  final String subTitle2;

  @override
  _DashBoardContainerState createState() => _DashBoardContainerState();
}

class _DashBoardContainerState extends State<DashBoardContainer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 400,
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
                  color: Theme.of(context).indicatorColor,
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
            Expanded(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return InsiteDashRow(
                        rowText: "Total Devices Supplied",
                        buttonText: "3456",
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
