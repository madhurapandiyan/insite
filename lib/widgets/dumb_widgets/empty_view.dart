import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class EmptyView extends StatelessWidget {
  final String title;
  const EmptyView({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cod_grey,
      alignment: Alignment.center,
      child: Center(
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
    );
  }
}
