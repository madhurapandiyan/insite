import 'package:flutter/material.dart';

class SingleAssetOperationChartData {
  @required
  final DateTime startTime;
  @required
  final DateTime endTime;
  @required
  final String localDate;

  SingleAssetOperationChartData(this.startTime, this.endTime, this.localDate);
}
