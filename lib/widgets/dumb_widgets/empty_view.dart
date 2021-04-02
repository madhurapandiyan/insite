import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cod_grey,
      child: Center(
        child: Text("Coming soon!",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
    );
  }
}
