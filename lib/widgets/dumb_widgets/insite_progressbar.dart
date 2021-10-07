import 'package:flutter/material.dart';

class InsiteProgressBar extends StatelessWidget {
  const InsiteProgressBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).buttonColor,
      ),
    );
  }
}
