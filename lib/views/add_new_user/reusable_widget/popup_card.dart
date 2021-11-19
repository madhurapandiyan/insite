import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class PopupCard extends StatelessWidget {
  const PopupCard({this.rows, this.cardTitle, this.height});
  final List<Widget> rows;
  final String cardTitle;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InsiteText(
                text: cardTitle,
                size: 20,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).buttonColor,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rows,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
