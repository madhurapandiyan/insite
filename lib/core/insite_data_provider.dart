import 'package:flutter/material.dart';

class InsiteInheritedDataProvider extends InheritedWidget {
  final int count;
  InsiteInheritedDataProvider({
    Widget child,
    this.count,
  }) : super(child: child);
  @override
  bool updateShouldNotify(InsiteInheritedDataProvider oldWidget) =>
      count != oldWidget.count;
  static InsiteInheritedDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InsiteInheritedDataProvider>();
}